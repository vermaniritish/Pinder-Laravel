<div class="col">
    <div class="account__login register">
        <div class="account__login--header mb-25">
            <h2 class="account__login--header__title h3 mb-10">Create an Account</h2>
            <p class="account__login--header__desc">Register here if you are a new customer</p>
        </div>
        <div class="account__login--inner">
            <form id="register-form">
                <input required class="account__login--input" name="first_name" placeholder="First Name" type="text">
                <input required class="account__login--input" name="email" placeholder="Email Addres" type="email">
                <input required class="account__login--input" name="password" placeholder="Password" id="password" type="password">
                <input required class="account__login--input" name="password_confirmation" placeholder="Confirm Password" id="confirmPassword" type="password">
                <button type="button" class="account__login--btn primary__btn mb-10" v-on:click="register()"><i class="fa fa-spin fa-spinner" v-if="loading"></i>Submit & Register </button>
                <div class="account__login--remember position__relative">
                    <input class="checkout__checkbox--input" id="check2" type="checkbox">
                    <span class="checkout__checkbox--checkmark"></span>
                    <label class="checkout__checkbox--label login__remember--label" for="check2">
                        I have read and agree to the terms & conditions</label>
                </div>
            </form>
        </div>
    </div>
</div>