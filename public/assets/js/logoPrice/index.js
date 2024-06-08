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
                this.logoPositions = JSON.parse(response.logoPositions);
                this.initializeRows(response.data);
            }else{
                set_notification('error', response.message);
            }
        },
        initializeRows(logoPrices) {
            const grouped = {
                embroidered: {},
                printed: {}
            };
        
            logoPrices.forEach(price => {
                const key = `${price.from_quantity}-${price.to_quantity}`;
                const logoType = price.option === 'embroidered-logo' ? 'embroidered-logo' : 'printed-logo';
        
                if (!grouped[logoType][key]) {
                    grouped[logoType][key] = {
                        from_quantity: price.from_quantity,
                        to_quantity: price.to_quantity,
                        prices: {}
                    };
                }
        
                grouped[logoType][key].prices[price.position] = price.price;
            });
        
            this.embroideryRows = Object.values(grouped.embroidered-logo);
            this.printingRows = Object.values(grouped.printed-logo);
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
        }
    }
});