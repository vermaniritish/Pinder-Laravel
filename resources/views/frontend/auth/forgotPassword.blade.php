@extends('layouts.frontendlayout')
@section('content')
{{-- <?php require_once 'header-top.php'; ?>
<?php require_once 'header-bottom.php'; ?> --}}
    <!-- Start login section  -->
        <div class="login__section section--padding">
            <div class="container">
                <div class="login__section--inner">
                    <div id="auth" class="row row-cols-md-2 row-cols-1">
                        <div class="col">
                            <div class="account__login">
                                <div class="account__login--header mb-25">
                                    <h2 class="account__login--header__title h3 mb-10">Forgot Password</h2>
                                    <p class="account__login--header__desc">Enter email to recover password.</p>
                                </div>
                                <div class="account__login--inner">
                                    <form id="forgot-form">
                                        <input class="account__login--input" required name="email" placeholder="Email Address" type="text">
                                        <button class="account__login--btn primary__btn" v-on:click="postForgotPassword()" type="button"><i class="fa fa-spin fa-spinner" v-if="forgotLoading"></i>Submit</button>
                                        <p class="account__login--signup__text">Don,t Have an Account? <button type="button">Sign up now</button></p>
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