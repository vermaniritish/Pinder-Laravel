let auth = new Vue({
    el: '#auth',
    data: {
    mounting: true,
    loading: false,
    },
    mounted: function() {
        this.mounting = false;
    },
    methods: {
        register: async function() {
            if ($('#register-form')[0].checkValidity()) {
console.log('byi');
this.loading = true;
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                if (password !== confirmPassword) {
                    set_notification('error','Passwords do not match');
                    this.loading = false;
                    return false;
                }
console.log('hi');
                const termsConditionsChecked = document.getElementById('check2').checked;
                if (!termsConditionsChecked) {
                    set_notification('error','Please agree to the terms & conditions');
                    this.loading = false;
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
                this.loading = false;
            }
            else{
                return false;
            }
        },    
    },
});