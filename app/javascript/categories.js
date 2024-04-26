$(document).on('change', '#category_parents', function() {
    const $parentCategorySelect = $('#category_parents');
    const $childCategorySelect = $('#category_children');
    var categoryValue;
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
    categoryValue = $parentCategorySelect.val();
    console.log(categoryValue);
    //渡したい情報を含む
    /*
    if ($childCategorySelect.val() === '') {
        categoryValue = $parentCategorySelect.val();
    } else {
        categoryValue = $childCategorySelect.val();
    }
*/
    $('#categoryId').val(categoryValue);
});