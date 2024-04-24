$(window).on('turbo:load', function() {
    hideOrOpen();
    copyPrompt();
});

const hideOrOpen = () => {
    $('.read-more').on("click", function() {
        $(this).parent().parent().find('.toggle').toggle();
        var readMoreText = $(this).text() == "続きを読む" ? "一部を表示" : "続きを読む";
        $(this).text(readMoreText);
    });
};

const copyPrompt = () => {
    $('.content-copy-button').on("click", function() {
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
        const contentMain = $("#prompt-content-" + promptId);
        var text = contentMain.find("p.content-first-line").text();
        const remainingContent = contentMain.find("p.toggle").text();
        if (remainingContent) {
            text += remainingContent;
        }
        if (!navigator.clipboard) {
            copyTextFallback(text);
        } else {
            navigator.clipboard.writeText(text);
        }

        $(this).text('OK!');
        setTimeout(() => { $(this).text('COPY!') }, 1000);
    })
};