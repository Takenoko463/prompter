$(document).on('change', '#prompt_parent_category_id', function() {
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
                $('#prompt_child_category_id').html(options);
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    } else {
        $('#prompt_child_category_id').empty();
    }
});

$(document).on('click', '.submit-btn', function(e) {
    e.preventDefault();

    var $parentCategorySelect = $('#prompt_parent_category_id');
    var $childCategorySelect = $('#prompt_child_category_id');
    var categoryValue;

    if ($childCategorySelect.val() === '') {
        categoryValue = $parentCategorySelect.val();
    } else {
        categoryValue = $childCategorySelect.val();
    }

    $('#category_id').val(categoryValue);

    var $categoryForm = $('.prompt-category-form').detach();
    var $subcategoryForm = $('.prompt-subcategory-form').detach();

    var $form = $(this).closest('form');
    $form.submit();

    $form.one('ajax:complete', function() {
        $('.prompt-form').prepend($categoryForm);
        $('.prompt-form').prepend($subcategoryForm);
    });
});