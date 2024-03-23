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
        initEditValues: function () {
            if ($('#edit-form').length > 0) {
                let data = JSON.parse($('#edit-form').text());
                this.url = admin_url + '/products/' + data.id + '/edit';
            }
            else {
                this.url = admin_url + '/products/add';
            };
        },
        updateSelectedSize: function(){
            for (let sizeId of this.selectedSize) {
                let size = this.sizes.find(s => s.id === sizeId);
                if (size) {
                    size.price = 0; 
                    this.selectedSize.push(size);
                }
            }
        },
        removeSize(index, sizeId) {
            this.sizes.splice(index, 1);
            this.selectedSize = this.selectedSize.filter(id => id !== sizeId); 
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
        submitForm: async function() {
            let formData = new FormData(document.getElementById('product-form'));
            let productIdsAndQuantities = this.productsData.map(product => ({ id: product.id, quantity: product.quantity }));
            formData.append('sizeData', JSON.stringify(productIdsAndQuantities));
            let response = await fetch(this.url, {
                method: 'POST',
                body: formData,
            });
            response = await response.json();
            if(response && response.status)
            {
                setTimeout(function () {
                    window.location.href = (admin_url + '/products/' + response.id + '/view');
                }, 200)
            }else{
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