if($('#product-page').length)
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
        adding: null
        
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
        async addToCart() {
            this.adding = true;
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
            await sleep(350);
            this.adding = false;
            
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
            }
        }

        this.sizes = sizes;
        this.logoOptions = JSON.parse($('#logo-options').text().trim());
        if(!this.color && this.sizes.length > 0) {
            this.color = this.sizes[0].color_id;
        }
    }
});

if($('#product-listing-vue').length)
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

if($('#header').length)
var minicart = new Vue({
    el: '#header',
    data: {
        open: false,
        agree: false,
        cart: [],
        gstTax: ``
    },
    methods: {
        cartcount(){
            let cart = localStorage.getItem('cart');
            cart = cart ? JSON.parse(cart) : [];
            return cart.length;
        },
        initcart() {
            this.open = !this.open;
            if(this.open) {
                let cart = localStorage.getItem('cart');
                cart = cart ? JSON.parse(cart) : [];
                this.cart = cart;
                
            }
        },
        increment(id) {
            let index = this.cart.findIndex((v) => v.id == id);
            let s = [...this.cart];

            if(s[index].quantity && (s[index].quantity * 1) > 0){
                s[index].quantity = (s[index].quantity*1) + 1;
            }
            else {
                s[index].quantity = 1;
            }
            this.cart = s;
            this.store();
        },
        decrement(id) {
            let index = this.cart.findIndex((v) => v.id == id);
            let s = [...this.cart];

            if(s[index].quantity && (s[index].quantity * 1) > 0){
                s[index].quantity = (s[index].quantity*1) - 1;
            }
            else {
                s[index].quantity = 0;
            }
            this.cart = s;
            this.store();
        },
        remove(id) {
            let index = this.cart.findIndex((v) => v.id == id);
            let s = [...this.cart];
            s.splice(index, 1);
            this.cart = s;
            this.store();
        },
        store() {
            localStorage.setItem('cart', JSON.parse(this.cart))
        },
        calculate: function(){
            let t = {
                subtotal: 0,
                total: 0,
                discount: 0
            }

            let subtotal = this.cart.map((item) => item.quantity*item.price);
            let total = this.cart.map((item) => item.quantity*item.price);
            t.total = total.reduce((partialSum, a) => partialSum + a, 0);
            t.subtotal = subtotal.reduce((partialSum, a) => partialSum + a, 0);
            
            t.discount = 0;
            t.tax = (t.subtotal - t.discount) * (this.gstTax > 0 ? this.gstTax : 0);
            t.tax = (t.tax > 0 ? t.tax / 100 : 0);
            t.total = t.total + t.tax;
            return t;
        },
        getImagePath(image) {
            if(image)
            {
                image = JSON.parse(image);
                return image[0];
            }
            return null;
        }
    },
    mounted: function() {
        this.gstTax = gstTax();
    }
});

