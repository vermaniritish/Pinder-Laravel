let auth = new Vue({
    el: '#auth',
    data: {
    mounting: true,
    loading: false,
    loginloading: false,
    forgotLoading: false,
    showLoginForm: true,
    showRegisterForm: true,
    showForgotPasswordForm: false,
    loginErrorMessages: {} ,
    registerErrorMessages: {},
    forgotErrorMessages: {}
    },
    mounted: function() {
        this.mounting = false;
    },
    methods: {
        register: async function() {
            if ($('#register-form').valid()) {
                this.loading = true;
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                const termsConditionsChecked = document.getElementById('check2').checked;
                if (!termsConditionsChecked) {
                    set_notification('error','Please agree to the terms & conditions');
                    this.loading = false;
                    return false;
                }

                let formData = new FormData(document.getElementById('register-form'));
                formData.append('_token', csrf_token()); 
                let response = await fetch(site_url+'/auth/register', {
                    method: 'POST',
                    body: formData,
                });
                response = await response.json();
                if(response && response.status)
                {
                    this.loading = false;
                    set_notification('success', response.message);

                }else{
                    this.loading = false;
                    this.registerErrorMessages = {};
                    for (let field in response.message) {
                        if (Array.isArray(response.message[field])) {
                            this.$set(this.registerErrorMessages, field, response.message[field].join(', '));
                        } else {
                            this.$set(this.registerErrorMessages, field, response.message[field]);
                        }
                    }
                }
            }
            else{
                return false;
            }
        },    
        login: async function() {
            if ($('#login-form').valid()) {
                this.loginloading = true;
                let formData = new FormData(document.getElementById('login-form'));
                formData.append('_token', csrf_token()); 
                let response = await fetch(site_url+'/auth/login', {
                    method: 'POST',
                    body: formData,
                });
                response = await response.json();
                if(response && response.status)
                {
                    this.loginloading = false;
                    set_notification('success', response.message);

                }else{
                    this.loginloading = false;
                    this.loginErrorMessages = {};
                    for (let field in response.message) {
                        if (Array.isArray(response.message[field])) {
                            this.$set(this.loginErrorMessages, field, response.message[field].join(', '));
                        } else {
                            this.$set(this.loginErrorMessages, field, response.message[field]);
                        }
                    }
                }
            }
            else{
                return false;
            }
        },  
        showForgotPassword: function() {
            this.showLoginForm = false;
            this.showRegisterForm = false;
            this.showForgotPasswordForm = true;
        },
        disableForgotPassword: function() {
            this.showLoginForm = true;
            this.showRegisterForm = true;
            this.showForgotPasswordForm = false;
        },
        postForgotPassword: async function(){
            if ($('#forgot-form').valid()) {
                this.forgotLoading = true;
                let formData = new FormData(document.getElementById('forgot-form'));
                formData.append('_token', csrf_token()); 
                let response = await fetch(site_url+'/auth/forgot-password', {
                    method: 'POST',
                    body: formData,
                });
                response = await response.json();
                if(response && response.status)
                {
                    this.forgotLoading = false;
                    set_notification('success', response.message);

                }else{
                    this.forgotLoading = false;
                    this.forgotErrorMessages = {};
                    for (let field in response.message) {
                        if (Array.isArray(response.message[field])) {
                            this.$set(this.forgotErrorMessages, field, response.message[field].join(', '));
                        } else {
                            this.$set(this.forgotErrorMessages, field, response.message[field]);
                        }
                    }
                }
            }
            else{
                return false;
            }
        }
    },
});