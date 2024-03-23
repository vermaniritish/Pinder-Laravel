let order = new Vue({
    el: '#product',
    data: {
        mounting: true,
        sizes: [],
        selectedSize: [],
        selectedGender: ''
    },
    mounted: function() {
        this.initBasics();
        this.mounting = false;
    },
    methods: {
        initBasics: function () {
            setTimeout(function () {
                $('select').removeClass('no-selectpicker');
                initSelectpicker('select');
            }, 50);
        },
        updateSizes: async function() {
            let response = await fetch(admin_url + "/products/getSize/" + this.selectedGender);
            response = await response.json();
            if(response && response.status)
            {
                this.sizes = response.sizes;
                setTimeout(function () {
                    $("#size-form select").selectpicker("refresh");
                }, 50);
            } else{
                set_notification('error', response.message);
            }
        },
    },
    watch: {
        selectedGender: function () {
            this.updateSizes();
        },
    },
});