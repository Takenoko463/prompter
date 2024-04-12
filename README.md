# DataBase setting
## Table
### Prompts
| Column | Type | Options |
| --- | --- | --- |
| title | string | null: false |
| content | text | null: false |
| nick_name | string | null: false<br>default: 'prompter'|
| ai_id | integer | null: false<br>default:'1'|
<!--userを実装するならば-->
| user | references | null: false<br>foreign_key:true|
---
### Comments
| Column | Type | Options |
| --- | --- | --- |
| nick_name | string |null: false<br>default:'commenter'|
| content | text | null: false |
| prompt | references | null: false<br>foreign_key:true|
<!--userを実装するならば-->
| user | references | null: false<br>foreign_key:true|
### Likes
<!--cookie上に保存?-->
<!--後から拡張しやすいようにcountは入れない-->
| Column | Type | Options |
| --- | --- | --- |
| prompt| references |null: false<br>foreign_key:true|
### Favorite
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
<!--誤って、送信しないように別で管理-->
### IPs
| Column | Type | Options |
| --- | --- | --- |
| content | string | null: false<br>uniqueness|

### Users
| Column | Type | Options |
| --- | --- | --- |
| ip | references | null: false<br>foreign_key:true<br>uniqueness|
---

## Association
### Prompts
<!--When generate comments_controller-->
has_many:comments
<!--When generate likes_controller-->
has_many:likes
<!--When generate favorite_controller-->
has_many:favorites
<!--When generate tags_controller-->
has_many:tags,throw prompt_tag_relations 
<!--When generate user_controller-->
belongs_to:user
### Comments
<!--When generate user_controller-->
belongs_to:user
### Likes
<!--When generate user_controller-->
### Favorites
<!--When generate user_controller-->
### Tags
### User