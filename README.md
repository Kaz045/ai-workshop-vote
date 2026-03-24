# KAZ式 AI時代の仕事論

このリポジトリは、2026年3月の AI ワークショップ投票、その後の結果公開、第1回開催後のレポート整理、次回以降のシリーズ企画を同じワークスペースで扱う `hybrid` プロジェクトです。

現在は、公開成果物と履歴資料が混在していた状態を整理し、実装・運用の正史を `specs/` とルート文書に集約しています。

## 現在の正史

- 入口: `README.md`
- 構成と参照順: `STRUCTURE_GUIDE.md`
- 採用済み判断: `DECISIONS.md`
- 現在の作業状態: `TODO.md`
- 実装・運用の正史: `specs/`

## 主要エントリーポイント

- `index.html`: GitHub Pages で公開している最終結果ページ
- `html_experiment/index.html`: Firebase 前提のリアルタイム投票プロトタイプ
- `docs/reports/第1回ワークショップ_開催後レポート.md`: 第1回開催後の会員報告ドラフト
- `.github/workflows/pages.yml`: GitHub Pages デプロイ設定
- `docs/operations/firebase_api_key_incident_response.md`: Firebase 関連の運用メモ
- `records/`: 録音・録画・画像などのローカル保管場所（Git 管理外）

## 現在の状態

- 投票は 2026-03-13 に締め切り済みです
- ルートの `index.html` は静的な結果表示ページです
- 最終集計は `AIでツールを作る` 11票、`AI開発の世界を覗く` 7票、`ChatGPTなどを仕事の相棒として使う` 4票、`企業でのAI導入とMS Copilot` 1票です
- 第1回ワークショップの開催は完了し、開催後レポートの下書きを `docs/reports/` で開始しました
- `html_experiment/` は 5 テーマ構成の旧プロトタイプで、現行の結果ページや最新企画メモとは一致しません
- 録音・録画・画像などの原本は `records/` に置き、Git 管理から外します

## 読む順番

1. `README.md`
2. `STRUCTURE_GUIDE.md`
3. `DECISIONS.md`
4. `TODO.md`
5. 必要な `specs/*.md`
6. 関連コードと設定ファイル

## 参考資料の扱い

- `docs/` は履歴・参考レーンです
- `docs/reports/` は開催後レポート、会員報告、文字起こし整理メモの置き場です
- `ideas/` と `proposals/` は今後の整理先です
- `records/` はローカル限定の原本保管先で、Git 管理に含めません
- `docs/plans/` や `docs/chatgpt_exports/` は、そのまま実装指示として扱いません
- 新しい実装判断は `DECISIONS.md` と `specs/` に反映してから進めます

## 公開情報

- GitHub Pages: `https://kaz045.github.io/ai-workshop-vote/`
- GitHub Repository: `https://github.com/Kaz045/ai-workshop-vote`
