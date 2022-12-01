
![IMG_0816](https://user-images.githubusercontent.com/77389364/205053026-c0e3990f-e461-42c2-85e1-fff438892bf3.PNG)



「気になる映画や見た映画のデータをまとめたいけど面倒」<br>
 そんな方向けの映画レビューサイトです。


### Dependency

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails 6
- JSライブラリ：jQuery
- IDE：Cloud9

## インフラ
- EC2（Amazon Linux 2）

## Usage

ログイン後、映画一覧画面にて下記項目を実行することが可能。<br>
* ウォッチリストへの追加
* 閲覧の有無
* 星評価<br>

度々詳細画面を開かなくてよいので手軽に評価や管理ができる。<br>
また、星評価のみのレビューが可能なので時間がない時でも簡単に評価ができる。



## References
https://filmarks.com/

https://wear.jp/


## 機能

### ユーザー
- ログイン機能
- ログアウト機能
- レビュー機能（タイトル、本文、星評価）
- ウォッチリストへの追加
- 閲覧の有無
- フォロー



#### 一覧画面から評価、閲覧状態の変更、ウォッチリストへの追加

気になる映画を次々とウォッチリストに追加できたり、閲覧済みの映画を一気に評価できるなど、ズボラな方でも利用しやすい。<br>
レビューする際のみ、詳細ページから行う仕様。

#### SNS化し、選択肢を広める

同じ趣味のユーザーをフォローする事で、気になる作品がすぐに見つかる。


### 主な利用シーン
おうち時間の映画鑑賞前やその後に

### 映画のジャケットについて
著作権の問題のため、ARIから取得した画像を使用

## 設計書
### ER図
https://drive.google.com/file/d/1QGpNfXctaPxJD78c35zayao4-G-1Ohww/view?usp=sharing

### ワイヤーフレーム（ユーザー）
https://drive.google.com/file/d/1bRRSvhpPmftZb4UAc3kzVlDPNMzXBSZC/view?usp=sharing

### ワイヤーフレーム（管理者）
https://drive.google.com/file/d/1wJRvOBY6ZhiYaGwcnra947QcTiA8dOcf/view?usp=sharing


