# TODO — AI時代の仕事のリアル 投票ページ

---

## 🚨 Codex CLI 向け：現在の障害状況と対処指示（2026-03-07）

### 前提：このプロジェクトとは
- GitHub Pages でホストする単一HTMLの投票アプリ（`index.html`）
- Firebase（Firestore + 匿名認証）でリアルタイム投票を複数端末間で共有する
- Firebase の API キーは GitHub Actions のデプロイ時に Secrets から注入する仕組み
- GitHub リポジトリ: https://github.com/Kaz045/ai-workshop-vote
- デプロイ先: https://kaz045.github.io/ai-workshop-vote/
- ワークフローファイル: `.github/workflows/pages.yml`

### 現在の症状
- **全環境（Mac Safari/Chrome、iOS Safari、LINE WebView）でローカルデモモードになる**
- ブラウザのコンソールに以下のエラーが出ている：
  ```
  GET https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=%%FIREBASE_API_KEY%%
  Auth failed: FirebaseError: Firebase: Error (auth/api-key-not-valid.)
  ```
- `%%FIREBASE_API_KEY%%` がそのまま残っており、GitHub Actions で Secrets が注入されていない

### 根本原因
GitHub Actions の「Inject Firebase config from Secrets」ステップで、  
**GitHub Secrets のいずれか（おそらく `FIREBASE_APP_ID_LABEL`）が未設定のため、`sed` による置換が不完全、またはワークフロー全体が失敗している可能性が高い。**

### Firestore のデータパス（重要）
```
artifacts/<PROJECT_ID>/public/survey_results
```
`FIREBASE_APP_ID_LABEL` の値は `<YOUR_FIREBASE_APP_ID_LABEL>`（プロジェクトIDと同じ）と推定される。  
（TODO.md 下部の参照情報に記載されているパスと一致させること）

### 必要な GitHub Secrets の一覧
`.github/workflows/pages.yml` が要求する Secrets は以下の7つ：

| Secret 名 | Firebase 上の対応値 |
|---|---|
| `FIREBASE_API_KEY` | `<REDACTED>`（Firebase コンソール → プロジェクト設定 → マイアプリ → apiKey） |
| `FIREBASE_AUTH_DOMAIN` | `<REDACTED>`（例: `<project-id>.firebaseapp.com`） |
| `FIREBASE_PROJECT_ID` | `<REDACTED>` |
| `FIREBASE_STORAGE_BUCKET` | `<REDACTED>`（例: `<project-id>.firebasestorage.app`） |
| `FIREBASE_MESSAGING_SENDER_ID` | `<REDACTED>` |
| `FIREBASE_APP_ID` | `<REDACTED>` |
| `FIREBASE_APP_ID_LABEL` | `<REDACTED>`（Firestore パスのドキュメントIDとして使用） |

### Codex がやること（優先順）

**Step 1: GitHub Secrets の状態確認**
```bash
gh secret list --repo Kaz045/ai-workshop-vote
```
→ 上記7つがすべて存在するか確認する。

**Step 2: 不足している Secret を追加**
不足しているものがあれば `gh secret set` で追加する。  
`FIREBASE_APP_ID_LABEL` が不足している場合は以下で追加：
```bash
gh secret set FIREBASE_APP_ID_LABEL --body "<YOUR_FIREBASE_APP_ID_LABEL>" --repo Kaz045/ai-workshop-vote
```
他のキーの値は Firebase コンソール（https://console.firebase.google.com/project/<PROJECT_ID>）の  
「プロジェクト設定 → マイアプリ → vote-app」のSDK設定から取得する。  
**ただし API キー等の機密値はユーザーに確認してから設定すること。**

**Step 3: GitHub Actions を再実行**
```bash
gh workflow run pages.yml --repo Kaz045/ai-workshop-vote
```
または直近の失敗したワークフローを再実行：
```bash
gh run list --repo Kaz045/ai-workshop-vote --limit 3
gh run rerun <RUN_ID> --repo Kaz045/ai-workshop-vote
```

**Step 4: デプロイ後の動作確認**
```bash
# ワークフローの完了を待つ（約1〜2分）
gh run watch --repo Kaz045/ai-workshop-vote
```
完了後、https://kaz045.github.io/ai-workshop-vote/ のページソースで  
`apiKey:` が実際の値（`%%FIREBASE_API_KEY%%` ではない）になっていることを確認する。

