let order = new Vue({
    el: '#order',
    data: {
        mounting: true,
        subtotal: 0,
        discount: 0,
        cgst: parseFloat(document.getElementById('cgstInput').value),
        sgst: parseFloat(document.getElementById('sgstInput').value),
        selectedProducts: [], 
        selectedCouponId: '',
        tax: 0,
        totalAmount: 0,
        manualAddress: false,
        productsData: [],
        customerAddresses: [],
        selectedCustomer: null,
        selectedAddress: null,
        loading: false,
        url: '',
        // selectedPaymentType: '',
        selectedStaff: '',
        bookingDate: '',
        bookingTime: '',
        address: '',
        // city: '',
        // state: '',
        // area: ''
    },
    mounted: function() {
        this.mounting = false;
        this.initBasics();
        this.initEditValues();
        document.getElementById('order-form').classList.remove('d-none');
    },
    methods: {
        removeItem(index, productId) {
            this.productsData.splice(index, 1); 
            this.selectedProducts = this.selectedProducts.filter(id => id !== productId); 
            this.updateTotal(); 
        },
        removeItem(index, productId) {
            this.productsData.splice(index, 1);
            this.selectedProducts = this.selectedProducts.filter(id => id !== productId); 
            this.updateTotal(); 
        },
        initEditValues: function () {
            if ($('#edit-form').length > 0) {
                let data = JSON.parse($('#edit-form').text());
                this.url = admin_url + '/order/' + data.id + '/edit';
                this.selectedCustomer = data.customer_id;
                this.selectedAddress = data.address_id;
                // this.selectedPaymentType = data.payment_type;
                this.selectedCouponId = data.coupon_code_id;
                this.subtotal = data.subtotal;
                this.discount = data.discount;
                this.manualAddress = data.manual_address ? true : false;
                this.notifiedActionId = data.notified_action_id ? data.notified_action_id.map(item => item.id) : [];
                this.selectedPrimeMover = data.prime_mover_name ? data.prime_mover_name : '';
                this.bookingDate = data.booking_date;
                this.bookingTime = data.booking_time;
                this.selectedStaff = data.staff_id;
                this.address = data.address;
                // this.city = data.city;
                // this.state = data.state;
                // this.area = data.area;
                this.selectedProducts = data && data.products && data.products.length > 0 ? data.products.map(product => product.id) : [];
                this.productsData = data && data.products && data.products.length > 0 ? data.products.map(product => ({
                    id: product.id,
                    title: product.title,
                    rate: parseFloat(product.amount),
                    quantity: parseInt(product.quantity),
                })) : [];
                this.updateTotal();
            }
            else {
                this.url = admin_url + '/order/add';
            };
        },
        initBasics: function () {
            setTimeout(function () {
                $('select').removeClass('no-selectpicker');
                initSelectpicker('select');
            }, 50);
        },
        updateTotal: function () {
            this.updateProductsData();
            this.calculateSubtotal();
            this.calculateTotal();
        },
        updateProductsData: function () {
            for (let productId of this.selectedProducts) {
                let price = parseFloat(document.querySelector(`select[name="product_id[]"] [value="${productId}"]`).getAttribute('data-product-price'));
                let existingProductIndex = this.productsData.findIndex(product => product.id === productId);
                if (existingProductIndex !== -1) {
                } else {
                    let productData = {
                        id: productId,
                        title: document.querySelector(`select[name="product_id[]"] [value="${productId}"]`).textContent,
                        rate: price,
                        quantity: 1,
                    };
                    this.productsData.push(productData);
                    this.subtotal += price;
                }
            }
            for (let product of this.productsData) {
                if (!this.selectedProducts.includes(product.id)) {
                    let index = this.productsData.findIndex(p => p.id === product.id);
                    this.removeItem(index, product.id);
                }
            }
        },
        calculateTotal: function () {
            if (this.selectedCouponId) {
                let isPercentage = parseFloat(document.querySelector(`select[name="coupon_code_id"] [value="${this.selectedCouponId}"]`).getAttribute('data-coupon-is-percentage'));
                let amount = parseFloat(document.querySelector(`select[name="coupon_code_id"] [value="${this.selectedCouponId}"]`).getAttribute('data-coupon-amount'));
                if (isPercentage) {
                    this.discount = (amount / 100) * this.subtotal;
                } else {
                    this.discount = amount;
                }
            } else {
                this.discount = 0;
            }
            this.tax = ((this.subtotal - this.discount) * this.cgst / 100) + ((this.subtotal - this.discount) * this.sgst / 100);
            this.totalAmount = this.subtotal - this.discount + this.tax;
            document.getElementById('subtotal').textContent = this.subtotal.toFixed(2);
            document.getElementById('discount').textContent = this.discount.toFixed(2);
            document.getElementById('tax').textContent = this.tax.toFixed(2);
            document.getElementById('total_amount').textContent = this.totalAmount.toFixed(2);

            document.querySelector('input[name="subtotal"]').value = this.subtotal.toFixed(2);
            document.querySelector('input[name="discount"]').value = this.discount.toFixed(2);
            document.querySelector('input[name="tax"]').value = this.tax.toFixed(2);
            document.querySelector('input[name="total_amount"]').value = this.totalAmount.toFixed(2);
        },
        updateQuantity: function (index) {
            this.productsData[index].quantity = parseInt(this.productsData[index].quantity);
            this.calculateSubtotal();
            this.calculateTotal();
        },
        calculateSubtotal: function () {
            this.subtotal = 0;
            for (let product of this.productsData) {
                this.subtotal += product.rate * product.quantity;
            }
            return this.subtotal;
        },
        updateAddresses: async function() {
            if(!this.manualAddress){
                customerId = this.selectedCustomer
                let response = await fetch(admin_url + "/order/getAddress/customer/" + customerId);
                response = await response.json();
                if(response && response.status)
                {
                    this.customerAddresses = response.addresses;
                    setTimeout(function () {
                        $("#address-form select").selectpicker("refresh");
                    }, 50);
                } else{
                    set_notification('error', response.message);
                }
            }
        },
        handleSelectpicker: function(){
            if(!this.manualAddress){ 
                console.log('refresh');
                setTimeout(function () {
                    $("#address-form select").selectpicker("refresh");
                }, 50);
            }else{
                console.log('destroy');
                    $("#address-form select").selectpicker("destroy");
            }
        },
        submitForm: async function() {
            let formData = new FormData(document.getElementById('order-form'));
            let productIdsAndQuantities = this.productsData.map(product => ({ id: product.id, quantity: product.quantity }));
            formData.append('productsData', JSON.stringify(productIdsAndQuantities));
            let response = await fetch(this.url, {
                method: 'POST',
                body: formData,
            });
            response = await response.json();
            if(response && response.status)
            {
                setTimeout(function () {
                    window.location.href = (admin_url + '/order/' + response.id + '/view');
                }, 200)
            }else{
                set_notification('error', response.message);
                
            }
        },    
    },
    watch: {
        selectedCustomer: function (newCustomerId) {
            this.updateAddresses();
        },
    },
});