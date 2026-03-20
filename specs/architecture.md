# アーキテクチャ

## 全体像

このリポジトリは、単一のアプリケーションコードベースというより、公開成果物、投票プロトタイプ、企画資料、運用メモをまとめたワークスペースです。
そのため、コード構造だけでなく、資料レーンの分離もアーキテクチャの一部として扱います。

## 現在の主要コンポーネント

### 1. 公開成果物

- `index.html`
- GitHub Pages で公開している静的ページ
- 役割は「投票受付終了」と「最終結果表示」

### 2. 投票プロトタイプ

- `html_experiment/index.html`
- Firebase Auth / Firestore を使うリアルタイム投票試作
- ただし、現時点では公開正史ではなく、文言とテーマ数も現行方針とずれています

### 3. デプロイ設定

- `.github/workflows/pages.yml`
- `main` への push または手動実行で GitHub Pages を更新
- まだ Firebase Secrets 前提の処理を含んでいます

### 4. 運用補助

- `scripts/security/`
- Firebase 設定値の痕跡調査や GitHub Secrets 更新補助を行います

### 5. ドキュメントレーン

- `specs/`: 正史仕様
- `docs/`: 履歴資料
- `ideas/`, `proposals/`, `sessions/`, `experiments/`, `outputs/`: 補助レーン

## 現在のデータフロー

### 公開ページ

1. メンテナが `main` に変更を入れる
2. GitHub Actions が Pages 用 artifact を生成する
3. GitHub Pages がルート `index.html` を配信する
4. 閲覧者は静的な最終結果を読む

### 旧プロトタイプ

1. `html_experiment/index.html` が Firebase 設定値を受け取る前提で起動する
2. 匿名認証後、Firestore `artifacts/{appId}/public/survey_results` に接続する
3. 投票 UI を更新する

この流れはあくまで試作時の構成であり、現在の公開正史ではありません。

## 設計上の注意点

- 現在の公開ページは静的ですが、デプロイワークフローは Firebase Secrets 前提です
- `html_experiment/` は 5 テーマ、公開結果ページは 4 テーマで、データモデルが分岐しています
- 企画書は `docs/plans/` に残っていますが、承認済み仕様としてはまだ昇格していません

## 今後の整理方針

- 企画が採用されたら `proposals/` と `specs/` に反映する
- ライブ投票を再開するなら、`html_experiment/` をそのまま使わず、要件とデプロイを再設計する
- 現行の GitHub Pages 運用は、静的ページ前提に簡略化できる余地があります
