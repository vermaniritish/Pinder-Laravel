let logoPrices = new Vue({
    el: '#logoPrices',
    data: { 
        logoPositions: [],
        embroideryRows: [],
        printingRows: [],
        groupedRows: []
    },
    mounted: function() {
        this.fetchLogoPrices();
    },
    methods: {
        fetchLogoPrices: async function() {
            let response = await fetch(admin_url + '/logo-price/fetch', {
                method: 'GET',
            });
            response = await response.json();
            if(response && response.status)
            {
                this.logoPositions = response.logoPositions;
                this.initializeRows(response.data);
            }else{
                set_notification('error', response.message);
            }
        },
        initializeRows(logoPrices) {
            const grouped = {
                'embroidered-logo': {},
                'printed-logo': {}
            };
            logoPrices.forEach(price => {
                const key = `${price.from_quantity}-${price.to_quantity}`;
                const logoType = price.option === 'embroidered-logo' ? 'embroidered-logo' : 'printed-logo';
    
                if (!grouped[logoType]) {
                    grouped[logoType] = {};
                }
                if (!grouped[logoType][key]) {
                    grouped[logoType][key] = {
                        from_quantity: price.from_quantity,
                        to_quantity: price.to_quantity,
                        prices: {}
                    };
                }
                if (!grouped[logoType][key].prices[price.position]) {
                    grouped[logoType][key].prices[price.position] = 0;
                }
    
                grouped[logoType][key].prices[price.position] = price.price;
            });
    
            this.embroideryRows = Object.values(grouped['embroidered-logo']);
            this.printingRows = Object.values(grouped['printed-logo']);
    
            console.log('Embroidery Rows:', this.embroideryRows);
            console.log('Printing Rows:', this.printingRows);
        },
        addRow(type) {
            const newRow = {
                from_quantity: 0,
                to_quantity: 0,
                prices: {}
            };
            
            this.logoPositions.forEach(position => {
                newRow.prices[position] = 0;
            });

            if(type == 'embroidered-logo') {
                this.embroideryRows.push(newRow);
            }
            if(type == 'printed-logo') {
                this.printingRows.push(newRow);
            }
        },
        removeRow(type, index) {
            if(type == 'embroidered-logo') {
                this.embroideryRows.splice(index, 1);
            }
            if(type == 'printed-logo') {
                this.printingRows.splice(index, 1);
            }
        }
    }
});