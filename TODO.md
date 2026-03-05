# TODO — AI時代の仕事のリアル 投票ページ

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
- [x] Firebase プロジェクト作成（ai-workshop-vote / Spark無料プラン）
- [x] Firebase 設定値をHTMLに埋め込み
- [x] Firestore Database 有効化（テストモード）
- [x] Anonymous 認証 有効化
- [x] GitHub Pages でリアルタイム同期の動作確認 →「リアルタイム同期中」表示を確認

## 次にやること（ここから再開）

- [ ] **投票ボタンのバグ修正（デバッグ中）**
  - 症状：一番下のテーマの投票ボタンを押すと、一番上のテーマに票が入るように見える
  - デバッグ用ログを `index.html`（ルート）に仕込み済み
  - **次の手順：**
    1. Firebase コンソールで投票データをリセット
       - Firestore → artifacts → ai-workshop-vote → public → survey_results を削除
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

## 参照情報

| 項目 | 値 |
|------|-----|
| GitHub リポジトリ | https://github.com/Kaz045/ai-workshop-vote |
| GitHub Pages URL | https://kaz045.github.io/ai-workshop-vote/ |
| Firebase プロジェクト | ai-workshop-vote（Spark プラン） |
| Firebase コンソール | https://console.firebase.google.com/project/ai-workshop-vote |
| Firestore ドキュメントパス | artifacts/ai-workshop-vote/public/survey_results |
| ローカルファイル | html/index.html（開発用）、index.html（GitHub Pages用・デバッグログ入り） |
