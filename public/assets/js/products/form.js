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
        selectedColor: [],
        price: '',
        maxPrice: '',
        selectedBrand: [],
        loading: false,
        url: '',
        selectedSubCategory: [],
        description: null,
        tags: null
    },
    mounted: function() {
        this.initBasics();
        this.initTagIt();
        init_editor('#product-editor');
        this.initEditValues();
        this.mounting = false;
        document.getElementById('product-form').classList.remove('d-none');
    },
    methods: {
        initTagIt: function () {
            $(".tag").tagit();
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
                this.selectedSubCategory = data && data.sub_categories && data.sub_categories.length > 0 ? data.sub_categories.map(category => category.sub_category_id) : [];
                this.selectedCategory = data.category_id;
                this.title = data.title;
                this.selectedColor = data && data.colors && data.colors.length > 0 ? data.colors.map(colors => colors.id) : [];
                this.selectedGender = data.gender;
                this.price = data.price;
                this.maxPrice = data.max_price;
                this.selectedBrand = data && data.brands && data.brands.length > 0 ? data.brands.map(brand => brand.id) : [];
                this.selectedSizeIds = data && data.sizes && data.sizes.length > 0 ? data.sizes.map(size => size.id) : [];
                this.short_description = data.short_description;
                this.description = data.description;
                if (this.description !== null) {
                    put_editor_html('product-editor', this.description.trim());
                }
                this.selectedSize = data && data.sizes && data.sizes.length > 0 ? data.sizes.map(sizes => ({
                    id: sizes.id,
                    size_title: sizes.size_title,
                    price: parseFloat(sizes.price),
                    from_cm: parseFloat(sizes.from_cm),
                    to_cm: parseFloat(sizes.to_cm),
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
                formData.append('description', get_editor_html('product-editor'));
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