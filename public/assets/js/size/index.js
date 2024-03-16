let men = new Vue({
    el: '#men',
    data: {
        mens: [{ 
            size_type: '',
            from_cm: '',
            to_cm: '',
            chest: '',
            waist: '',
            hip: '',
            length: '',
        }
    ]
    },
    mounted: function() {
        this.initEditValues()
    },
    methods: {
        initEditValues: function () {
            if ($('#male').length > 0 && $('#male').text().trim() !== '[]') {
                let data = JSON.parse($('#male').text());
                this.mens = data;
            }
        },
        addForm() {
            this.mens.push({ 
                size_type: '',
                from_cm: '',
                to_cm: '',
                chest: '',
                waist: '',
                hip: '',
                length: '',
            });
        }
    }
});
let women = new Vue({
    el: '#women',
    data: {
        mens: [{ 
            size_type: '',
            from_cm: '',
            to_cm: '',
            chest: '',
            waist: '',
            hip: '',
            length: '',
        }
    ]
    },
    mounted: function() {
        this.initEditValues()
    },
    methods: {
        initEditValues: function () {
            if ($('#female').length > 0 && $('#female').text().trim() !== '[]') {
                let data = JSON.parse($('#female').text());
                this.mens = data;
            }
        },
        addForm() {
            this.mens.push({ 
                size_type: '',
                from_cm: '',
                to_cm: '',
                chest: '',
                waist: '',
                hip: '',
                length: '',
            });
        }
    }
});
let unisex = new Vue({
    el: '#uni',
    data: {
        mens: [{ 
            size_type: '',
            from_cm: '',
            to_cm: '',
            chest: '',
            waist: '',
            hip: '',
            length: '',
        }
    ]
    },
    mounted: function() {
        this.initEditValues()
    },
    methods: {
        initEditValues: function () {
            if ($('#unisex').length > 0 && $('#unisex').text().trim() !== '[]') {
                let data = JSON.parse($('#unisex').text());
                this.mens = data;
            }
        },
        addForm() {
            this.mens.push({ 
                size_type: '',
                from_cm: '',
                to_cm: '',
                chest: '',
                waist: '',
                hip: '',
                length: '',
            });
        }
    }
});