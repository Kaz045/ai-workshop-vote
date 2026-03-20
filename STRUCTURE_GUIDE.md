# ストラクチャーガイド

このリポジトリでは、`specs/` とルート文書を正史、`docs/` などを履歴・参考レーンとして扱います。
人でも AI でも、最初に読む順番を固定して迷いを減らすことが目的です。

## コーディング前の読書順

1. `README.md`
2. `STRUCTURE_GUIDE.md`
3. `DECISIONS.md`
4. `TODO.md`
5. 必要な `specs/*.md`
6. 関連コード
   - 公開ページ: `index.html`
   - 投票プロトタイプ: `html_experiment/index.html`
   - デプロイ: `.github/workflows/pages.yml`
   - 運用スクリプト: `scripts/security/`

## デフォルトで読まない場所

以下は参考レーンです。実装や運用の判断に必要なときだけ開きます。

- `docs/chatgpt_exports/`
- `docs/plans/`
- `sessions/`
- `ideas/`
- `proposals/`
- `experiments/`
- `outputs/`
- `gifts/`
- `Webinar slides/`

## 正史と参考の線引き

### 正史

- `README.md`: プロジェクト概要と入口
- `STRUCTURE_GUIDE.md`: 参照順とフォルダ責務
- `DECISIONS.md`: 採用済み判断の記録
- `TODO.md`: 現在地、次アクション、未解決事項
- `specs/`: 実装・運用の正史

### 参考

- `docs/`: 旧来の企画書、会話ログ、運用メモ
- `html_experiment/`: 再利用可能性はあるが、現時点では実験・履歴寄り
- `sessions/`: 作業ログ
- `ideas/`, `proposals/`: 今後の整理先

## トップレベルの役割

| パス | 役割 | コーディング時の既定 |
|---|---|---|
| `README.md` | プロジェクトの入口 | 読む |
| `STRUCTURE_GUIDE.md` | 参照順と責務 | 読む |
| `DECISIONS.md` | 採用済み判断の索引 | 読む |
| `TODO.md` | 現在の作業状態 | 読む |
| `specs/` | 正史仕様 | 読む |
| `index.html` | 公開中の結果ページ | 必要時に読む |
| `html_experiment/` | 投票プロトタイプと補足 README | 必要時に読む |
| `.github/` | デプロイ設定 | 必要時に読む |
| `scripts/` | セキュリティ系補助スクリプト | 必要時に読む |
| `docs/` | 履歴・参考資料 | 通常は読まない |
| `sessions/` | 日次作業ログ | 通常は読まない |
| `ideas/` | 生メモ | 通常は読まない |
| `proposals/` | 企画候補・採用前文書 | 通常は読まない |
| `projects/` | 将来の成果物分離先 | 現時点では空 |
| `prompts/` | 再利用プロンプト置き場 | 必要時に読む |
| `experiments/` | 使い捨て検証 | 通常は読まない |
| `outputs/` | 生成物・書き出し | 通常は読まない |
| `skills/` | 将来の運用知見 | 必要時に読む |

## 運用ルール

- 新しい承認済み仕様は `specs/` に入れます
- 新しい判断は `DECISIONS.md` に残します
- 新しい生メモは `ideas/`、比較可能な企画案は `proposals/` に入れます
- `prompts/` に新規追加する文書は、既存ルールがない限り英語で書きます
- GitHub Pages の都合で、現行の公開ページ `index.html` はルートに残します

## 現時点で注意すべき不一致

- ルート `index.html` は 4 テーマの最終結果ページです
- `html_experiment/index.html` は 5 テーマ構成の Firebase 前提プロトタイプです
- `.github/workflows/pages.yml` は Firebase Secrets 前提のままで、現行の静的結果ページとは設計上ずれがあります
