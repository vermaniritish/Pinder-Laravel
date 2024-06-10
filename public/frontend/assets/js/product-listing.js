if($('#product-page').length)
var productDetail = new Vue({
    el: '#product-page',
    data: {
        id: null,
        logoPrices: [],
        editLogo: false,
        sizes: [],
        color: null,
        selectedSizes: {},
        uploading: null,
        buyNow: false,
        logo: {
            category: null,
            postion: null,
            text: ``,
            image: null
        },
        logoOptions: {
            category: [],
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
        renderAllAddedSizes() {
            // return this.sizes;
            return this.sizes.filter((i) => ((i.quantity*1) > 0) );
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
        handleFileUpload(sizeIndex) {
            this.uploading = sizeIndex;
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
                        productDetail.sizes[productDetail.uploading].logo.image = response.path;
                    }
                    else
                    {
                        set_notification('error', response.message);
                    }
                    productDetail.uploading = null;
                },
                complete: function() {
                }
            });
        },
        async addToCart(buyNow) {
            this.buyNow = buyNow ? true : false;
            this.editLogo = false;
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
            if(buyNow)
            {
                window.location.href = '/checkout'   
            }
        },
        async openLogoModal() {
            this.editLogo = true;
            let response = await fetch(site_url + `/api/products/fetch-logo-prices`);
            response = await response.json();
            if(response && response.status)
            {
                this.logoPrices = response.prices;
            }
        },
        onChange(index, size, category)
        {
            let price = 0;
            let logo = size.logo;
            if(category){
                this.sizes[index].logo.category = category;
            }
            if(size.logo.postion && (category || this.sizes[index].logo.category))
            {
                category = category ? category : this.sizes[index].logo.category;
                const pos = size.logo.postion;
                logo.category = category;
                if(category != 'None')
                {
                    let logoPriceApply = this.logoPrices.filter((val) => {
                        return val.position == this.convertToSlug(pos) && val.option == this.convertToSlug(category) && size.quantity >= val.from_quantity && size.quantity <= val.to_quantity;
                    });
                    logo.price = logoPriceApply && logoPriceApply.length > 0 ? (logoPriceApply[0].price*1) : 0;
                }
                else
                {
                    logo.price = 0;
                }
            }
            else
            {
                logo.price = 0;
            }
            size.logo = logo;
        },
        convertToSlug(Text) {
            return Text ? Text.toLowerCase()
            .replace(/ /g, "-")
            .replace(/[^\w-]+/g, "") : ``;
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
        for(let i in sizes)
        {
            let exist = this.cart.filter((item) => {
                return item.id == sizes[i].id
            });
            sizes[i].logo = exist && exist.length > 0 && exist[0].logo ? exist[0].logo : {...this.logo};
            sizes[i].quantity = exist && exist.length > 0 && exist[0].quantity ? exist[0].quantity : 0;
        }
        this.sizes = sizes;
        this.logoOptions = JSON.parse($('#logo-options').text().trim());
        if(!this.color && this.sizes.length > 0) {
            this.color = this.sizes[0].color_id;
        }

        window.productSlider();
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
        oneTimeCost: (oneTimeProductCost*1) > 0 ? (oneTimeProductCost*1) : 0,
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
            t.product_cost = subtotal.reduce((partialSum, a) => partialSum + a, 0);
            t.logo_cost = this.cart.map((item) => item.logo && item.logo.category != 'None' && (item.logo.price*1) > 0 ? item.logo.price*item.quantity : 0);
            t.logo_cost = t.logo_cost.reduce((partialSum, a) => partialSum + a, 0);
            t.oneTimeCost = (t.product_cost*1) > 0 && (this.oneTimeCost*1) > 0 ? (this.oneTimeCost*1) : 0;
            t.subtotal = t.product_cost + t.logo_cost + (t.product_cost > 0 ? t.oneTimeCost : 0 );
            t.discount = 0;
            t.tax = (t.subtotal - t.discount) * (this.gstTax > 0 ? this.gstTax : 0);
            t.tax = (t.tax > 0 ? t.tax / 100 : 0);
            t.total = t.subtotal - t.discount + t.tax;
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
        gstTax: ``,
        oneTimeCost: (oneTimeProductCost*1) > 0 ? (oneTimeProductCost*1) : 0,
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
            t.product_cost = subtotal.reduce((partialSum, a) => partialSum + a, 0);
            t.logo_cost = this.cart.map((item) => item.logo && item.logo.category != 'None' && (item.logo.price*1) > 0 ? item.logo.price*item.quantity : 0);
            t.logo_cost = t.logo_cost.reduce((partialSum, a) => partialSum + a, 0);
            t.oneTimeCost = (t.product_cost*1) > 0 && (oneTimeProductCost*1) > 0 ? (oneTimeProductCost*1) : 0;
            t.subtotal = t.product_cost + t.logo_cost +  + (t.product_cost > 0 ? t.oneTimeCost : 0 );

            t.discount = this.detectDiscount(t.subtotal);
            t.tax = (t.subtotal - t.discount) * (this.gstTax > 0 ? this.gstTax : 0);
            t.tax = (t.tax > 0 ? t.tax / 100 : 0);
            t.total = t.subtotal - t.discount + t.tax;
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
        detectDiscount(subtotal) {
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

var checkoutPage = null;
if($('#checkout-page').length)
checkoutPage = new Vue({
    el: '#checkout-page',
    data: {
        orderPlaced: null,
        errors: {},
        saving: false,
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
        gstTax: ``,
        oneTimeCost: (oneTimeProductCost*1) > 0 ? (oneTimeProductCost*1) : 0,
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
            if(cart && cart.length < 1)
            {
                window.location.href = site_url + '/';
            }
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
            
            t.product_cost = subtotal.reduce((partialSum, a) => partialSum + a, 0);
            t.logo_cost = this.cart.map((item) => item.logo && item.logo.category != 'None' && (item.logo.price*1) > 0 ? item.logo.price*item.quantity : 0);
            t.logo_cost = t.logo_cost.reduce((partialSum, a) => partialSum + a, 0);
            t.oneTimeCost = (t.product_cost*1) > 0 && (oneTimeProductCost*1) > 0 ? (oneTimeProductCost*1) : 0;
            t.subtotal = t.product_cost + t.logo_cost  + (t.product_cost > 0 ? t.oneTimeCost : 0 );

            t.discount = this.detectDiscount(t.subtotal);
            
            let tax = (t.subtotal - t.discount) * (this.gstTax > 0 ? this.gstTax : 0);
            tax = (tax > 0 ? tax / 100 : 0);
            t.total = ( ((t.subtotal - t.discount) *1) + tax);
            t.subtotal = t.subtotal.toFixed(2);
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
        detectDiscount(subtotal) {
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
            console.log(`this.saveInfo`, this.checkout.saveInfo);
            if(this.checkout.saveInfo) {
                localStorage.setItem('addressInfo', JSON.stringify(this.checkout));
            }

            if(this.saving) return false;
            let haveErrors = false;

            let checkout = JSON.parse(JSON.stringify(this.checkout));
            for(let e in checkout) {
                if($('#nologinsection').length < 1 && e === 'phone_email') {
                    continue;
                }
                else if(checkout[e] === ``) {
                    haveErrors = true;
                    break;
                }
            }
            if(!haveErrors)
            {
                this.errors = {};
                let data = {...checkout, ...{coupon: this.appliedCoupon, cart: this.cart, token: $('#checkout-page').attr('data-token')} };
                this.saving = true;
                data.lastId = localStorage.getItem('orderId') ? localStorage.getItem('orderId') : null;
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
                    localStorage.setItem('orderId', response.orderId);

                    // window.scrollTo(0,0)
                    // this.orderPlaced = response.orderId;
                    // localStorage.removeItem('cart');
                    // localStorage.removeItem('coupon');
                }
                else if(response && response.message)
                {
                    set_notification('error', response.message)
                }
                else
                {
                    set_notification('error', 'Something went wrong. Order could not be placed.')
                }
                this.saving = false;

                return response;
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
        let addressInfo = localStorage.getItem('addressInfo');
        if(addressInfo) {
            addressInfo = JSON.parse(addressInfo);
            this.checkout = {...this.checkout, ...addressInfo}
        }
    }
});