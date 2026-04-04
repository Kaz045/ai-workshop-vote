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

## DEC-0004 - Firebase プロジェクト `ai-workshop-vote` を削除する

- Date: 2026-04-05
- Status: Accepted
- Context: 第1回投票は終了し、Firebase Firestore・Anonymous Auth・Hosting いずれも今後の用途がないと判断した。API キー漏えいインシデント（`docs/operations/firebase_api_key_incident_response.md`）の後始末も含め、不要なクラウドリソースを残し続けることはセキュリティ上のリスクになる
- Decision: Firebase Console 上のプロジェクト `ai-workshop-vote` を削除済み。`.firebaserc`・`firebase.json`・`firestore.rules`・`firestore.indexes.json` はリポジトリの履歴として保持するが、実稼働中のプロジェクトとは紐づかない状態
- Why: 使用中でないプロジェクトを放置すると、API キーやルール変更の管理コストが残り続けるため。削除によりリスクをゼロにする
- Affected files: `DECISIONS.md`, `docs/operations/firebase_cli_management.md`
- Follow-up: 将来 Firebase を再利用する場合は、新規プロジェクトを作成し、`.firebaserc` を更新してから改めて設計・デプロイを行う

## DEC-0003 - 開催後レポートは `docs/reports/`、原本メディアは `records/` で分離する

- Date: 2026-03-25
- Status: Accepted
- Context: 第1回ワークショップの開催が終わり、会員報告として残すテキスト文書と、今後追加される録音・録画・画像などの原本データの置き場を分ける必要が出てきた
- Decision: テキスト主体の開催後レポート、会員報告、文字起こし整理メモは `docs/reports/` に置く。録音・録画・画像などの原本メディアはトップレベル `records/` に置き、`.gitignore` で Git 管理から除外する
- Why: 振り返り文書は次回企画へ反映できる形で追跡可能に残しつつ、大容量かつ機微を含みうる原本データはローカル管理に分離したいため
- Affected files: `README.md`, `STRUCTURE_GUIDE.md`, `TODO.md`, `DECISIONS.md`, `docs/README.md`, `.gitignore`, `docs/reports/`, `records/`
- Follow-up: 第1回レポートに文字起こしと要約を取り込み、採用した改善方針を `proposals/` と `specs/` に昇格させる

## DEC-0004 - With ポータルサイトへ方向転換し、旧投票プロジェクトは `archive/` に退避する

- Date: 2026-04-05
- Status: Accepted
- Context: 第1回ワークショップまでの投票・開催・振り返りが一巡し、今後は With コミュニティで継続的に使えるポータルサイトが必要になった。主催者からは、ページ単位のパスワード保護を持つサイトにしたいという要望も出ている
- Decision: 現在の公開対象は `site/` 配下の With ポータルに切り替える。旧 `index.html`、`html_experiment/`、旧 `specs/`、Firebase 設定は `archive/` に移し、現行の正史は新しい `specs/` とルート文書に再構成する
- Why: これまでの成果物を残しつつ、今後の公開物と会員向けアーカイブを迷わず育てられる構造にするため
- Affected files: `site/`, `archive/`, `README.md`, `STRUCTURE_GUIDE.md`, `TODO.md`, `DECISIONS.md`, `specs/`, `.github/workflows/pages.yml`, `.gitignore`
- Follow-up: 会員向けページのリンク運用、議事録の外部リンク化、必要に応じた認証強化を今後判断する
