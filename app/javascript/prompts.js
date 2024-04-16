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

const hide = () => {
    $('.title-column').on("click", function() {
        $(this).parent().find('.toggle').toggle();
        const text = $(this).text(); // ボタンの文字取得
        if (text == "prompt open") {
            $(this).text("prompt close");
        } else {
            $(this).text("prompt open");
        }
    })
}

const copy_prompt = () => {
    $('.content-copy-button').on("click", function() {
        // http環境で動くコピーコード
        const copyTextFallback = (str) => {
            if (!str || typeof str !== 'string') {
                return '';
            }
            const textarea = document.createElement('textarea');
            textarea.id = 'tmp_copy';
            textarea.style.position = 'fixed';
            textarea.style.right = '100vw';
            textarea.style.fontSize = '16px';
            textarea.setAttribute('readonly', 'readonly');
            textarea.textContent = str;
            document.body.appendChild(textarea);
            const elm = document.getElementById('tmp_copy');
            elm.select();
            const range = document.createRange();
            range.selectNodeContents(elm);
            const sel = window.getSelection();
            if (sel) {
                sel.removeAllRanges();
                sel.addRange(range);
            }
            elm.setSelectionRange(0, 999999);
            document.execCommand('copy');
            document.body.removeChild(textarea);

            return str;
        };
        const text = $(this).parent().parent().find("p.toggle").text(); //テキスト取得
        if (!navigator.clipboard) {
            copyTextFallback(text);
        } else {
            navigator.clipboard.writeText(text); // ★ テキストをクリップボードに書き込み（＝コピー）
        }

        $(this).text('OK!'); // ボタンの文字変更
        setTimeout(() => { $(this).text('COPY!') }, 1000); // ボタンの文字を戻す
    })
};