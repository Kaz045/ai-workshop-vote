# DECISIONS

## DEC-0001 - このリポジトリを `hybrid` ワークスペースとして再定義する

- Date: 2026-03-21
- Status: Accepted
- Context: 公開ページ、投票プロトタイプ、企画書、会話ログ、運用メモが同じ階層で混在しており、どれを正史として読むべきかが分かりにくかった
- Decision: `README.md`、`STRUCTURE_GUIDE.md`、`DECISIONS.md`、`TODO.md`、`specs/` を正史にし、`docs/` などは参考レーンとして扱う。基準ディレクトリ `sessions/`、`projects/`、`prompts/`、`ideas/`、`proposals/`、`experiments/`、`outputs/`、`skills/` を追加する
- Why: 既存資料を壊さずに、今後の実装・運用判断の入口を固定するため
- Affected files: `README.md`, `STRUCTURE_GUIDE.md`, `TODO.md`, `DECISIONS.md`, `specs/`, `docs/README.md`, 新規ディレクトリ群
- Follow-up: 次に採用するワークショップ企画を決めたら、`docs/plans/` から `proposals/` と `specs/` に昇格させる

## DEC-0002 - 現在の公開成果物は「投票受付終了後の結果ページ」として扱う

- Date: 2026-03-21
- Status: Accepted
- Context: ルート `index.html` は 2026-03-13 締切後の最終結果ページだが、`html_experiment/index.html` は Firebase 前提の旧投票プロトタイプのままで、テーマ数と文言も一致していない
- Decision: ルート `index.html` を現時点の公開正史とし、`html_experiment/` は履歴・実験レーンとして保持する。将来再利用する場合は、テーマ構成、データモデル、デプロイ方式を再設計してから扱う
- Why: すでに公開されている内容と実際の投票結果を優先し、未整合の試作版を誤って正史として読まないようにするため
- Affected files: `README.md`, `STRUCTURE_GUIDE.md`, `TODO.md`, `specs/requirements.md`, `specs/architecture.md`, `specs/data-model.md`, `specs/ui-ux.md`
- Follow-up: `html_experiment/` を将来再利用するか、完全に履歴化するかを決める
