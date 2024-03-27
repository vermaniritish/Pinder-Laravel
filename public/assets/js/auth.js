let auth = new Vue({
    el: '#auth',
    data: {
    mounting: true
    },
    mounted: function() {
        this.mounting = false;
    },
    methods: {
        register: async function() {
            if ($('#register-form')[0].checkValidity()) {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                if (password !== confirmPassword) {
                    set_notification('error','Passwords do not match');
                    return false;
                }

                const termsConditionsChecked = document.getElementById('check2').checked;
                if (!termsConditionsChecked) {
                    set_notification('error','Please agree to the terms & conditions');
                    return false;
                }

                let formData = new FormData(document.getElementById('register-form'));
                let response = await fetch(admin_url + '/auth/register', {
                    method: 'POST',
                    body: formData,
                });
                response = await response.json();
                if(response && response.status)
                {
                    setTimeout(function () {
                        window.location.href = (admin_url + '/order/' + response.id + '/view');
                    }, 200)
                }else{
                    set_notification('error', response.message);
                }
            }
            else{
                return false;
            }
        },    
    },
});