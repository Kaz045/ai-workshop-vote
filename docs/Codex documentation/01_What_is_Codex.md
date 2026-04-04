# 01 What is Codex

## 3行要約
- Codex は OpenAI のコーディングエージェントで、コード生成だけでなく、コード読解、レビュー、デバッグ、テスト実行、PR までを支援する。
- 利用形態はローカル実行の `CLI` / `IDE extension` と、クラウド委任の `Codex web`、複数スレッド運用向けの `Codex app` に分かれる。
- 2026-03-20 確認時点では ChatGPT の複数プランに含まれ、期間限定で Free / Go にも提供されている。

## 対象読者
Codex の全体像を先に掴みたい開発者、導入判断をする技術リード、NotebookLM 用の基礎教材を作りたい人。

## 重要キーワード
`Codex`, `coding agent`, `CLI`, `IDE extension`, `Codex web`, `Codex app`, `cloud tasks`, `worktrees`, `skills`, `automations`, `pricing`

## 現在の定義

### ページ: Codex | OpenAI Developers
出典: [https://developers.openai.com/codex](https://developers.openai.com/codex)

OpenAI Developers の overview では、Codex は「どこでコードを書いていても使える 1 つのエージェント」として整理されている。主な用途は次の 5 つに集約できる。

- `Write code`: 既存のプロジェクト構造や慣習に合わせてコードを書く
- `Understand unfamiliar codebases`: レガシーや大規模コードベースを読んで説明する
- `Review code`: バグ、ロジックミス、未処理の edge case を見つける
- `Debug and fix problems`: 障害の原因を追跡し、修正案を作る
- `Automate development tasks`: リファクタ、テスト、移行、セットアップのような反復作業を自動化する

このページは、Codex を単なるチャット UI ではなく、ファイル読み書きとコマンド実行を伴う実務向けエージェントとして位置付けている。

### ページ: Codex | OpenAI
出典: [https://openai.com/codex/](https://openai.com/codex/)

製品ページでは、Codex は「agents で作るための最良の方法」として説明されている。訴求軸は次の通り。

- 実際のエンジニアリング作業に耐えること
- 複数エージェントの並列運用に向くこと
- `Skills` により、コーディング以外の周辺作業にも適応できること
- `Automations` により、常時バックグラウンドで作業を回せること
- レビューやテストの質を底上げして、チーム全体の品質基準を上げること

ここでは「同じエージェントを app / editor / terminal で使う」という統一された体験が強調されている。

### ページ: Using Codex with your ChatGPT plan | OpenAI Help Center
出典: [https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan](https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan)

Help Center は、Codex を「コードを書く、レビューする、出荷を速めるための AI coding agent」と説明する。さらに、使い方を 2 系統に分けている。

- `Pair with Codex`: terminal、IDE、app でローカルに並走する
- `Delegate to Codex in the cloud`: バックグラウンドでクラウド実行させる

この説明は、Codex を「対話相手」ではなく、ローカル作業とクラウド委任の両方を持つ開発支援基盤として捉えるのに向いている。

## できることの整理

### ローカルでできること
主に `CLI` と `IDE extension` で行う。

- リポジトリを読み、ファイルを編集する
- ローカルコマンドやテストを実行する
- 画像やスクリーンショットを入力に含める
- 作業差分をレビューする
- 継続中のスレッドや過去の会話を再開する

### クラウドでできること
主に `Codex web` と一部の IDE / app の cloud mode で行う。

- 分離されたクラウド環境で長めのタスクをバックグラウンド実行する
- GitHub と接続してレビューや PR 作成につなげる
- 環境変数、secrets、setup script、internet access を環境単位で制御する

### デスクトップ運用でできること
主に `Codex app` で行う。

- 複数プロジェクト、複数スレッド、複数 worktree を並行管理する
- `Skills` と `Automations` を使って、反復作業やチーム固有ワークフローを定着させる
- Git diff、inline comment、stage / revert、commit / PR をアプリ内で完結させる

## 提供形態

### `Codex CLI`
ローカル端末で動くオープンソースのエージェント。Rust 製で、選択したディレクトリのコードを読み、書き換え、コマンドを実行できる。

### `Codex IDE extension`
VS Code 系エディタに統合されるフロントエンド。CLI と同じエージェントと設定を共有しつつ、開いているファイルや選択コードを文脈に使いやすい。

### `Codex web`
GitHub 接続を前提に、クラウド環境へタスクを委任するインターフェース。長いジョブをバックグラウンドで走らせる用途に向く。

### `Codex app`
複数スレッド、複数プロジェクト、複数 worktree を運用するための専用デスクトップ UI。CLI / IDE と設定や履歴を共有する前提で設計されている。

## プラン同梱と利用条件

### ページ: Pricing – Codex | OpenAI Developers
出典: [https://developers.openai.com/codex/pricing](https://developers.openai.com/codex/pricing)

2026-03-20 確認時点の pricing ページでは、Codex は次のプランに含まれる。

- `ChatGPT Plus`: `$20/month`
- `ChatGPT Pro`: `$200/month`
- `ChatGPT Business`: `$30/user/month`
- `ChatGPT Enterprise & Edu`: 固定価格はページ上で個別提示せず、営業または柔軟課金前提

同ページは、2026-03-20 確認時点で「期間限定で `ChatGPT Free` と `Go` でも Codex を試せる」と明記している。また、プランによって cloud tasks、automatic code review、追加 credits、管理機能の強さが変わる。

API key 利用は別枠で、CLI / SDK / IDE extension では使えるが、`GitHub code review` や `Slack` のようなクラウド機能は含まれない。料金は token ベースの API pricing が適用される。

### ページ: Using Codex with your ChatGPT plan | OpenAI Help Center
出典: [https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan](https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan)

Help Center でも 2026-03-20 確認時点で、`Plus` / `Pro` / `Business` / `Enterprise/Edu` への同梱、期間限定の `Free` / `Go` 提供、そして「利用量はタスクの規模・複雑さ・ローカルかクラウドかで変わる」ことが説明されている。

### 利用量の読み方
Pricing ページの FAQ は、message 数が固定件数ではなく、タスクサイズやモデルによって大きく変動することを前提にしている。小さな修正は少ない消費で済む一方、長時間タスクや大規模コードベースでは消費が増える。

## 歴史的文脈

### ページ: Introducing Codex | OpenAI
出典: [https://openai.com/index/introducing-codex/](https://openai.com/index/introducing-codex/)

`2025-05-16` の発表時点で、Codex は research preview のクラウド型 software engineering agent として紹介された。主要メッセージは次の通り。

- 各タスクは独立した cloud sandbox で走る
- コード編集だけでなく、テストや lint 実行まで含めて完走を目指す
- 実行ログや test output を根拠として提示する
- `AGENTS.md` によってリポジトリ固有の運用ルールを学習できる

同記事は `2025-06-03` 更新として、Plus 対応と task execution 中の internet access 提供開始にも触れている。ただし、現在の仕様は developers docs と Help Center を優先して読むべきである。

### ページ: Introducing the Codex app | OpenAI
出典: [https://openai.com/index/introducing-the-codex-app/](https://openai.com/index/introducing-the-codex-app/)

`2026-02-02` の app 発表は、Codex を「単一エージェントとのペア作業」から「複数エージェントの監督」へ拡張する文脈で説明した。ここでの主張は、Codex app が command center for agents だという点にある。

## 教材として押さえるべき理解

1. Codex は単一製品ではなく、同じエージェントを複数 surface で使う体系である。
2. 強みはコード生成そのものより、読解、検証、差分レビュー、PR 化までをまとめて扱えることにある。
3. 現在の使い分けは、`CLI / IDE = ローカル伴走`、`web = クラウド委任`、`app = 複数案件の司令塔` と考えると理解しやすい。
