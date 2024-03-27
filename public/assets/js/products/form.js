let order = new Vue({
    el: '#product',
    data: {
        mounting: true,
        sizes: [],
        selectedSize: [],
        selectedSizeIds: [],
        selectedCategory: null,
        subCategories: [],
        selectedGender: '',
        title: '',
        selectedColor: '',
        price: '',
        salePrice: '',
        selectedBrand: [],
        durationOfService: '',
        loading: false,
        url: '',
        selectedSubCategory: []
    },
    mounted: function() {
        this.initEditValues();
        this.initBasics();
        this.initTagIt();
        this.mounting = false;
        document.getElementById('product-form').classList.remove('d-none');
    },
    methods: {
        initTagIt: function () {
            $(".tag-it").tagit();
        },
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
                this.selectedSubCategory = data && data.subCategories && data.subCategories.length > 0 ? data.subCategories.map(category => category.id) : [];
                this.selectedCategory = data.category_id;
                this.title = data.title;
                this.selectedColor = data.color_id;
                this.selectedGender = data.gender;
                this.price = data.price;
                this.salePrice = data.sale_price;
                this.selectedBrand = data && data.brands && data.brands.length > 0 ? data.brands.map(brand => brand.id) : [];
                this.selectedSizeIds = data && data.sizes && data.sizes.length > 0 ? data.sizes.map(size => size.id) : [];
                this.durationOfService = data.duration_of_service;
                this.selectedSize = data && data.sizes && data.sizes.length > 0 ? data.sizes.map(sizes => ({
                    id: sizes.id,
                    size_title: sizes.size_title,
                    price: parseFloat(sizes.price)
                })) : [];
            }
            else {
                this.url = admin_url + '/products/add';
            };
        },
        updateSelectedSize: function(){
            this.selectedSize = [];
            for (let sizeId of this.selectedSizeIds) {
                let size = this.sizes.find(s => s.id === sizeId);
                if (size) {
                    size.price = 0; 
                    this.selectedSize.push(size);
                }
            }
        },
        removeSize(index, sizeId) {
            this.selectedSizeIds.splice(index, 1);
            const sizeIndex = this.selectedSize.findIndex(size => size.id === sizeId);
            if (sizeIndex !== -1) {
                this.selectedSize.splice(sizeIndex, 1);
            }
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
        updateSubCategory: async function() {
            let response = await fetch(admin_url + "/products/getSubCategory/" + this.selectedCategory);
            response = await response.json();
            if(response && response.status)
            {
                this.subCategories = response.subCategory;
                setTimeout(function () {
                    $("#sub-category-form select").selectpicker("refresh");
                }, 50);
            } else{
                set_notification('error', response.message);
            }
        },
        submitForm: async function() {
            if ($('#product-form').valid()) {
                let formData = new FormData(document.getElementById('product-form'));
                let sizeIdAndPrice = this.selectedSize.map(size => ({ id: size.id, price: size.price }));
                formData.append('sizeData', JSON.stringify(sizeIdAndPrice));
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
            } else {
                return false;
            }
        }, 
    },
    watch: {
        selectedGender: function () {
            this.updateSizes();
        },
        selectedCategory: function () {
            this.updateSubCategory();
        },
    },
});