### 直近のコード変更（2026-03-07 コミット `3e50573`）
LINEアプリ内ブラウザ対応のため `index.html` を以下のように変更済み：
1. Firebase SDK を動的 `import()` → 通常 `<script>` タグ（Compat版）に切り替え
2. LINE WebView を検出して外部ブラウザへの誘導バナーを追加
3. `<script type="module">` → `<script>` に変更
→ コード自体は正しい。問題は GitHub Secrets の欠如によるデプロイ失敗。

---

## 完了済み

- [x] 元のHTML（Gemini生成）のバグ解析
  - Firebase未設定時に画面が止まる、Firestoreパス不正（奇数セグメント）、エラー非表示 等
- [x] index.html 修正版を作成（Firebase / localStorage デュアルモード対応）
- [x] 企画書との文言整合（6テーマの説明文を企画書に合わせる）
- [x] Geminiオリジナルのデザイン要素を復元
  - 「AIブームの陥りやすい罠」比較ボックス＋メッセージボックス
  - 「ワークショップの設計」3ステップワークフロー＋最終ゴールボックス
- [x] ワークフローの3ステップを丸→角丸カードに変更（改行の読みやすさ改善）
- [x] GitHubリポジトリ作成・push（https://github.com/Kaz045/ai-workshop-vote）
- [x] GitHub Pages 有効化（https://kaz045.github.io/ai-workshop-vote/）
- [x] Firebase プロジェクト作成（<PROJECT_ID> / Spark無料プラン）
- [x] Firebase 設定値をHTMLに埋め込み
- [x] Firestore Database 有効化（テストモード）
- [x] Anonymous 認証 有効化
- [x] GitHub Pages でリアルタイム同期の動作確認 →「リアルタイム同期中」表示を確認

## 次にやること（ここから再開）

- [x] **投票ボタンのバグ修正（検証完了）**
  - 症状：一番下のテーマの投票ボタンを押すと、一番上のテーマに票が入るように見える
  - デバッグ用ログを `index.html`（ルート）に仕込み済み
  - **次の手順：**
    1. Firebase コンソールで投票データをリセット
       - Firestore → artifacts → <PROJECT_ID> → public → survey_results を削除
    2. ローカルの `index.html` をブラウザで直接開く（ダブルクリック）
    3. 「リアルタイム同期中」になるのを待つ
    4. 一番下のテーマの「👍 投票」を1回クリック → どのテーマの票が変わるか確認
    5. 別のテーマを1回クリック → 確認
    6. もう一度一番下を1回クリック → 確認
    7. Cursor に戻り、デバッグログの結果を解析してもらう
  - 仮説：
    - A: ボタンと行の両方のクリックが発火（二重投票）
    - B: ソート後の再描画でクリックハンドラが間違ったIDを参照
    - C: 再描画中のタイミングで別テーマに投票される
    - D: 実は正しく投票されているが、ソートで順番が変わるので「上のが増えた」ように見える

- [ ] デバッグ完了後、ログコードを除去してGitHubにpush
- [ ] Firebase セキュリティルールを本番用に設定（テストモードは30日で期限切れ）
- [ ] デバッグ用エラーメッセージを本番向けに差し替え（詳細エラー → やさしい日本語）
- [ ] README.md を最新状態に更新
- [ ] **セキュリティ対応：Git履歴に残存する Firebase 設定値の無効化と除去**
  - 2026-03-06 時点の確認で、過去コミットに Firebase の実設定値（`apiKey` / `authDomain` / `storageBucket` / `appId`）が残っている
  - 対策1（優先）: Firebase Console で該当 Web API キーをローテーションし、旧キーを無効化
  - 対策2: Auth / Firestore ルールを最小権限に再点検（キー露出前提で防御）
  - 対策3: `git filter-repo` 等で履歴から該当値を除去し、`--force` でリモート更新
  - 対策4: 履歴改変後、GitHub の Code Search / ローカル `git grep` で再スキャンして残存確認

## 参照情報

| 項目 | 値 |
|------|-----|
| GitHub リポジトリ | https://github.com/Kaz045/ai-workshop-vote |
| GitHub Pages URL | https://kaz045.github.io/ai-workshop-vote/ |
| Firebase プロジェクト | `<PROJECT_ID>`（Spark プラン） |
| Firebase コンソール | `https://console.firebase.google.com/project/<PROJECT_ID>` |
| Firestore ドキュメントパス | `artifacts/<PROJECT_ID>/public/survey_results` |
| ローカルファイル | html/index.html（開発用）、index.html（GitHub Pages用・デバッグログ入り） |
