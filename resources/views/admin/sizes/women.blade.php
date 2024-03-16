<div id="women">
    <div class="card">
        <div class="card-body">
            <form method="post" action="<?php echo route('admin.size.add') ?>" class="form-validation">
                <!--!! CSRF FIELD !!-->
                {{ @csrf_field() }}
                <h6 class="heading-small text-muted mb-4">Female Size information</h6>
                <div class="pl-lg-4">
                    <div v-for="(men, index) in mens" :key="index" >
                        <div class=" mt-2 d-flex border rounded position-relative pe-0">
                            <div class="row w-100 p-3">
                                <input type="hidden" value="Female" :name="'mens[' + index + '][type]'" >
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="form-control-label" for="input-first-name">Size Type</label>
                                        <input type="text" class="form-control" :name="'mens[' + index + '][size_title]'"   required placeholder="XL" value="{{ old('color_code') }}">
                                        @error('color_code')
                                            <small class="text-danger">{{ $message }}</small>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="form-control-label" for="input-first-name">From cm</label>
                                        <input type="number" class="form-control" :name="'mens[' + index + '][from_cm]'"  required placeholder="From cm" value="{{ old('color_code') }}" min="0">
                                        @error('color_code')
                                            <small class="text-danger">{{ $message }}</small>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="form-control-label" for="input-first-name">To cm</label>
                                        <input type="number" class="form-control" :name="'mens[' + index + '][to_cm]'"  required placeholder="To cm" value="{{ old('color_code') }}" min="0">
                                        @error('color_code')
                                            <small class="text-danger">{{ $message }}</small>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="form-control-label" for="input-first-name">Chest</label>
                                        <input type="number" class="form-control" :name="'mens[' + index + '][chest]'"  required placeholder="Chest" value="{{ old('color_code') }}" min="0">
                                        @error('color_code')
                                            <small class="text-danger">{{ $message }}</small>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="form-control-label" for="input-first-name">Waist</label>
                                        <input type="number" class="form-control" :name="'mens[' + index + '][waist]'"  required placeholder="Waist" value="{{ old('color_code') }}" min="0">
                                        @error('color_code')
                                            <small class="text-danger">{{ $message }}</small>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="form-control-label" for="input-first-name">Hip</label>
                                        <input type="number" class="form-control" :name="'mens[' + index + '][hip]'"  required placeholder="Hip" value="{{ old('color_code') }}" min="0">
                                        @error('color_code')
                                            <small class="text-danger">{{ $message }}</small>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="form-control-label" for="input-first-name">Length</label>
                                        <input type="number" class="form-control" :name="'mens[' + index + '][length]'"  required placeholder="Length" value="{{ old('color_code') }}" min="0">
                                        @error('color_code')
                                            <small class="text-danger">{{ $message }}</small>
                                        @enderror
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-2">
                        <a href="javascript:;" v-on:click="addForm" class="mr-0 mt-2 mb-2 btn btn-sm btn-primary float-right">
                            <i class="fa fa-plus"></i> Add
                        </a>
                    </div>
                </div>
                <hr class="my-4" />
                <button href="#" class="btn btn-sm py-2 px-3 btn-primary float-right">
                    <i class="fa fa-save"></i> Submit
                </button>
            </form>
        </div>
    </div>
</div>