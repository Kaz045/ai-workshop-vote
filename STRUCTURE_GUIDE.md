# ストラクチャーガイド

このリポジトリでは、`site/` と `specs/` を現在の正史、`archive/` と `docs/` などを履歴・参考レーンとして扱います。
人でも AI でも、最初に読む順番を固定して迷いを減らすことが目的です。

## コーディング前の読書順

1. `README.md`
2. `STRUCTURE_GUIDE.md`
3. `DECISIONS.md`
4. `TODO.md`
5. 必要な `specs/*.md`
6. 関連コード
   - 公開ページ: `site/index.html`
   - 会員向けページ: `site/workshops/session-1.html`
   - 共通アセット: `site/assets/`
   - デプロイ: `.github/workflows/pages.yml`

## デフォルトで読まない場所

以下は参考レーンです。実装や運用の判断に必要なときだけ開きます。

- `archive/`
- `docs/chatgpt_exports/`
- `docs/plans/`
- `docs/reports/`
- `records/`
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
- `STRUCTURE_GUIDE.md`: 参照順と責務
- `DECISIONS.md`: 採用済み判断の記録
- `TODO.md`: 現在地、次アクション、未解決事項
- `specs/`: 現在のポータル仕様
- `site/`: 現在の公開物

### 参考

- `archive/`: 方向転換前の成果物と設定
- `docs/`: 履歴資料、会話ログ、運用メモ
- `docs/reports/`: 開催後レポートや会員報告のドラフト
- `records/`: 録音・録画・PDF などの原本を置くローカル限定ストレージ
- `sessions/`: 作業ログ
- `ideas/`, `proposals/`: 今後の整理先

## トップレベルの役割

| パス | 役割 | コーディング時の既定 |
|---|---|---|
| `README.md` | プロジェクトの入口 | 読む |
| `STRUCTURE_GUIDE.md` | 参照順と責務 | 読む |
| `DECISIONS.md` | 採用済み判断の索引 | 読む |
| `TODO.md` | 現在の作業状態 | 読む |
| `specs/` | 現在の正史仕様 | 読む |
| `site/` | 公開中の With ポータル | 読む |
| `archive/` | 旧投票プロジェクトの退避先 | 必要時に読む |
| `.github/` | デプロイ設定 | 必要時に読む |
| `scripts/` | 補助スクリプト | 必要時に読む |
| `docs/explainers/` | 図解付きの理解用資料 | 必要時に読む |
| `docs/` | 履歴・参考資料 | 通常は読まない |
| `records/` | PDF や録音などの原本保管先。Git 管理外 | 通常は読まない |
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
- 会員向け公開物は `site/` に追加します
- 開催後レポートのドラフトは `docs/reports/` に入れます
- 重い原本データは `records/` に置き、Git 管理に含めません
- 旧プロジェクトの再確認が必要なときは `archive/` を参照します

## 現時点で注意すべき点

- `site/` は軽量な静的サイトです
- ページ保護はクライアントサイド実装なので、厳格な認証ではありません
- 旧 Firebase 構成は `archive/firebase/` に残していますが、現行公開では使っていません
