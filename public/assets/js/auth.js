let auth = new Vue({
    el: '#auth',
    data: {
    mounting: true,
    loading: false,
    loginloading: false
    },
    mounted: function() {
        this.mounting = false;
    },
    methods: {
        register: async function() {
            // if ($('#register-form')[0].checkValidity()) {
                this.loading = true;
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                if (password !== confirmPassword) {
                    set_notification('error','Passwords do not match');
                    this.loading = false;
                    return false;
                }
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
                    set_notification('error', response.message);
                }
            // }
            // else{
            //     return false;
            // }
        },    
        login: async function() {
            // if ($('#register-form')[0].checkValidity()) {
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
                    set_notification('error', response.message);
                }
            // }
            // else{
            //     return false;
            // }
        },  
    },
});