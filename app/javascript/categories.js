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
$(window).on('turbo:load', function() {
    categoryIndex();
});
const categoryIndex = () => {
    $('#categoryIndex')
        .on({
            'show.bs.offcanvas': function() {
                $.ajax({
                        url: $("#categoryIndexButton").data('url'),
                        type: 'GET',
                        dataType: 'json'
                    })
                    // Ajax通信が成功したら発動
                    .done((data) => {
                        var categories = '<ul class="navbar-nav">';
                        console.log(data);
                        data.forEach(function(category) {
                            let category_prompts_path = '/categories/' + category.id + '/prompts';
                            categories += '<li class="nav-item"><a class="nav-link text-reset" href=' + category_prompts_path + '>' + category.name + '</a></li>';
                        });
                        categories += '</ul>'
                        $(this).find('.offcanvas-body').html(categories);
                    })
                    // Ajax通信が失敗したら発動
                    .fail((jqXHR, textStatus, errorThrown) => {
                        alert('Ajax通信に失敗しました。');
                        console.log("jqXHR          : " + jqXHR.status); // HTTPステータスを表示
                        console.log("textStatus     : " + textStatus); // タイムアウト、パースエラーなどのエラー情報を表示
                        console.log("errorThrown    : " + errorThrown); // 例外情報を表示
                    });

            }
        })
};