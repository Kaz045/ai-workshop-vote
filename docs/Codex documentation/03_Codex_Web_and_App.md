# 03 Codex Web and App

## 3行要約
- `Codex web` は GitHub 接続を前提に、クラウド環境へタスクを委任する surface である。
- `Codex app` は複数プロジェクト・複数 thread・複数 worktree を並列運用するための desktop command center として設計されている。
- cloud environments、review pane、worktrees、local environments を理解すると、app / web の役割分担が見えやすくなる。

## 対象読者
クラウド委任や desktop 運用を前提に Codex を使いたい開発者、複数案件を並行で回す人。

## 重要キーワード
`Codex web`, `Codex app`, `cloud environments`, `worktree`, `review pane`, `local environments`, `cloud tasks`, `GitHub connection`, `container caching`

## Codex web の役割

### ページ: Web – Codex | OpenAI Developers
出典: [https://developers.openai.com/codex/cloud](https://developers.openai.com/codex/cloud)

Codex web overview は、web surface を「クラウドで Codex に委任する場所」と説明する。要点は次の通り。

- Codex は read / edit / run ができる coding agent
- Codex cloud では task をバックグラウンドで、しかも並列に実行できる
- 利用開始には [Codex on ChatGPT](https://chatgpt.com/) で GitHub account を接続する
- GitHub 接続により、repository を読んで PR を作れる

この surface は、ローカル伴走よりも「長めの task を投げて待つ」利用に向く。

## Cloud environments の中身

### ページ: Cloud environments – Codex web | OpenAI Developers
出典: [https://developers.openai.com/codex/cloud/environments](https://developers.openai.com/codex/cloud/environments)

Cloud environments ページは、クラウド task がどう走るかをかなり具体的に説明している。

### task 実行の流れ
1. Codex が container を作り、指定 branch または commit SHA で repo を checkout する
2. setup script を実行する
3. environment の internet access 設定を適用する
4. agent が terminal command をループ実行し、編集・検証を進める
5. 完了時に answer と diff を返し、PR 作成や follow-up ができる

### default image
- default container image は `universal`
- common languages、packages、tools がプリインストールされている
- runtime version は environment settings で pin できる
- 追加 package は setup script で入れられる

### environment variables と secrets
- environment variables は setup script と agent phase の両方で有効
- secrets は暗号化保存され、task execution 時だけ復号される
- secrets は setup scripts でのみ使え、agent phase には渡らない

### setup の考え方
- `npm`、`yarn`、`pnpm`、`pip`、`pipenv`、`poetry` などでは automatic setup が使える
- 複雑な環境では custom setup script を書く
- setup script は agent と別 Bash session で動くため、単純な `export` は agent phase に残らない

### container caching
- cache は最大 12 時間保持される
- cached container 再開時には branch checkout と optional maintenance script が走る
- setup script、maintenance script、environment variables、secrets を変えると cache は invalidation される
- Business / Enterprise では cache が workspace 内で共有される

## Codex app の役割

### ページ: App – Codex | OpenAI Developers
出典: [https://developers.openai.com/codex/app](https://developers.openai.com/codex/app)

app overview は、Codex app を「Your Codex command center」と位置付ける。特徴は次の通り。

- threads を parallel に扱う desktop experience
- built-in worktree support
- automations
- Git functionality

getting started の流れは単純で、ダウンロード、sign in、project 選択、最初の message 送信で始める。sign in は ChatGPT account か OpenAI API key で行えるが、API key では `cloud threads` のような一部機能が使えないことがある。

## Codex app の主要機能

### ページ: Features – Codex app | OpenAI Developers
出典: [https://developers.openai.com/codex/app/features](https://developers.openai.com/codex/app/features)

app features ページから読むと、Codex app は「並列運用のための UI」と理解すると筋が良い。

### マルチプロジェクト運用
- 1 つの window で複数 project を持てる
- monorepo でも app project を分けて、sandbox 対象を狭くできる

### modes
- `Local`: 現在の project directory で動かす
- `Worktree`: Git worktree に隔離して動かす
- `Cloud`: configured cloud environment で remote 実行する

### built-in Git
- diff pane で差分を見る
- inline comment で Codex に修正指示を出す
- stage / revert を file 単位や hunk 単位で操作する
- commit / push / pull request まで app 内で行える

### そのほかの実務機能
- image input
- background notifications
- `Ctrl` + `M` の voice dictation
- floating pop-out window
- IDE extension との同期
- approvals と sandboxing の可視化

### 注目ポイント
このページでは、Local と Worktree はどちらもユーザーのコンピュータ上で走り、Cloud だけが remote 実行だと明示している。

## app settings の考え方

### ページ: Settings – Codex app | OpenAI Developers
出典: [https://developers.openai.com/codex/app/settings](https://developers.openai.com/codex/app/settings)

settings ページは、app を単体製品としてではなく CLI / IDE と設定共有する front-end として扱っている。

### 主な設定カテゴリ
- `General`: file open 先、command output 表示、multiline prompt、sleep 抑止
- `Notifications`: 通知タイミング
- `Agent configuration`: common setting は UI、詳細は `config.toml`
- `Appearance`: theme、accent、font
- `Git`: branch naming、force push、commit / PR description prompt
- `Integrations & MCP`: external tool 接続
- `Personalization`: `Friendly` / `Pragmatic` / `None` と custom instructions

特に重要なのは、MCP 設定が `config.toml` に住むため、app の設定が CLI / IDE と共有される点である。

## review pane の意味

### ページ: Review – Codex app | OpenAI Developers
出典: [https://developers.openai.com/codex/app/review](https://developers.openai.com/codex/app/review)

review pane は Git repository 前提の機能で、Codex が変えた部分だけでなく repository の uncommitted changes 全体を見せる。

### review pane が見せるもの
- Codex が変えた差分
- 自分が変えた差分
- そのほかの未コミット差分

### review の使い方
- diff scope は uncommitted / all branch changes / last turn changes を切り替えられる
- file をクリックすると editor に飛べる
- line 単位の inline comment を付けて Codex に具体的な修正指示を渡せる
- stage / unstage / revert を diff 全体、file 単位、hunk 単位で操作できる

このページは、Codex との対話を「チャット」から「差分中心のレビュー」に引き戻す役割を review pane が持つことを示している。

## worktrees の役割

### ページ: Worktrees – Codex app | OpenAI Developers
出典: [https://developers.openai.com/codex/app/worktrees](https://developers.openai.com/codex/app/worktrees)

worktrees ページは、Codex app における並列作業の基礎概念を説明する。

- worktree は Git worktree を使った 2 つ目以降の checkout
- file の実体は別だが、Git metadata は共有する
- foreground を `Local`、background を `Worktree` と考えると分かりやすい
- `Handoff` で Local と Worktree の間を安全に行き来できる

### worktree を使う利点
1. 現在の local 作業を崩さずに並列 task を走らせる
2. background で待ち時間の長い task を回す
3. 準備ができたら Local に handoff して IDE で詳しく確認する

### 運用上の注意
- worktree は disk を多く使う
- Codex app は既定で最近の 15 個の Codex-managed worktrees を保持する
- archive や設定上限超過で自動削除されることがある
- pinned thread や in-progress thread に紐づく worktree は保護される

## local environments の役割

### ページ: Local environments – Codex app | OpenAI Developers
出典: [https://developers.openai.com/codex/app/local-environments](https://developers.openai.com/codex/app/local-environments)

local environments は、worktree 用の setup steps と project 共通 action を定義する仕組みである。

- setup script で依存関係導入や initial build を自動化する
- OS ごとに script を分けられる
- `Actions` で dev server 起動や test 実行などの共通 task を top bar に出せる
- 生成される設定ファイルは repository に check in して共有できる

これは app 特有の運用補助であり、background worktree を実務投入しやすくするための足場になっている。

## app の availability に関する公式差分

### 差分の内容
- app overview ページは 2026-03-20 確認時点で「available on macOS (Apple Silicon)」と書いている
- Help Center は 2026-03-20 確認時点で「The Codex app is available for MacOS and Windows」と書いている
- `Introducing the Codex app` 記事には `March 4, 2026 update: The Codex app is now available on Windows.` とある

### 教材としての扱い
この教材では、現行状態は「macOS と Windows で利用可能」と整理する。ただし developers docs の app overview 文言は更新が追いついていない可能性があるため、surface availability は複数公式ページを突き合わせて確認する前提で読む。

## 歴史的文脈

### ページ: Introducing the Codex app | OpenAI
出典: [https://openai.com/index/introducing-the-codex-app/](https://openai.com/index/introducing-the-codex-app/)

この発表記事は、app を「command center for agents」と説明する。特に重要なのは次の 3 点である。

- existing IDE / terminal は multi-agent orchestration に最適化されていない
- app は thread / project / diff review / editor handoff をまとめて扱う
- skills により、Codex は code generation を超えて仕事を進める agent になる

製品思想を理解するには、この historical page が最も分かりやすい。
