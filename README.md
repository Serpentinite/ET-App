# ET-App

## 概要
ポートフォリオ用のwebアプリケーションです。

## 説明
コロナ禍で自宅トレーニングをする人は増えたが情報交換が難しくなっています。そこで、情報収集や情報共有をするためのナレッジコミュニティを作ろうと考えてこのテーマにしました。
また、トレーニングにおいて体重の管理は重要な項目だと考え、体重の管理機能も実装しています。


## バージョン
Ruby 2.4.5<br>
Rails 5.0.7

# 実装機能

## 投稿関連
* 一覧表示機能
* 詳細表示機能
* 削除機能
* 編集機能
* タイトル検索機能
* タグ検索機能

## コメント関連
* 投稿機能
* 削除機能
* 「役に立った」機能

## ユーザ関連
* 登録機能
* 編集機能
* ログイン・ログアウト
* ゲストユーザ機能

## 体重記録関連
* 体重入力機能
* 削除機能
* グラフ化(chartkick)

## ER図
![erd-et-app](https://user-images.githubusercontent.com/83485205/131293062-8e2f5300-e485-4a54-a241-bb22e5858a9d.png)

# その他
* Dockerによる環境構築
* Rspec、Capybaraによる簡易的なテストの導入
* CircleCiによる自動テスト
## インフラ関連(AWS)
* VPC
* EC2
* RDS

