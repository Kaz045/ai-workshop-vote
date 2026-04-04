# With Portal

このリポジトリは、With. コミュニティで使うポータルサイトと、その背景資料を同じワークスペースで扱うためのプロジェクトです。

2026年3月に実施した AI ワークショップ投票と第1回ワークショップの成果物を壊さず残しながら、今後は「公開ページ + 会員向けアーカイブ」を持つポータルとして育てていきます。

## まず読む場所

- 入口: `README.md`
- 構成と参照順: `STRUCTURE_GUIDE.md`
- 採用済み判断: `DECISIONS.md`
- 現在の作業状態: `TODO.md`
- 実装・運用の正史: `specs/`

## 現在の主役

- `site/`: GitHub Pages で公開する With ポータル本体
- `site/index.html`: 公開トップページ
- `site/workshops/session-1.html`: 第1回ワークショップの会員向けアーカイブ
- `site/assets/`: CSS、JavaScript、画像などの静的アセット
- `site/components/`: 共通ヘッダー、共通フッター

## 旧プロジェクトの扱い

これまでの投票ページや Firebase 試作版は削除せず、`archive/` に退避しています。

- `archive/v1-vote-result/`: 旧公開ページ
- `archive/html_experiment/`: Firebase 前提の旧投票プロトタイプ
- `archive/specs/`: 方向転換前の仕様書
- `archive/firebase/`: 旧 Firebase 設定

## 現在の状態

- ポータルの土台として、静的 HTML + CSS + vanilla JS で再構成しています
- 第1回ワークショップのアーカイブを最初の会員向けページとして整理しました
- ページ単位の軽量なパスワード保護を入れています
- 議事録 PDF のような重いファイルは、Git 管理外の `records/` に移し、将来は外部リンクで参照する前提です

## 読む順番

1. `README.md`
2. `STRUCTURE_GUIDE.md`
3. `DECISIONS.md`
4. `TODO.md`
5. 必要な `specs/*.md`
6. `site/` 配下の実装
7. 必要があれば `archive/` と `docs/`

## 参考資料の扱い

- `docs/` は履歴・参考レーンです
- `docs/reports/` は開催後レポートなどの振り返り資料です
- `records/` はローカル限定の原本保管先で、Git 管理に含めません
- `docs/plans/` や `docs/chatgpt_exports/` は、そのまま実装指示として扱いません
- 新しい判断は `DECISIONS.md`、新しい正式仕様は `specs/` に反映してから進めます

## 公開情報

- GitHub Pages: `https://kaz045.github.io/with-portal/`
- GitHub Repository: `https://github.com/Kaz045/with-portal`
