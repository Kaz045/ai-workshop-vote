# データモデル

## 1. 現在の公開結果データ

現在の公開正史は、ルート `index.html` 内の静的配列です。
このデータは 2026年3月の最終集計結果を表します。

### エンティティ: `ThemeResult`

| フィールド | 型 | 必須 | 説明 |
|---|---|---|---|
| `id` | number | 必須 | テーマ識別子 |
| `title` | string | 必須 | テーマ名 |
| `details` | string[] | 必須 | テーマ内容の箇条書き |
| `note` | string | 任意 | 補足説明 |
| `votes` | number | 必須 | 得票数 |

### 派生値

| 項目 | 説明 |
|---|---|
| `totalVotes` | 全テーマの `votes` 合計 |
| `rank` | `votes` 降順、同票時は `id` 昇順 |
| `share` | `votes / totalVotes` |

### 現行の最終データセット

| id | title | votes |
|---|---|---|
| 1 | ChatGPTなどを仕事の相棒として使う | 4 |
| 2 | AIでツールを作る | 11 |
| 3 | AI開発の世界を覗く | 7 |
| 4 | 企業でのAI導入とMS Copilot | 1 |

## 2. 旧プロトタイプの Firebase データ

`html_experiment/index.html` では、次の Firestore ドキュメントを前提にしています。

- Path: `artifacts/{appId}/public/survey_results`

### ドキュメント形状

| フィールド | 型 | 説明 |
|---|---|---|
| `votes_1` | number | テーマ1の票数 |
| `votes_2` | number | テーマ2の票数 |
| `votes_3` | number | テーマ3の票数 |
| `votes_4` | number | テーマ4の票数 |
| `votes_5` | number | テーマ5の票数 |

## 3. 既知の不一致

- 公開結果ページは 4 テーマです
- 旧プロトタイプは 5 テーマです
- タイトル、補足文、テーマ順も一致していません

## 4. 運用ルール

- 現在の正史データはルート `index.html` の 4 テーマ結果です
- Firebase データモデルは履歴・実験扱いです
- ライブ投票を再開する場合は、`ThemeResult` と Firestore ドキュメント設計を再統一してから実装します
