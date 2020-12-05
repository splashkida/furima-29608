# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル
| Column              | Type     | Options                   |
| ------------------- | -------- | ------------------------- |
| nickname            | string   | null: false               |
| email               | string   | null: false, unique: true |
| encrypted_password  | string   | null: false               |
| last_name           | string   | null: false               |
| first_name          | string   | null: false               |
| last_name_kana      | string   | null: false               |
| first_name_kana     | string   | null: false               |
| birthday            | date     | null: false               |

### Association

- has_many :items
- has_many :purchase_records

## items テーブル

| Column             | Type      | Options                          |
| ------------------ | --------- | -------------------------------- |
| item_name          | string    | null: false                      |
| description        | text      | null; false                      |
| category_id        | integer   | null: false                      |
| status_id          | integer   | null: false                      |
| shipping_fee_id    | integer   | null: false                      |
| ship_from_id       | integer   | null: false                      |
| preparation_days_id| integer   | null: false                      |
| price              | integer   | null: false                      |
| user               | references| null: false, foreign_key: true   |


### Association

- belongs_to :user
- has_one :purchase_record

## purchase_record テーブル

| Column        | Type       | Options                        |
|---------------|------------|--------------------------------|
| item          | references | null: false, foreign_key: true |
| user          | references | null: false, foreign_key: true |

### Association

-belongs_to :user
-belongs_to :item
-has_one :address

## address テーブル

| Column          | Type       | Options                       |
|-----------------|------------|-------------------------------|
| postcode        | string     | null: false                   |
| prefecture_id   | string     | null: false                   |
| city            | string     | null: false                   |
| block_number    | string     | null: false                   |
| building_name   | string     |                               |
| tel             | string     | null: false                   | 
| purchase_record | references | null: false, foreign_key: true|

### Association

- belongs_to :purchase_record
