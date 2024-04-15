# DataBase setting
## Table
### Prompts
| Column | Type | Options |
| --- | --- | --- |
| title | string | null: false |
| content | text | null: false |
| nick_name | string | null: false<br>default: 'prompter'|
| ai_id | integer | null: false<br>default:'1'|
| tags | references | null: false<br>foreign_key:true|
| user | references | null: false<br>foreign_key:true| 
<!--tagを実装するならば-->
<!--userを実装するならば-->
---
### Comments
| Column | Type | Options |
| --- | --- | --- |
| nick_name | string |null: false<br>default:'commenter'|
| content | text | null: false |
| prompt | references | null: false<br>foreign_key:true|
| user | references | null: false<br>foreign_key:true|

### Likes
<!--cookie上に保存?-->
<!--後から拡張しやすいようにcountは入れない-->
| Column | Type | Options |
| --- | --- | --- |
| prompt| references |null: false<br>foreign_key:true|
### Favorites
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

### Users
| Column | Type | Options |
| --- | --- | --- |
| nick_name | string| null: false |
| email | string | null:false |
| encrypted_password | string | null:false |
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

---
# ER図
![Prompterにおけるデータ関係図](data_base_setting.drawio.png)