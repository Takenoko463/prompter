$(document).on('change', '#category_parents', function() {
    var $parentCategorySelect = $('#category_parents');
    var $childCategorySelect = $('#category_children');
    var parentId = $(this).val();
    if (parentId !== '') {
        $.ajax({
            url: '/categories/' + parentId + '/children',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                var options = '<option value="">必要があれば選択してください</option>';
                data.forEach(function(category) {
                    options += '<option value="' + category.id + '">' + category.name + '</option>';
                });
                $childCategorySelect.html(options);
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    } else {
        $childCategorySelect.empty();
    }
    var categoryValue = $parentCategorySelect.val();
    $('#prompt_category_id').val(categoryValue);
});
$(document).on('change', '#category_children', function() {
    var $childCategorySelect = $('#category_children');
    var categoryValue = $childCategorySelect.val();
    $('#prompt_category_id').val(categoryValue);
});