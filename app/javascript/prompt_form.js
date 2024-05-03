$(window).on('turbo:load', function() {
    postForm();
});
const postForm = () => {
    $('#offcanvasPromptForm')
        .on({
            'show.bs.offcanvas': function() {
                //console.log($("#promptFormButton").data('url'));

                $.ajax({
                        url: $("#promptFormButton").data('url'),
                        type: 'GET',
                        dataType: 'html'
                    })
                    // Ajax通信が成功したら発動
                    .done((data) => {
                        $(this).find('.offcanvas-body').html(data);
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