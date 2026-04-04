# 99 Glossary

## 3行要約
- Codex の用語は `surface`、`execution mode`、`safety control`、`workflow asset` の 4 群に分けると覚えやすい。
- 特に `web search` と `internet access`、`Local` と `Worktree`、`skill` と `automation` は混同しやすい。
- この用語集は公式 Codex ページで繰り返し出る語だけに絞っている。

## 対象読者
NotebookLM に読み込む前提で、Codex 用語の意味を短く引ける辞書が欲しい人。

## 重要キーワード
`Codex`, `surface`, `mode`, `sandbox`, `approval`, `skill`, `automation`, `worktree`, `cloud environment`, `AGENTS.md`

## 用語集

### `AGENTS.md`
Codex に repository 固有のルールや lint / test コマンド、作法を伝えるためのテキストファイル。CLI、cloud task、GitHub review で参照される。

### `Agent (Full Access)`
IDE feature page で説明される approval mode。file read / edit / command に加え、network access を含む広い権限で動けるが、注意して使う前提。

### `approval mode`
Codex が command 実行前にどの程度 human approval を要求するかを決める設定。CLI や app では sandbox と組み合わせて理解する。

### `automation`
Codex app で background 実行される定期 task。findings は `Triage` に入り、何もなければ auto archive され得る。

### `cached web search`
OpenAI-maintained index の pre-indexed result を返す web search mode。最新性より安全性を優先した default。

### `cloud environment`
Codex web / cloud task で使う実行環境。setup script、maintenance script、environment variables、secrets、internet access を持てる。

### `Codex app`
複数 project、複数 thread、複数 worktree を desktop 上でまとめて扱う command center。

### `Codex CLI`
terminal 上でローカル実行する Codex client。オープンソースで、CLI reference と `config.toml` を中心に運用する。

### `Codex IDE extension`
VS Code 系 editor に統合される Codex client。CLI と同じ agent / 設定を共有する。

### `Codex web`
GitHub 接続を前提に cloud task を委任する surface。長めのバックグラウンド task に向く。

### `diff pane`
Codex app で Git diff を表示する pane。inline comment、stage、revert、commit / PR の起点になる。

### `Fast mode`
CLI slash command や model settings から切り替える高速寄り設定。特定モデルで応答速度を優先する。

### `Handoff`
Codex app で thread を `Local` と `Worktree` の間で移動する操作。必要な Git 操作を Codex が肩代わりする。

### `internet access`
主に cloud task の agent phase が外部ネットワークへ出られるかを決める設定。`web search` とは別概念。

### `Local`
Codex app の mode の 1 つ。現在の project directory で直接作業する。

### `local environments`
Codex app で、worktree 用 setup steps や project 共通 actions を定義する仕組み。

### `MCP`
`Model Context Protocol`。Codex が外部 tool や context source に接続するための仕組み。

### `mode`
Codex app では `Local` / `Worktree` / `Cloud`、CLI / IDE では `Chat` / `Agent` 系の動作モードを指すことが多い。文脈で意味が変わる。

### `reasoning effort`
Codex が応答前にどれだけ考えるかの強さ。典型値は `low` / `medium` / `high`。

### `review pane`
Codex app で差分レビューを行う UI。Git repository 前提で、Codex 自身の変更だけでなく repo の未コミット差分全体を見る。

### `review_model`
CLI の local code review 用に使う model override 設定。通常 session model とは別に持てる。

### `sandbox`
Codex が file system や network にどこまで触れられるかを制御する仕組み。CLI では `read-only`、`workspace-write`、`danger-full-access` などがある。

### `secret`
cloud environment に置く機密値。setup script では使えるが、agent phase には渡らない。

### `skill`
Codex に task-specific capability を追加するパッケージ。中心ファイルは `SKILL.md`。

### `Triage`
Codex app の automations pane にある inbox 的セクション。automation run の findings が集約される。

### `universal`
Codex cloud task の default container image。よく使う言語や tool が preinstalled される。

### `web_search`
CLI などから使う first-party search tool。`cached`、`live`、`disabled` のような mode を持つ。

### `Worktree`
Git worktree を使った別 checkout。Codex app では background 作業の基本単位として使われる。
