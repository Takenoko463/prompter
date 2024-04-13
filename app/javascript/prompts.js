 // ボタンクリック時に詳細情報を表示/非表示にする関数
 function toggleDetails() {
     const details = this.nextElementSibling;
     if (details.style.display === 'none') {
         details.style.display = 'block';
         this.textContent = 'プロンプト内容を隠す';
     } else {
         details.style.display = 'none';
         this.textContent = 'プロンプト内容を表示';
     }
 }

 // ボタンにイベントリスナーを追加
 const buttons = document.querySelectorAll('.showDetails');
 buttons.forEach(button => {
     button.addEventListener('click', toggleDetails);
 });