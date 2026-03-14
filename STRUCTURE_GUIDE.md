# ストラクチャーガイド

このファイルは、
「どこに何があるか」
「何を探したいときにどこを見ればいいか」
をすぐ分かるようにするためのガイドです。

## まず結論

### 企画書や構成案を探したい

`docs/plans/` を見る。

- 手作業で整理した企画書: `docs/plans/ワークショップ企画書_v1.0.md`, `docs/plans/ワークショップ企画書_v1.5.md`
- ChatGPT の会話エクスポート: `docs/chatgpt_exports/ChatGPT-00_...` 〜 `docs/chatgpt_exports/ChatGPT-03_...`
- 次回の企画メモ: `docs/plans/次回ワークショップ企画メモ_2026-03-15.md`

### 今公開されているページ本体を見たい

ルートの `index.html` を見る。

- GitHub Pages の公開エントリーポイント
- 現在は「投票受付終了後」の案内・結果表示ページとして使っている

### 投票ページの開発用HTMLや過去の作業版を見たい

`html_experiment/` を見る。

- `html_experiment/index.html`: 開発・検証用の投票ページ
- `html_experiment/AI時代の仕事のリアル_企画書.html`: 元になった参考HTML
- `html_experiment/README.md`: ローカル確認方法、Firebase 設定、トラブルシュート

### 次に何をやるか、再開地点を知りたい

`TODO.md` を見る。

- 未完了タスク
- 過去の障害状況
- 当日運用メモ
- セキュリティ対応の残作業

### デプロイ設定や GitHub Pages の仕組みを見たい

`.github/workflows/pages.yml` を見る。

- `main` への push で GitHub Pages を更新
- ルートの `index.html` を含むリポジトリ内容を配信
- Firebase 関連の Secrets を注入する処理が入っている

### Firebase やセキュリティ対応を見たい

`docs/operations/firebase_api_key_incident_response.md` と `scripts/security/` を見る。

- `docs/operations/firebase_api_key_incident_response.md`: 対応方針のメモ
- `scripts/security/find_firebase_key_commits.sh`: 履歴に残ったキー痕跡の調査
- `scripts/security/set_github_firebase_secrets.sh`: GitHub Secrets 更新補助

## ルート構成

```text
.
├── README.md
├── STRUCTURE_GUIDE.md
├── TODO.md
├── index.html
├── docs/
│   ├── README.md
│   ├── plans/
│   ├── chatgpt_exports/
│   └── operations/
├── html_experiment/
├── scripts/
└── .github/
```

## ディレクトリごとの役割

### ルート

リポジトリの入口。
公開ページ本体と、全体把握用のドキュメントが置いてある。

主要ファイル:

- `README.md`: リポジトリ概要、公開URL、運用メモ
- `STRUCTURE_GUIDE.md`: このガイド
- `TODO.md`: 再開用メモ、未完了タスク、障害状況
- `index.html`: GitHub Pages の公開対象になるメインHTML

### `docs/`

文章ドキュメントの集約場所。
役割別にサブフォルダへ分けている。

サブフォルダ:

- `docs/plans/`: 企画書、構成案、進行中メモ
- `docs/chatgpt_exports/`: ChatGPT の会話エクスポート
- `docs/operations/`: 運用、障害、セキュリティ対応メモ
- `docs/README.md`: `docs/` 配下の案内

使い分けの目安:

- 今後の企画を自分で詰めるなら `docs/plans/`
- 会話の流れや発想の元ネタを見たいなら `docs/chatgpt_exports/`
- セキュリティ事故対応を見るなら `docs/operations/`

### `html_experiment/`

HTML の開発・検証・参考保存用。
公開トップとは別に、作業用のHTMLを置いている。

主要ファイル:

- `html_experiment/index.html`: 作業用の投票ページ
- `html_experiment/AI時代の仕事のリアル_企画書.html`: 初期素材・参考用
- `html_experiment/README.md`: セットアップ手順、ローカル確認、Firebase 手順

見る場面:

- レイアウトや投票UIを触りたい
- Firebase 接続のローカル確認をしたい
- 元デザインとの差分を確認したい

### `scripts/`

補助スクリプト置き場。
現在はセキュリティ対応用が中心。

`scripts/security/` の中身:

- `find_firebase_key_commits.sh`: Git 履歴に API キー形式の文字列が入ったコミットを探す
- `set_github_firebase_secrets.sh`: `gh` CLI 経由で Firebase 関連 Secrets を設定する

### `.github/`

GitHub Actions など、リポジトリ運用用の設定。

主要ファイル:

- `.github/workflows/pages.yml`: GitHub Pages デプロイ用ワークフロー

## 目的別の参照先

| 探したいもの | 見る場所 | 補足 |
|---|---|---|
| リポジトリの概要 | `README.md` | 最初に読む入口 |
| どこに何があるか | `STRUCTURE_GUIDE.md` | このファイル |
| 再開ポイント、残作業 | `TODO.md` | 当日運用メモもここ |
| 今の公開ページ | `index.html` | GitHub Pages の入口 |
| 投票ページの作業版 | `html_experiment/index.html` | 開発・検証用 |
| ローカル確認方法 | `html_experiment/README.md` | Firebase 手順あり |
| ワークショップ企画書 | `docs/plans/` | 企画関連の基本置き場 |
| ChatGPT の元会話 | `docs/chatgpt_exports/` | 参考資料として保存 |
| 次回企画の叩き台 | `docs/plans/次回ワークショップ企画メモ_2026-03-15.md` | 今後の作業起点 |
| セキュリティ事故対応 | `docs/operations/firebase_api_key_incident_response.md` | 手順メモ |
| Secrets 注入と Pages デプロイ | `.github/workflows/pages.yml` | GitHub 側の挙動を見る場所 |
| Firebase Secrets 更新補助 | `scripts/security/set_github_firebase_secrets.sh` | `gh` CLI 前提 |

## 運用上の見方

### 企画を進めるとき

1. `docs/plans/` を見る
2. 必要なら `TODO.md` で未完了事項を確認する
3. 新しい企画メモは `docs/plans/` に増やす

### 公開ページを直すとき

1. まず `index.html` を見る
2. ローカル検証や比較が必要なら `html_experiment/` も見る
3. デプロイの仕組み確認が必要なら `.github/workflows/pages.yml` を見る

### 障害対応やセキュリティ対応をするとき

1. `TODO.md` の障害メモを確認する
2. `docs/operations/firebase_api_key_incident_response.md` を確認する
3. 必要に応じて `scripts/security/` を使う

## 補足

- `.cursor/` はローカルのデバッグログ置き場で、アプリ本体ではない
- `.venv-filter/` は `git filter-repo` 用のローカル仮想環境で、公開サイトの動作には直接関係しない
- `.git/` は Git 管理用ディレクトリなので、通常の作業対象としては見なくてよい
