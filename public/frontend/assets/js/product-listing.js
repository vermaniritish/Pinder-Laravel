var productDetail = new Vue({
    el: '#product-page',
    data: {
        id: null,
        sizes: [],
        color: null,
        selectedSizes: {},
        logo: {
            category: null,
            postion: null,
            text: ``,
            image: null
        },
        logoOptions: {
            category: null,
            postions: null
        },
        fileSizeError: null,
        
    },
    methods: {
        selectColor(id) {
            this.color = id;
        },
        renderSizes() {
            if(this.color) {
                return this.sizes.filter((i) => i.color_id == this.color );
            }
            else {
                return this.sizes;
            }
        },
        increment(id) {
            let index = this.sizes.findIndex((v) => v.id == id);
            let s = [...this.sizes];

            if(s[index].quantity && (s[index].quantity * 1) > 0){
                s[index].quantity = (s[index].quantity*1) + 1;
            }
            else {
                s[index].quantity = 1;
            }
            this.sizes = s;
        },
        decrement(id) {
            let index = this.sizes.findIndex((v) => v.id == id);
            let s = [...this.sizes];

            if(s[index].quantity && (s[index].quantity * 1) > 0){
                s[index].quantity = (s[index].quantity*1) - 1;
            }
            else {
                s[index].quantity = 0;
            }
            this.sizes = s;
        },
        handleFileUpload(event) {
            $('#fileUploadForm input[type=file]').click();
        },
        uploadFile() {
            $('#fileUploadForm').ajaxSubmit({
                beforeSend: function() {
                },
                uploadProgress: function(event, position, total, percentComplete) {
                },
                success: function(response) {
                    if(response.status == 'success')
                    {
                        productDetail.logo.image = response.path;
                    }
                    else
                    {
                        set_notification('error', response.message);
                    }
                },
                complete: function() {
                }
            });
        },
        addToCart() {
            this.cart = this.sizes.filter((item) => {
                return (item.quantity && (item.quantity*1) > 0)
            });
            let cart = localStorage.getItem('cart');
            cart = cart ? JSON.parse(cart) : [];
            if(cart && cart.length > 0) {
                cart = cart.filter((item) => {
                    return item.product_id != this.id;
                })
                cart = [...cart, ...this.cart];
                localStorage.setItem('cart', JSON.stringify(cart));
            }
            else {
                cart = this.cart;
                localStorage.setItem('cart', JSON.stringify(cart));
            }
        }
    },
    mounted: function() {
        this.id  = $('#productId').text().trim();
        let cart = localStorage.getItem('cart');
        cart = cart ? JSON.parse(cart) : [];
        this.cart = cart.filter((item) => {
            return item.product_id == this.id;
        });
        let sizes = $('#product-sizes').text().trim();
        sizes = sizes ? JSON.parse(sizes) : [];
        if(cart && cart.length > 0)
        {
            for(let i in sizes)
            {
                let exist = this.cart.filter((item) => {
                    return item.id == sizes[i].id
                });
                sizes[i].quantity = exist && exist.length > 0 && exist[0].quantity ? exist[0].quantity : 0;
                console.log(sizes[i].quantity)
            }
        }

        this.sizes = sizes;
        this.logoOptions = JSON.parse($('#logo-options').text().trim());
        if(!this.color && this.sizes.length > 0) {
            this.color = this.sizes[0].color_id;
        }
    }
});

var productListing = new Vue({
    // Mount Vue instance to the div with id="app"
    el: '#product-listing-vue',
    data: {
        listing: [],
        sort_by: null,
        page: 1,
        maxPages: 1,
        pagination: [],
        fetching: false,
        priceError: false,
        paginationMessage: ``,
        search: ``,
        filters: {
            gender: [],
            categories: [],
            brands: [],
            fromPrice: ``,
            toPrice: ``
        }
    },
    methods: {
        currency: function(amount) {
            amount = amount*1;
            return "£" + (amount && amount > 0 ? amount.toFixed(2) : '0.00');
        },
        init: async function() {
            await this.fetchListing();
        },
        fetchListing: async function() {
            if(this.fetching) return false;
            
            this.fetching = true;
            let response = await fetch(site_url + `/api/products/listing?${this.search ? `search=${this.search}&` : '&'}brands=${this.filters.brands ? this.filters.brands.join(',') : ``}&categories=${this.filters.categories ? this.filters.categories.join(',') : ``}&gender=${this.filters.gender ? this.filters.gender.join(',') : ``}&price_from=${this.filters.fromPrice ? this.filters.fromPrice : ``}&price_to=${this.filters.toPrice ? this.filters.toPrice : ``}&page=${this.page}&sort=${this.sort_by ? this.sort_by : ``}`);
            response = await response.json();
            if(response && response.status)
            {
                this.listing = response.products;
                this.maxPages = response.maxPage;
                this.pagination = Array.from({ length: response.maxPage }, (_, index) => index + 1);
                this.paginationMessage = response.paginationMessage;
            }
            this.fetching = false;
        },
        clearSearch: async function(e) {
            this.search = ``;
            this.page = 1;
            await this.fetchListing();
        },
        sortIt: async function(e) {
            this.sort_by = e.target.value;
            this.page = 1;
            await this.fetchListing();
        },
        paginateIt: async function(page) {
            this.page = page; 
            await this.fetchListing();
        },
        genderFilter: async function(g) {
            let genders = this.filters.gender;
            let index = genders.findIndex(function(value, index, array) {
                return value === g;
            })
            if(index > -1) {
                genders.splice(index, 1);
            }
            else {
                genders.push(g);
            }
            this.filters.gender = genders;
            this.page = 1;
            await this.fetchListing();
        },
        priceFilter: async function() {
            if((this.filters.fromPrice*1) < 1 || (this.filters.toPrice*1) < 1) return false;

            if((this.filters.fromPrice*1) > 0 && (this.filters.toPrice*1) > 0 && (this.filters.fromPrice*1) > (this.filters.toPrice*1))
            {
                this.priceError = true;
            }
            else
            {
                this.priceError = false;
                await this.fetchListing();
            }
        },
        brandFilter: async function(b) {
            let brands = this.filters.brands;
            let index = brands.findIndex(function(value, index, array) {
                return value === b;
            })
            if(index > -1) {
                brands.splice(index, 1);
            }
            else {
                brands.push(b);
            }
            this.filters.brands = brands;
            this.page = 1;
            await this.fetchListing();
        },
        categoryFilter: async function(cat) {
            if(cat)
            {
                let categories = this.filters.categories;
                let index = categories.findIndex(function(value, index, array) {
                    return value === cat;
                })
                if(index > -1) {
                    categories.splice(index, 1);
                }
                else {
                    categories.push(cat);
                }
                this.filters.categories = categories;
            }
            else
            {
                this.filters.categories = [];
            }
            this.page = 1;
            await this.fetchListing();
        }
    },
    mounted: function() {
        console.log(window.location.pathname);
        let pathname = window.location.pathname.split('/');
        this.search = window.location.search.replace('?search=', '').trim();
        if(pathname.length > 2) {
            this.filters.categories.push(pathname[2]);
        }
        this.init()
    }
});
