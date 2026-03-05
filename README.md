# AI時代の仕事のリアル — リアルタイム投票ページ

ワークショップ「AI時代の仕事のリアル」で使う、スマホ対応のリアルタイム投票ページです。

## 公開URL

- GitHub Pages: `https://kaz045.github.io/ai-workshop-vote/`
- GitHub Repository: `https://github.com/Kaz045/ai-workshop-vote`

## できること

- 参加者がスマホやPCから投票できる
- Firebase 設定済み環境では、複数端末でリアルタイム集計できる
- Firebase が使えない場合でも、ローカルデモモードで動く

## 使い方

1. 公開URLを参加者に共有する
2. ページ右下のステータスを確認する
3. `リアルタイム同期中` なら本番モード、`ローカルデモモード` なら簡易デモモード

## 主なファイル

- `index.html`: GitHub Pages 公開用のメインページ
- `html/index.html`: 作業用のHTML
- `html/README.md`: 詳細なセットアップ手順、トラブルシュート、チェックリスト
- `TODO.md`: 次回再開用メモ

## 現在の状況

- GitHub Pages 公開済み
- Firebase プロジェクト接続済み
- リアルタイム同期動作確認済み
- 投票ボタンまわりのデバッグは継続中

## 詳細ドキュメント

セットアップ手順や Firebase の補足は `html/README.md` を参照してください。
