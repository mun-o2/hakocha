# hakocha

A new Flutter project.

## プロジェクト構成

このプロジェクトは、保守性を意識したシンプルなレイヤーファースト構成を採用しています。

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

- `constants/`: アプリ内で利用する文字列や定数を管理します。
- `models/`: アプリで扱うデータモデルや列挙型を定義します。
- `providers/`: 状態管理に利用するクラスを配置します。
- `screens/`: 画面単位のウィジェットを配置します。
- `services/`: API通信やデータ保存などの外部処理を担当するクラスを配置します。
- `utils/`: 共通ユーティリティ関数や補助機能を配置します。
- `widgets/`: 複数画面で再利用する共通 UI 部品を配置します。

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
