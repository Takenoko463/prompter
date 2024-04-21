$(document).on('change', '#prompt_category_id', function() {
    var parentId = $(this).val();
    if (parentId !== '') {
        $.ajax({
            url: '/categories/' + parentId + '/children',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                var options = '<option value="">選択してください</option>';
                data.forEach(function(category) {
                    options += '<option value="' + category.id + '">' + category.name + '</option>';
                });
                $('#prompt_subcategory_id').html(options);
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    } else {
        $('#prompt_subcategory_id').empty();
    }
});