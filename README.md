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
| Column   | Type     | Options                   |
| -------- | -------- | ------------------------- |
| nickname | string   | null: false, unique: true |
| email    | string   | null: false, unique: true |
| password | string   | null: false               |
| name     | string   | null: false, unique: true |
| birthday | datetime | null: false               |

### Association

- has_many :items
- has_many :purchase_records

## items テーブル

| Column         | Type   | Options     |
| -------------- | ------ | ----------- |
| item           | string | null: false |
| category       | string | null: false |
| price          | integer| null: false |
| seller         | string | null: false |
| product_status | string | null: false |
| image          | string | null: false |

### Association

- belongs_to :users

## purchase_record テーブル

| Column        | Type     | Options                        |
|---------------|----------|--------------------------------|
| buyer         | string   | null: false                    |
| shipping_area | string   | null: false                    |
| shipping_fee  | integer  | null: false                    |
| days_to_ship  | integer  | null: false                    |
| date          | datetime | null: false                    |
| item          | references| null: false, foreign_key: true|

### Association

-belongs_to :items

## address テーブル

| Column     | Type       | Options                       |
|------------|------------|-------------------------------|
| name       | references | null: false, foreign_key: true|
| postcode   | integer    | null: false                   |
| prefecture | string     | null: false                   |
| city       | string     | null: false                   |
| tel        | integer    | null: false                   | 

### Association

- belongs_to :users
