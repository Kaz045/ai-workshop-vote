# TODO

## 現在地

- ワークスペースの正史レイヤーを 2026-03-21 に再構成済み
- 現在の公開ページは投票受付終了後の結果表示で、ライブ投票は停止中
- 次の主作業は、投票結果を踏まえた次回ワークショップ企画の正式化です

## Done

- ルート文書と `specs/` を追加し、参照順を固定
- `docs/` を履歴・参考レーン、`specs/` を実装・運用の正史として整理
- 2026-03 の最終結果ページをルート `index.html` として保持
- 既存の Firebase 運用メモとセキュリティ対応メモを `docs/operations/` に保持

## In Progress

- 投票結果から、次に開催するワークショップの正式スコープを絞る
- `docs/plans/` にある企画メモのうち、どこまでを正史に昇格させるかを見極める

## Next

1. `html_experiment/` を将来再利用するのか、履歴資産として固定するのか決める
2. 再利用する場合は、テーマ構成、Firebase データモデル、GitHub Pages デプロイ方針を現行方針に合わせて更新する
3. 次回ワークショップの採用方針を `proposals/` と `specs/` に昇格させる
4. 現在の `.github/workflows/pages.yml` から不要な Firebase Secrets 依存を外すか検討する

## Open Questions

- このリポジトリは今後も `ai-workshop-vote` 由来の公開ページ中心で運用するか、それともワークショップ全体の母艦リポジトリとして育てるか
- 次回案内で正史にするテーマセットは、最終結果ページの 4 テーマか、新しい企画メモ側の 2 回シリーズ案か
- `html_experiment/index.html` の 5 テーマ構成を今後どこまで残す価値があるか

## Deferred

- Firebase 設定値の履歴クリーンアップとキー再ローテーション
- ライブ投票を再開する場合の Firestore ルール見直しと本番運用設計

## Reference

- 運用メモ: `docs/operations/firebase_api_key_incident_response.md`
- 旧企画書: `docs/plans/`
- 会話ログ: `docs/chatgpt_exports/`
