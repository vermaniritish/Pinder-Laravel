let staff = new Vue({
    el: '#staff',
    data: {
        loading: false,
    },
    methods: {
        saveDocumentInfo: async function(id){
            if(!this.loading){
                this.loading = true;
                let formData = new FormData(document.getElementById('saveDoc'));
                let response =  await fetch(admin_url + `/staff/${id}/add-doc`, {
                    method: 'POST',
                    body: formData,
                });
                response = await response.json();
                if(response.status){
                    window.location.reload()
                    set_notification('success', response.message)
                }else{
                    set_notification('error', response.message);
                }
                this.loading = false;
            }
        },
        openDocumentEditModal: function(row) {
            this.DocumentEditDbData.row_id = row.id;
            this.DocumentEditDbData.title = row.title;
            this.DocumentEditDbData.expiry_date = row.expiry_date ? _d(row.expiry_date) : '';
            $('#editDoc').modal('show');
        }
    },
});