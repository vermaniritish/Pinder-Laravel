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
            let response = await fetch(site_url + `/api/products/listing?page=${this.page}&sort=${this.sort_by ? this.sort_by : ``}&gender=${this.filters.gender ? this.filters.gender.join(',') : ``}&price_from=${this.filters.fromPrice ? this.filters.fromPrice : ``}&price_to=${this.filters.toPrice ? this.filters.toPrice : ``}&brands=${this.filters.brands ? this.filters.brands.join(',') : ``}&categories=${this.filters.categories ? this.filters.categories.join(',') : ``}`);
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
        if(pathname.length > 2) {
            this.filters.categories.push(pathname[2]);
        }
        this.init()
    }
});