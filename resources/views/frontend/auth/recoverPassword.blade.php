@extends('layouts.frontendlayout')
@section('content')
{{-- <?php require_once 'header-top.php'; ?>
<?php require_once 'header-bottom.php'; ?> --}}
    <!-- Start login section  -->
        <div class="login__section section--padding">
            <div class="container">
                <div class="login__section--inner">
                    <div id="recoverPassword" class="row row-cols-md-2 row-cols-1">
						<div class="col">
							<div class="account__login">
								<div class="account__login--header mb-25">
									<h2 class="account__login--header__title h3 mb-10">Recover Password!</h2>
									<p class="account__login--header__desc">Create new password for account.</p>
								</div>
								<div class="account__login--inner">
									<form id="recover-password-form">
						                <input required class="account__login--input" name="password" placeholder="New Password" id="new_password" type="new_password">
										<div v-if="errorMessages.password" class="text-danger text-center">@{{ errorMessages.password }}</div>
										<input required class="account__login--input" name="confirm_password" placeholder="Confirm Password" type="password">
										<div v-if="errorMessages.confirm_password" class="text-danger text-center">@{{ errorMessages.confirm_password }}</div>
										<button class="account__login--btn primary__btn" v-on:click="recovePassword()" type="button"><i class="fa fa-spin fa-spinner" v-if="loading"></i>Verify</button>
									</form>
								</div>
							</div>
						</div>	
                    </div>
                </div>
            </div>     
        </div>
    <!-- End login section  -->
	<script src="<?php echo url('assets/js/auth.js') ?>"></script>
@endsection