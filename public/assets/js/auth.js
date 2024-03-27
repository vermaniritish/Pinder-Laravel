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
            }
            else{
                return false;
            }
        },    
            
    },
});

function set_notification(type, text, placementFrom, placementAlign, animateEnter, animateExit)
{

    if(type == 'success')
        var colorName = 'bg-green';
    else if(type == 'error')
        var colorName = 'bg-red';
    else
        var colorName = 'bg-black';

    if (!placementFrom) { placementFrom = 'bottom'; }
    if (!placementAlign) { placementAlign = 'right'; }
    if (!animateEnter) { animateEnter = 'animated fadeInDown'; }
    if (!animateExit) { animateExit = 'animated fadeOutUp'; }


    var allowDismiss = true;

    $.notify({
        message: text
    },
    {
        type: colorName,
        allow_dismiss: allowDismiss,
        newest_on_top: true,
        timer: 500000,
        offset: {
            "x": 30,
            "y": 50
        },
        placement: {
            from: placementFrom,
            align: placementAlign
        },
        animate: {
            enter: animateEnter,
            exit: animateExit
        },
        template: '<div data-notify="container" class="bootstrap-notify-container alert alert-dismissible {0} ' + (allowDismiss ? "p-r-35" : "") + '" role="alert">' +
        '<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
        '<span data-notify="icon"></span> ' +
        '<span data-notify="title">{1}</span> ' +
        '<span data-notify="message">{2}</span>' +
        '<div class="progress" data-notify="progressbar">' +
        '<div class="progress-bar progress-bar-{0}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>' +
        '</div>' +
        '<a href="{3}" target="{4}" data-notify="url"></a>' +
        '</div>'
    });
}