# Prompter
# アプリケーション概要
対話型AIに対して行う指示や質問を収集、再利用するサイトです。
## webサイト
### url
[Prompter](http://54.199.100.28/)
### ID
```
admin
```
### password
```
2222
```
## 利用方法
- プロンプト投稿
  * プロンプト投稿ボタンを押す。　投稿ページへ遷移
  * フォームを埋めて、投稿ボタンを押す。
- 一覧からプロンプトを入手
  * コピーボタンを押して、プロンプトをコピー
  * AI名からリンク先に遷移し、コピーしたプロンプトを利用。
## アプリケーションを作成した背景
  私がこのアプリケーションを開発した理由は、対話型AI利用における課題を解決することです。AIへの質問文、つまりプロンプトの作成を補助できると考えています。

  私はChatGPTなどの対話型AI利用には2つの段階があると考えています。初回の質問と、既存のプロンプトを再利用した質問文作成です。

  多くのユーザーは既存情報の具体化や整理の目的でChatGPTを利用します。具体的には、文章の添削、校正、基本的なアイデア提案、小説やキャラクターの作成、スクリプト生成などが行えます。一度うまくいけば、これらの作成作業はAIへの質問内容における固有名詞を変えるだけで再利用できます。　

  しかし、まったく無知な分野に関する質問文作成は非常に困難です。AIに初めから利用できる回答を出力してもらうには、知識や重要な情報、AIの知らない最新の情報を具体的に整理した形で提供する必要があります。良いプロンプトを作成するには、自分の理解度を高めなければなりません。

  そこで、初めから完成されたプロンプトがあれば、初回の質問文作成という段階を飛ばして、固有名詞を入れ替えるだけで良いプロンプトを作成できると考えました。実際に私が勤めていたアルバイト先では、上司がすでに用意していたプロンプトを私たちアルバイトが再利用し、文章の校正やWebサイトに載せる文章作成などを行なっていました。

  このWebアプリ「Prompter」では、誰でもプロンプトを公開でき、別のユーザーは公開されたプロンプトを再利用できます。プロンプトをすべて書かずとも、いいねの数が多いプロンプトをコピーして再利用するだけで、AIがより良い回答を出力してくれます。


# DataBase setting
## Table
### Prompts
| Column | Type | Options |
| --- | --- | --- |
| title | string | null: false |
| content | text | null: false |
| nick_name | string | null: false<br>default: 'prompter'|
| ai_id | integer | null: false<br>default:'1'|
| ip_md5_head8| string | null: false | 
| tags | references | null: false<br>foreign_key:true|
<!--tagを実装するならば-->
---
### Comments
| Column | Type | Options |
| --- | --- | --- |
| nick_name | string |null: false<br>default:'commenter'|
| content | text | null: false |
| prompt | references | null: false<br>foreign_key:true|
| ip_md5_head8 | string | null: false | 

### Likes
<!--cookie上に保存?-->
<!--後から拡張しやすいようにcountは入れない-->
| Column | Type | Options |
| --- | --- | --- |
| prompt| references |null: false<br>foreign_key:true|
### Tags
| Column | Type | Options |
| --- | --- | --- |
| prompt | references | null: false|

### PromptTagRelations
| Column | Type | Options |
| --- | --- | --- |
| prompt | references | null: false |
| tag | references | null: false |
---

## Association
### Prompts
<!--When generate comments_controller-->
has_many:comments
<!--When generate likes_controller-->
has_many:likes
<!--When generate tags_controller-->
has_many:tags,throw prompt_tag_relations 
### Comments

### Likes
<!--When generate user_controller-->
### Tags

---
# ER図
![Prompterにおけるデータ関係図](data_base_setting.drawio.png)

## 開発環境
- フロントエンド:Ruby,JavaScript,bootstrap
- バックエンド:Ruby
- インフラ:AWS
- テキストエディター:VScode

## ローカルでの動作方法
以下のコマンドを順に実行します。
```sh
git clone https://github.com/Takenoko463/prompter.git
```
```sh
cd prompter
```
```sh
bundle install
```

## 工夫したポイント
私がこのアプリでターゲットにしたユーザーは、自身の作業を可能な限り減らしたいと考えている方達です。そのため、ユーザーに負担となる動作を減らしました。
- コピーボタン:プロンプトを範囲指定する動作を除去しました。
- 一般ユーザーはIPで区別:アカウント作成、ログイン、ログアウト動作を除去しました。