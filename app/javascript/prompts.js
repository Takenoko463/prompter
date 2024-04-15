// ボタンクリック時に詳細情報を表示/非表示にする関数
/*$(window).on('load', function() {
    $(hide)
});*/
$(window).on('turbo:load', function() {
    $(hide)
});
$(window).on('turbo:load', function() {
    $(copy_prompt)
});

function hide() {
    $('.title-column').click(function() {
        $(this).parent().find('.toggle').toggle();
        const text = $(this).text(); // ボタンの文字取得
        if (text == "prompt open") {
            $(this).text("prompt close");
        } else {
            $(this).text("prompt open");
        }
    })
}

function copy_prompt() {
    $('.content-copy-button').click(function() {
        const text = $(this).parent().parent().find("p.toggle").text(); //テキスト取得
        navigator.clipboard.writeText(text); // ★ テキストをクリップボードに書き込み（＝コピー）

        $(this).text('OK!'); // ボタンの文字変更
        setTimeout(() => { $(this).text('COPY!') }, 1000); // ボタンの文字を戻す
    })
};