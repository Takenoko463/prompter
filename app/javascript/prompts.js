// ボタンクリック時に詳細情報を表示/非表示にする関数
/*$(window).on('load', function() {
    $(hide)
});*/
$(window).on('turbo:load', function() {
    $(hide)
});

function hide() {
    $('.prompt').click(function() {
        $(this).find('.toggle').toggle();
    })
}