if($('#cart-page').length)
var minicart = new Vue({
    el: '#cart-page',
    data: {
        agree: false,
        cart: [],
        note: ``,
        coupon: ``,
        appliedCoupon: null,
        couponError: ``,
        gstTax: ``
    },
    methods: {
        cartcount(){
            let cart = localStorage.getItem('cart');
            cart = cart ? JSON.parse(cart) : [];
            return cart.length;
        },
        initcart() {
            let cart = localStorage.getItem('cart');
            cart = cart ? JSON.parse(cart) : [];
            this.cart = cart;

            let coupon = localStorage.getItem('coupon');
            coupon = coupon ? JSON.parse(coupon) : null;
            if(coupon && cart.length > 0)
            {
                this.coupon = coupon.coupon_code;
                this.appliedCoupon = coupon;
            }
        },
        increment(id) {
            let index = this.cart.findIndex((v) => v.id == id);
            let s = [...this.cart];

            if(s[index].quantity && (s[index].quantity * 1) > 0){
                s[index].quantity = (s[index].quantity*1) + 1;
            }
            else {
                s[index].quantity = 1;
            }
            this.cart = s;
            this.store();
        },
        decrement(id) {
            let index = this.cart.findIndex((v) => v.id == id);
            let s = [...this.cart];

            if(s[index].quantity && (s[index].quantity * 1) > 0){
                s[index].quantity = (s[index].quantity*1) - 1;
            }
            else {
                s[index].quantity = 0;
            }
            this.cart = s;
            this.store();
        },
        remove(id) {
            let index = this.cart.findIndex((v) => v.id == id);
            let s = [...this.cart];
            s.splice(index, 1);
            this.cart = s;
            this.store();
        },
        store() {
            localStorage.setItem('cart', JSON.parse(this.cart))
        },
        calculate: function(){
            let t = {
                subtotal: 0,
                total: 0,
                discount: 0
            }

            let subtotal = this.cart.map((item) => item.quantity*item.price);
            let total = this.cart.map((item) => item.quantity*item.price);
            t.total = total.reduce((partialSum, a) => partialSum + a, 0);
            t.subtotal = subtotal.reduce((partialSum, a) => partialSum + a, 0);
            
            t.discount = this.detectDiscount();
            t.tax = (t.subtotal - t.discount) * (this.gstTax > 0 ? this.gstTax : 0);
            t.tax = (t.tax > 0 ? t.tax / 100 : 0);
            t.total = t.total + t.tax;
            return t;
        },
        getImagePath(image) {
            if(image)
            {
                image = JSON.parse(image);
                return image[0];
            }
            return null;
        },
        clearCart() {
            this.cart = [];
            localStorage.removeItem('cart');
        },
        detectDiscount() {
            let subtotal = this.cart.map((item) => item.quantity*item.price);
            subtotal = subtotal.reduce((partialSum, a) => partialSum + a, 0);
            if(this.appliedCoupon && this.appliedCoupon.is_percentage > 0 && this.appliedCoupon.amount > 0)
            {
                let disc = (subtotal * this.appliedCoupon.amount)/100;
                return disc.toFixed(2);
            }
            else if(this.appliedCoupon && this.appliedCoupon.amount > 0) {
                return this.appliedCoupon.amount.toFixed(2);
            }
            return 0;
        },
        async applyCoupon() {
            if(!this.coupon.trim()) return false;
            this.couponError = ``;
            let response  = await fetch(site_url + `/api/coupons?code=` + this.coupon.trim());
            response = await response.json();
            if(response && response.data && response.data.data && response.data.data.length > 0) {
                this.appliedCoupon = response.data.data[0];
                localStorage.setItem('coupon', JSON.stringify(this.appliedCoupon));
            }
            else {
                this.appliedCoupon = null;
                this.couponError = `Entered coupon in invalid or expired.`
            }
        },
        removeCoupon() {
            this.appliedCoupon = null;
            this.coupon = null;
            localStorage.removeItem('coupon');
        }
    },
    mounted: function() {
        this.gstTax = gstTax();
        this.initcart();
    }
});

