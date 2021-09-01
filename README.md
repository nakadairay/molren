|                   | 備考  |
| ----------------- | ---- |
| アプリケーション名   | molren |
| アプリケーション概要 | 練習会の作成・編集・削除<br>ユーザーの登録(sns認証)<br>クレジットカード決済<br>名簿csv出力 |
| URL               | https://molren.herokuapp.com/  |
| テスト用アカウント   | 練習会編集/削除用<br>email: test@nakadaira.com<br>pw:test1234<br><br>練習会申込用<br>email: test@yoshiharu.com<br>pw:test1234<br><br>Basic認証<br>user:admin<br>pw:2222 |
| 利用方法           | ユーザーは新規会員登録/ログイン後、練習会を見つけて申込したり、自分自身で練習会を作成することができる。 |
| 目指した課題解決    | どこで練習会が行われてるかわからない人が気軽に練習会に参加できるような環境を作る。 |
| 洗い出した案件      | こちらのスプレッドシートを参考ください<br>https://docs.google.com/spreadsheets/d/1BaacarJXHB8yBmewj2QmtROrai7MU_aQFEdWnoeZLB0/edit?usp=sharing  |
| 実装予定の機能      | 定員に満たされた時点で申し込みできないようにする機能 |
| ローカルでの動作方法 | Ruby version 2.6.5<br>'git clone'後<br>```bundle install```<br> ```rails db:migrate```<br>をお願いします |


# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birthday           | date    | null: false               |
| sex                | integer | null: false               |

### Association

- has_many :practices
- has_many :practice_applies
- has_many :sns_credentials
- has_one :card


## practices テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| name         | string     | null: false                    |
| price        | integer    | null: false                    |
| practice_on  | date       | null: false                    |
| practice_at  | time       | null: false                    |
| user         | references | null: false, foreign_key: true |
| place        | text       | null: false                    |
| comment      | text       | null: false                    |
| capacity     | integer    | null: false                    |

### Association

- belongs_to :user
- has_many :practice_applies

## practice_applies テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| practice | references | null: false, foreign_key: true |

### Association

- belongs_to :practice
- belongs_to :user

## snscredentials テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| provider | string     |                                |
| uid      | string     |                                |


### Association

- belongs_to :user

## cards テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| customer_token | string     | null: false,                   |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :user