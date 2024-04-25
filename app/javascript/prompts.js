$(window).on('turbo:load', function() {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })
    copyPrompt();
});

const copyPrompt = () => {
    $('.content-copy-button')
        // クリック時の動作を設定
        .on('click', function() {
            const copyTextFallback = (str) => {
                if (!str || typeof str !== 'string') {
                    return '';
                }
                const textarea = document.createElement('textarea');
                textarea.style.position = 'fixed';
                textarea.style.right = '100vw';
                textarea.style.fontSize = '16px';
                textarea.setAttribute('readonly', 'readonly');
                textarea.textContent = str;
                document.body.appendChild(textarea);
                textarea.select();
                document.execCommand('copy');
                document.body.removeChild(textarea);

                return str;
            };
            const promptId = $(this).data('prompt-id');
            const contentMain = $("#promptContent" + promptId);
            var text = contentMain.find("p.content-first-line").text();
            const remainingContent = contentMain.find("p.remaining-content").text();
            if (remainingContent) {
                text += remainingContent;
            }
            if (!navigator.clipboard) {
                copyTextFallback(text);
            } else {
                navigator.clipboard.writeText(text);
            }
            // "copied"というTooltipを表示する
            $(this).tooltip('show');
            setTimeout(function() {
                $("#copyPrompt" + promptId).tooltip('hide');
            }, 700);
        })

};