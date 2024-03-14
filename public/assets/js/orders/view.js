async function switch_diary_page_action(url, that) {
    var flag = $(that).data('value');
    var currentStatus = $('#Currentstatus').val();
    if (flag.toLowerCase() === currentStatus) {
        var text = $(that).closest('.dropdown').find('.btn').text().toLowerCase();
        set_notification('error', 'Cannot change status to ' + text + ' again.');
        return;
    }
    var statusStyles = await getStatuses();
    $.ajax({
        url: url,
        type: 'post',
        data: {
            flag: flag,
            _token: csrf_token()
        },
        success: function (resp) {
            if ($(that).data('value') && resp.status === 'success') {
                var buttonText = $(that).text();
                var statusData = statusStyles[flag];
                var buttonStyle = statusData.styles || 'background-color: #ffffff; color: #000000;';
                $(that).closest('.dropdown').find('.btn').removeClass().addClass('btn btn-sm dropdown-toggle').attr('style', buttonStyle).text(buttonText);
                set_notification('success', 'Order status updated successfully.');
            }
        }
    })
}
function getStatuses() {
    return $.ajax({
        url: admin_url +'/order/getStatus',
        method: 'GET',
    });
}

function enableEdit(id, currentValue) {
    var inputField = document.getElementById(id).querySelector('input');
    inputField.value = currentValue;
    document.getElementById(id).querySelector('.edit-icon').style.display = 'none';
    document.getElementById(id).querySelector('.fill-text').style.display = 'none';
    document.getElementById(id).querySelector('.edit').classList.remove('d-none');
}

function exitEditMode(id) {
    document.getElementById(id).querySelector('.edit').classList.add('d-none');
    document.getElementById(id).querySelector('.fill-text').style.display = 'inline-block';
    document.getElementById(id).querySelector('.edit-icon').style.display = 'inline-block';
}

function str_replace(search, replace, subject) {
    return subject.replace(new RegExp(search, 'g'), replace);
}

function ucfirst(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

async function saveEdit(id, fieldName, orderId) {
    let newValue = document.getElementById(id).querySelector('input').value;
    const response = await fetch(admin_url + '/order/'+ orderId+'/updateField', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': csrf_token()
        },
        body: JSON.stringify({
            fieldName: fieldName,
            value: newValue
        })
    });
    const data = await response.json();
    if (data.status) {
        set_notification('success', ucfirst(str_replace('_', ' ', fieldName)) + ' updated successfully.');
        setTimeout(function () {
        window.location.reload();
    }, 1000);
    } else {
        set_notification('error', 'Failed to update ' +ucfirst(str_replace('_', ' ', fieldName))+'.');
    }
}