if($('#checkout-page').length)
var minicart = new Vue({
    el: '#checkout-page',
    data: {
        orderPlaced: null,
        errors: {},
        checkout:{
            phone_email: ``,
            first_name:``,
            last_name:``,
            last_name:``,
            company:``,
            address:``,
            address2:``,
            city:``,
            postalcode:``,
            saveInfo: false,
            newsletterSubscribe: false,
        },
        cart: [],
        note: ``,
        coupon: ``,
        appliedCoupon: null,
        couponError: ``,
        gstTax: ``
    },
    methods: {
        cartcount(){
            let cart = localStorage.getItem('cart');
            cart = cart ? JSON.parse(cart) : [];
            return cart.length;
        },
        initcart() {
            let cart = localStorage.getItem('cart');
            cart = cart ? JSON.parse(cart) : [];
            this.cart = cart;

            let coupon = localStorage.getItem('coupon');
            coupon = coupon ? JSON.parse(coupon) : null;
            if(coupon && cart.length > 0)
            {
                this.coupon = coupon.coupon_code;
                this.appliedCoupon = coupon;
            }
        },
        increment(id) {
            let index = this.cart.findIndex((v) => v.id == id);
            let s = [...this.cart];

            if(s[index].quantity && (s[index].quantity * 1) > 0){
                s[index].quantity = (s[index].quantity*1) + 1;
            }
            else {
                s[index].quantity = 1;
            }
            this.cart = s;
            this.store();
        },
        decrement(id) {
            let index = this.cart.findIndex((v) => v.id == id);
            let s = [...this.cart];

            if(s[index].quantity && (s[index].quantity * 1) > 0){
                s[index].quantity = (s[index].quantity*1) - 1;
            }
            else {
                s[index].quantity = 0;
            }
            this.cart = s;
            this.store();
        },
        remove(id) {
            let index = this.cart.findIndex((v) => v.id == id);
            let s = [...this.cart];
            s.splice(index, 1);
            this.cart = s;
            this.store();
        },
        store() {
            localStorage.setItem('cart', JSON.parse(this.cart))
        },
        calculate: function(){
            let t = {
                subtotal: 0,
                total: 0,
                discount: 0
            }

            let subtotal = this.cart.map((item) => item.quantity*item.price);
            subtotal = subtotal.reduce((partialSum, a) => partialSum + a, 0);
            t.discount = this.detectDiscount();
            let tax = (subtotal - t.discount) * (this.gstTax > 0 ? this.gstTax : 0);
            tax = (tax > 0 ? tax / 100 : 0);
            t.total = ( ((subtotal - t.discount) *1) + tax);
            t.subtotal = subtotal.toFixed(2);
            t.tax = tax.toFixed(2);
            t.total = t.total.toFixed(2);
            return t;
        },
        getImagePath(image) {
            if(image)
            {
                image = JSON.parse(image);
                return image[0];
            }
            return null;
        },
        clearCart() {
            this.cart = [];
            localStorage.removeItem('cart');
        },
        detectDiscount() {
            let subtotal = this.cart.map((item) => item.quantity*item.price);
            subtotal = subtotal.reduce((partialSum, a) => partialSum + a, 0);
            if(this.appliedCoupon && this.appliedCoupon.is_percentage > 0 && this.appliedCoupon.amount > 0)
            {
                let disc = (subtotal * this.appliedCoupon.amount)/100;
                return disc;
            }
            else if(this.appliedCoupon && this.appliedCoupon.amount > 0) {
                return this.appliedCoupon.amount > subtotal ? subtotal : this.appliedCoupon.amount;
            }
            return 0;
        },
        async applyCoupon() {
            if(!this.coupon.trim()) return false;
            this.couponError = ``;
            let response  = await fetch(site_url + `/api/coupons?code=` + this.coupon.trim());
            response = await response.json();
            if(response && response.data && response.data.data && response.data.data.length > 0) {
                this.appliedCoupon = response.data.data[0];
                localStorage.setItem('coupon', JSON.stringify(this.appliedCoupon));
            }
            else {
                this.appliedCoupon = null;
                this.couponError = `Entered coupon in invalid or expired.`
            }
        },
        removeCoupon() {
            this.appliedCoupon = null;
            this.coupon = null;
            localStorage.removeItem('coupon');
        },
        async submit() {
            let haveErrors = false;
            let checkout = JSON.parse(JSON.stringify(this.checkout));
            for(let e in checkout) {
                if(checkout[e] == ``) {
                    haveErrors = true;
                    break;
                }
            }

            if(!haveErrors)
            {
                this.errors = {};
                let data = {...checkout, ...{coupon: this.appliedCoupon}, ...{cart: this.cart} };
                console.log(data);
                let response = await fetch(site_url + '/api/orders/booking', {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json',
					},
					body: JSON.stringify(data),
				});
				response = await response.json();
                if(response && response.status)
                {
                    window.scrollTo(0,0)
                    this.orderPlaced = response.orderId;
                    localStorage.removeItem('cart');
                    localStorage.removeItem('coupon');
                }
                else
                {
                    set_notification('error', 'Something went wrong. Order could not be placed.')
                }
            }
            else
            {
                this.errors = checkout;
            }
        }
    },
    mounted: function() {
        this.gstTax = gstTax();
        this.initcart();
    }
});