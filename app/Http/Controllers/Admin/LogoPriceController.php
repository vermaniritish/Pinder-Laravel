<?php

/**
 * Pages Class
 *
 * @package    PagesController 
 * @version    Release: 1.0.0
 * @since      Class available since Release 1.0.0
 */


namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Admin\Permissions;
use App\Models\Admin\Admins;
use Illuminate\Validation\Rule;
use App\Http\Controllers\Admin\AppController;
use App\Models\Admin\LogoPrices;
use App\Models\Admin\Settings;

class LogoPriceController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

    function index(Request $request)
    {
    	if(!Permissions::hasPermission('logo_prices', 'listing'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}
		$filters = $this->filters($request);
		$logoPositions = Settings::get('logo_positions');
		return view(
			"admin/logoPrices/index", 
			[
				'admins' => $filters['admins'],
				'logoPositions' => $logoPositions
			]
		);
    }

    function filters(Request $request)
    {
		$admins = [];
		$adminIds = LogoPrices::distinct()->whereNotNull('created_by')->pluck('created_by')->toArray();
		if($adminIds)
		{
	    	$admins = Admins::getAll(
	    		[
	    			'admins.id',
	    			'admins.first_name',
	    			'admins.last_name',
	    			'admins.status',
	    		],
	    		[
	    			'admins.id in ('.implode(',', $adminIds).')'
	    		],
	    		'concat(admins.first_name, admins.last_name) desc'
	    	);
	    }
    	return [
	    	'admins' => $admins
    	];
    }

    function add(Request $request)
    {
    	if(!Permissions::hasPermission('logo_prices', 'create'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}
    	if($request->isMethod('post'))
    	{
			$data = $request->toArray();
    		unset($data['_token']);
			if (!empty($data)) {
				$validator = Validator::make($request->all(), [
					'type' => ['required', Rule::in(['Male','Female','Unisex', 'Kids'])],
					'mens.*.size_title' => ['distinct','required','string','max:255'], 
					'mens.*.from_cm' => 'nullable|numeric|min:0',
					'mens.*.to_cm' => 'nullable|numeric|min:0',
					'mens.*.chest' => 'nullable|numeric|min:0',
					'mens.*.waist' => 'nullable|numeric|min:0',
					'mens.*.hip' => 'nullable|numeric|min:0',
					'mens.*.length' => 'nullable|numeric|min:0',
				]);
				if(!$validator->fails())
				{
					LogoPrices::where('type',$data['type'])->delete();
					foreach ($request->mens as $item) {
							$item['type'] = $data['type'];
							LogoPrices::create($item);
					}
					$request->session()->flash('success', 'Size created successfully.');
					return redirect()->back();
				}
				else
				{
					$request->session()->flash('error', 'Please provide valid inputs.');
					return redirect()->back()->withErrors($validator)->withInput();
				}
			}
			else {
				$request->session()->flash('error', 'Please provide valid inputs.');
				return redirect()->back()->withErrors(['mens' => 'Data is empty.'])->withInput();
			}
		}

	    return view("admin/logoPrices/add", [
	    		]);
    }

    function delete(Request $request, $id)
    {
    	if(!Permissions::hasPermission('logo_prices', 'delete'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$admin = LogoPrices::find($id);
    	if($admin->delete())
    	{
    		$request->session()->flash('success', 'Staff deleted successfully.');
    		return redirect()->route('admin.size');
    	}
    	else
    	{
    		$request->session()->flash('error', 'Staff could not be delete.');
    		return redirect()->route('admin.size');
    	}
    }

	public function getLogoPrices()
	{
		$logoPrices = LogoPrices::select('id', 'position', 'option', 'from_quantity', 'to_quantity', 'price')->get();
		$logoPositions = json_decode((string)Settings::get('logo_positions'), true);
		$formattedLogoPositions = [];
		foreach ($logoPositions as $position) {
			$formattedKey = strtolower(str_replace([' ', '/'], '-', $position));
			$formattedLogoPositions[$position] = $formattedKey;
		}
		return response()->json(
			[
				'status' => true,
				'data' => $logoPrices,
				'logoPositions' => $formattedLogoPositions
			]
		);
	}

}
