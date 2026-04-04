# アーキテクチャ

## 全体像

このリポジトリは、With ポータル本体、現在の仕様書、旧プロジェクトの履歴資産をまとめたワークスペースです。
現行公開物は `site/`、履歴資産は `archive/`、背景資料は `docs/` に分離します。

## 現在の主要コンポーネント

### 1. 公開トップページ

- `site/index.html`
- 役割はポータルの入口
- 第1回アーカイブへの導線を持つ

### 2. 会員向けアーカイブ

- `site/workshops/session-1.html`
- 役割は第1回ワークショップの振り返り
- JavaScript によるページ単位の保護を使う

### 3. 共通アセット

- `site/assets/css/main.css`
- `site/assets/css/with-theme.css`
- `site/assets/js/layout.js`
- `site/assets/js/password-gate.js`

### 4. 共通パーツ

- `site/components/header.html`
- `site/components/footer.html`
- 各ページから fetch で読み込む

### 5. 履歴資産

- `archive/v1-vote-result/`
- `archive/html_experiment/`
- `archive/specs/`
- `archive/firebase/`

## 現在のデータフロー

### 公開ページ

1. メンテナが `site/` とルート文書を更新する
2. GitHub Actions が `site/` を Pages artifact としてアップロードする
3. GitHub Pages がポータルを配信する
4. 閲覧者はトップページまたは会員向けページを開く

### 会員向けページ

1. ページ読み込み時は保護コンテンツを隠す
2. ユーザーがパスワードを入力する
3. `password-gate.js` が SHA-256 ハッシュを比較する
4. 一致したら `sessionStorage` に状態を保存してコンテンツを表示する

## 設計上の注意点

- ページ保護は「軽いアクセス制御」であり、厳格な認証ではない
- 重い原本データは `records/` へ移し、公開 artifact に含めない
- 旧 Firebase 資産は今の公開アーキテクチャには関与しない
