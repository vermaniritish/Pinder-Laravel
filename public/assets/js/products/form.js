let order = new Vue({
    el: '#product',
    data: {
        mounting: true,
        sizes: [],
        selectedSize: {},
        selectedSizeIds: {},
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
        tags: null,
        availableColors: JSON.parse($('#availableColor').text()),
        short_description: ''
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
        updateSelectedColor: function() {
            for (let colorId of this.selectedColor) {
                if (!this.selectedSizeIds.hasOwnProperty(colorId)) {
                    this.$set(this.selectedSizeIds, colorId, []);
                }
            }
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
                this.selectedSizeIds = {};
                // this.selectedSizeIds = data && data.sizes && data.sizes.length > 0 ? data.sizes.map(size => size.id) : [];
                this.short_description = data.short_description;
                if (data && data.sizes && data.sizes.length > 0) {
                    data.sizes.forEach(size => {
                        if (!this.selectedSizeIds[size.color_id]) {
                            this.selectedSizeIds[size.color_id] = [];
                        }
                        this.selectedSizeIds[size.color_id].push(size.id);
                    });
                }
                this.description = data.description;
                if (this.description !== null) {
                    put_editor_html('product-editor', this.description.trim());
                }
                if (data && data.sizes && data.sizes.length > 0) {
                    data.sizes.forEach(size => {
                        if (!this.selectedSize[size.color_id]) {
                            this.selectedSize[size.color_id] = [];
                        }
                        this.selectedSize[size.color_id].push({
                            id: size.id,
                            size_title: size.size_title,
                            from_cm: size.from_cm,
                            to_cm: size.to_cm,
                            price: parseFloat(size.price),
                            sale_price: parseFloat(size.sale_price),
                        });
                    });
                }
                
            }
            else {
                this.url = admin_url + '/products/add';
            };
        },
        updateSelectedSize() {
            for (let colorSelectedId in this.selectedSizeIds) {
                if (Array.isArray(this.selectedSizeIds[colorSelectedId])) {
                    if (!this.selectedSize.hasOwnProperty(colorSelectedId)) {
                        this.$set(this.selectedSize, colorSelectedId, []);
                    }
                    let selectedSizes = [];
                    for (let sizeId of this.selectedSizeIds[colorSelectedId]) {
                        let size = this.sizes.find(size => size.id === sizeId);
                        if (size) {
                            let existingSize = this.selectedSize[colorSelectedId].find(selected => selected.id === size.id);
                            if (existingSize) {
                                selectedSizes.push(existingSize);
                            } else {
                                selectedSizes.push({
                                    id: size.id,
                                    size_title: size.size_title,
                                    from_cm: size.from_cm,
                                    to_cm: size.to_cm,
                                    price: size.price,
                                    sale_price: size.sale_price,
                                });
                            }
                        } 
                    }
                    this.$set(this.selectedSize, colorSelectedId, selectedSizes);
                }
            }
        },
         
        removeSize(colorSelectedId, sizeIndex) {
            let selectedSizes = this.selectedSize[colorSelectedId];
            selectedSizes.splice(sizeIndex, 1);
            this.$set(this.selectedSize, colorSelectedId, selectedSizes);
        },       
        updateSizes: async function() {
            let response = await fetch(admin_url + "/products/getSize/" + this.selectedGender);
            response = await response.json();
            if(response && response.status)
            {
                this.sizes = response.sizes;
                setTimeout(function () {
                    $(".size-select").selectpicker('refresh');
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
                formData.append('sizeData', JSON.stringify(this.selectedSize));
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
        selectedColor: function () {
            setTimeout(function () {
                $(".size-select").selectpicker('refresh');
            }, 50);
        },
        selectedCategory: function () {
            this.updateSubCategory();
        },
    },
});