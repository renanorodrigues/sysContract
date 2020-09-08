// Form document
// Object: Display a subform relational of contracts if is selected

$(document).on('change', '#document_type_document', function() {
    if($(this).val() == 'Contrato'){
        $( "#form_contract" ).toggle(true);
    }else{
        $( "#form_contract" ).toggle(false);
    }
});

$('#modal_document').on('change', '#document_visibility_mode', function() {
    if($(this).val() == 'C'){
        $( "#form_users_permissions" ).toggle(true);
    }else{
        $( "#form_users_permissions" ).toggle(false);
    }
});


$(document).ready(function(){
    $('#select_multiple').picker({search : true});
});

