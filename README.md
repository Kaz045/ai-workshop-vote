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
- `STRUCTURE_GUIDE.md`: このリポジトリの構成と、目的別の参照先ガイド
- `html_experiment/index.html`: 作業用のHTML
- `html_experiment/README.md`: 詳細なセットアップ手順、トラブルシュート、チェックリスト
- `docs/`: 企画関連ドキュメント一式（詳細は `docs/README.md`）
- `TODO.md`: 次回再開用メモ

## 現在の状況

- GitHub Pages 公開済み
- Firebase プロジェクト接続済み
- リアルタイム同期動作確認済み
- 投票ボタンまわりのデバッグ完了（検証済み）

## 当日運用（投票回収前）

1. 公開URLを開き、右下ステータスが `リアルタイム同期中` になることを確認する
2. テスト投票を1票入れて、別端末にも即時反映されることを確認する
3. Firestore の対象ドキュメントが意図したパス（`artifacts/<PROJECT_ID>/public/survey_results`）で更新されることを確認する

## 当日運用（投票終了後）

1. Firestore の投票結果をエクスポートまたは記録する（スクリーンショット/手動記録でも可）
2. 投票URLを案内から外し、追加投票を止める
3. セキュリティ後処理（`TODO.md` の「Git履歴に残存する Firebase 設定値の無効化と除去」）を実施する

## 履歴改変後の同期手順（`main` を `--force-with-lease` 更新した場合）

履歴改変後は、他端末のローカルクローンを `origin/main` に同期してください。

### 未コミット変更がない場合

```bash
cd <repo>
git fetch origin
git checkout main
git reset --hard origin/main
git gc --prune=now
```

### 未コミット変更がある場合

```bash
cd <repo>
git stash push -u -m "before-history-rewrite-sync"
git fetch origin
git checkout main
git reset --hard origin/main
git stash pop
```

## 詳細ドキュメント

セットアップ手順や Firebase の補足は `html_experiment/README.md` を参照してください。
