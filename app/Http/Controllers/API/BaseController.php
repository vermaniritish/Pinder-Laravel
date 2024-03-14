<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Helpers\CollectionHelper;
use App\Http\Controllers\Controller;
use App\Http\DynamicFilters;
use App\Http\DynamicFilters\DynamicFilter;
use App\Http\ModelFilters\ModelFilter;
use App\Http\ResourceFilters\ResourceFilter;
use Arr;
use Closure;
use Illuminate\Http\Response;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Str;

class BaseController extends Controller
{
    /**
     * Return a success JSON response.
     *
     * @param  mixed  $data
     * @param  int  $code
     * @param  string|null  $message
     * @return \Illuminate\Http\JsonResponse
     */
    public function success($data, int $code = 200, string $message = null)
    {
        return response()->json([
            'message' => $message,
            'data' => $data
        ], $code);
    }

    /**
     * Return an error JSON response.
     *
     * @param  string  $message
     * @param  int  $code
     * @param  array|string|null  $errors
     * @return \Illuminate\Http\JsonResponse
     */
    public function error(string $message = null, int $code, $errors = null)
    {
        return response()->json([
            'message' => $message,
            'errors' => $errors
        ], $code);
    }

    /**
     * Applies filter, sorting, projection & pagination to data.
     */
    public function indexedCollectionData(
        Request $request,
        Collection $data,
        string|null $sort_by = 'id',
        ResourceFilter|null $filter = null,
        Closure|null $prepare_filter_data = null,
    ): Collection|LengthAwarePaginator {
        $per_page = (int) $request->get('per_page', 15);
        $direction = $request->query('direction');
        $sort_by = $request->query('sort_by') ?: $sort_by;
        $project = request()->query('project');
        $query = $request->query('query') ? $request->query('query') : '';

        if (empty($direction) || !in_array($direction, ['asc', 'desc'])) {
            $direction = 'asc';
        }

        //* Apply filters
        if (!is_null($filter)) {
            if (!is_null($prepare_filter_data)) {
                $data = call_user_func($prepare_filter_data, $data);
            }

            $data = $filter->filter($data);
        }

        //* Sort data
        $data = $data->sortBy($sort_by, SORT_REGULAR, $direction == 'desc')->values();

        //* Search
        if ($query) {
            $data = $data->filter(function ($item) use ($query) {
                // Iterate through all fields of the item
                foreach ($item as $field) {
                    if (str_contains($field, $query)) {
                        return true; // Return the item if the search term is found in any field
                    }
                }

                return false;
            });
        }

        if (!empty($project)) {
            $fields = Str::of($project)->split('/,/', -1, PREG_SPLIT_NO_EMPTY);

            $data = $data->map(function ($item) use ($fields) {
                return collect(Arr::dot_only(collect($item)->toArray(), $fields->toArray()));
            });
        }

        //* Apply pagination
        if ($per_page > 0) {
            $data = CollectionHelper::paginate($data, $per_page);
        }

        return $data;
    }

    /**
     * Display a listing of the resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Illuminate\Database\Eloquent\Model  $model
     * @param  array  $scopes
     * @param  ResourceFilter|null  $filter
     * @param  Closure|null  $prepare_filter_data
     * @param  string|null  $default_sort_by_column
     * @return \Illuminate\Http\JsonResponse
     */
    public function _index(
        Request $request,
        $model,
        $resource = null,
        array $scopes = [],
        ModelFilter|null $filter = null,
        string|null $default_sort_by_column = null,
        string $default_sort_by_direction = 'asc',
    ) {
        $table_name = (new $model())->getTable();
        $primary_key = (new $model())->getKeyName();
        if (empty($default_sort_by_column)) {
            $default_sort_by_column = $primary_key;
        }

        $input = $request->validate([
            'query' => ['nullable', 'string'],
            'sort_by' => ['nullable', 'string'],
            'direction' => ['string'],
            'per_page' => ['int', 'gt:0', 'lte:100'],
        ]);

        $query = isset($input['query']) ? $input['query'] : '';
        $sort_by = isset($input['sort_by']) ? $input['sort_by'] : $default_sort_by_column;
        $direction = isset($input['direction']) ? $input['direction'] : $default_sort_by_direction;
        $per_page = (int) (isset($input['per_page']) ? $input['per_page'] : 15);

        if (empty($direction) || !in_array($direction, ['asc', 'desc'])) {
            $direction = 'asc';
        }
        if (empty($sort_by) || !in_array($sort_by, Schema::getColumnListing($table_name))) {
            $sort_by = $default_sort_by_column;
        }

        $db_query = $model::query();

        //* Apply query scopes
        foreach ($scopes as $scope) {
            $db_query = $db_query->$scope();
        }

        //* Apply filters
        if (!is_null($filter)) {
            $db_query = $filter->filter($db_query);
        }

        //* Search model
        if ($query) {
            if (method_exists((new $model()), 'toSearchableArray')) {
                $searchable_columns = (new $model())->toSearchableArray();
                $db_query->where(function ($db_query) use ($searchable_columns, $query) {
                    foreach ($searchable_columns as $column) {
                        $db_query->orWhere($column, 'LIKE', '%' . $query . '%');
                    }
                });
            }
        }

        //* Apply sorting
        $db_query->orderBy($sort_by, $direction);

        //* Apply pagination
        $results = $db_query->paginate($per_page);

        //* Apply resource
        if (!is_null($resource)) {
            $results = $resource::collection($results)->resource;
        } else {
            $results = $results;
        }

        return $this->success($results, Response::HTTP_OK);
    }


    public function getSortBy(Request $request, string|null $default = null, string|null $model = null): string|null
    {
        $input = $this->validate($request, [
            'sortBy' => ['nullable', 'string'],
        ]);
        $sort_by = $input['sortBy'] ?? $default;

        if ($sort_by && $model) {
            $table_name = (new $model())->getTable();
            if (!in_array($sort_by, Schema::getColumnListing($table_name))) {
                $sort_by = $default;
            }
        }

        return $sort_by;
    }

    public function getSortByDirection(Request $request, string $default = 'asc'): string
    {
        $input = $this->validate($request, [
            'direction' => ['string', 'in:asc,desc']
        ]);

        return isset($input['direction']) ? $input['direction'] : $default;
    }

    public function getPerPage(Request $request, int $default = 15): int
    {
        $input = $this->validate($request, [
            'per_page' => ['int', 'gt:0', 'lte:100'],
        ]);

        return (int) (isset($input['per_page']) ? $input['per_page'] : $default);
    }

}
