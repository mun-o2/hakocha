# シェアme

プロフィールを交換できる、デジタルプロフィール帳アプリです。

昔の「プロフィール帳」のように、友達同士でプロフィールを書き合ったり、
交換したプロフィールをあとから見返したりできる体験を目指しています。

---

## Features

### プロフィール作成・編集

自分のプロフィール帳を作成・編集できます。

- 基本プロフィール
- SNS情報
- Love Talk
- Free Space
- テーマカラーの選択
- 編集 / 閲覧モードの切り替え

テーマカラーは現在 **Pink / Blue** に対応しています。

### プロフィール交換

iPhone同士を近づけて、プロフィール情報を交換できます。

- 近くにある端末の検出
- ユーザー情報の送受信
- 交換相手の表示
- Free Spaceへのメッセージ入力
- 交換完了画面
- 交換成功時のアニメーション
- ハプティックフィードバック

近距離通信には iOS の Multipeer Connectivity を利用しています。

交換コードを利用した交換フローも用意しています。

### プロフィール帳

交換した相手のプロフィールをプロフィール帳として閲覧できます。

- プロフィール帳の表紙
- 左右ページ形式のプロフィール表示
- ページ切り替え
- 表紙を開く際のアニメーション
- 閲覧時の編集無効化

### ホーム

交換状況やプロフィール情報を確認できます。

- ユーザー情報
- プロフィール編集
- 交換した人数
- プロフィール帳のページ数
- お知らせ
- 選択したテーマカラーの反映

---

## Tech Stack

### Frontend

- Flutter
- Dart
- Provider

### Backend / Data

- Firebase
- Firebase Core

### Device Communication

- iOS Multipeer Connectivity
- MethodChannel / EventChannel

### UI

- Google Fonts
- Flutter Animation
- Haptic Feedback
- audioplayers

---

## Project Structure

レイヤーファースト構成を採用しています。

```text
lib/
├── main.dart
├── constants/
├── models/
├── providers/
├── screens/
├── services/
├── utils/
├── widgets/
```

### 各ディレクトリの役割

- `constants/`: アプリ内で利用する文字列や定数を管理
- `models/`: アプリで扱うデータモデルや列挙型を定義
- `providers/`: 状態管理に利用するクラスを配置
- `screens/`: 画面単位のウィジェットを配置
- `services/`: API通信やデータ保存などの外部処理を担当するクラスを配置
- `utils/`: 共通ユーティリティ関数や補助機能を配置
- `widgets/`: 複数画面で再利用する共通 UI 部品を配置
