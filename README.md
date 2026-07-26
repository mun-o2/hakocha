# hakocha

A new Flutter project.

## プロジェクト構成

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

