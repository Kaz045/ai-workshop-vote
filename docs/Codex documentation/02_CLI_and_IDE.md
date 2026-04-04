# 02 CLI and IDE

## 3行要約
- `Codex CLI` はローカル端末で動く中核 surface で、インタラクティブ対話、単発実行、レビュー、画像入力、web search、subagents まで扱える。
- `Codex IDE extension` は CLI と同じエージェントと設定を共有し、開いているファイル文脈、選択コード、cloud delegation を IDE 内に持ち込む。
- モデル、reasoning effort、approval mode、sandbox、slash commands の理解が、実務での使い勝手を大きく左右する。

## 対象読者
Codex を terminal や IDE で本格運用したい開発者、チーム標準の操作手順を整えたい人。

## 重要キーワード
`Codex CLI`, `IDE extension`, `slash commands`, `config.toml`, `reasoning effort`, `approval mode`, `sandbox`, `cloud delegation`, `resume`, `review`

## CLI の導入と基本位置づけ

### ページ: CLI – Codex | OpenAI Developers
出典: [https://developers.openai.com/codex/cli](https://developers.openai.com/codex/cli)

CLI overview は、Codex CLI を「terminal からローカルで実行できる coding agent」と定義する。特徴は次の通り。

- 選択したディレクトリでコードを読み、変更し、コマンドを実行できる
- オープンソースで、Rust 製
- ChatGPT account または API key で認証できる
- `npm i -g @openai/codex` で導入し、`codex` で起動する
- 新版は `npm i -g @openai/codex@latest` で更新する

2026-03-20 確認時点のこのページでは、CLI は `macOS` と `Linux` を主対象とし、Windows は experimental とされている。

## CLI の主要ワークフロー

### ページ: Features – Codex CLI | OpenAI Developers
出典: [https://developers.openai.com/codex/cli/features](https://developers.openai.com/codex/cli/features)

CLI features ページは、chat 以外の主要ワークフローを整理している。

#### 1. インタラクティブ実行
- `codex` で full-screen terminal UI を開く
- 初期プロンプト付きなら `codex "Explain this codebase to me"` のように起動できる
- セッション中に差分確認、出力コピー、会話継続を行える

#### 2. 会話の再開
- transcript はローカル保存される
- `resume` 系の機能で、同じ repository state と文脈を引き継げる
- `codex exec resume --last "..."` のような non-interactive resume もできる

#### 3. モデル切替
- セッション中は `/model`
- 起動時は `codex --model gpt-5.4`

#### 4. 画像入力
- `codex -i screenshot.png "Explain this error"`
- 複数画像は `--image img1.png,img2.jpg`

#### 5. ローカルコードレビュー
- `/review` で専用 reviewer を起動する
- current session model を使い、`config.toml` の `review_model` で上書きできる

#### 6. web search
- CLI には first-party web search tool がある
- ローカル task では default が cached mode
- transcript や `codex exec --json` に `web_search` 項目が出る

#### 7. subagents
- 明示的に頼んだときだけ起動する
- 並列化に強いが、単一 agent より token 消費は増える

## CLI の重要フラグ

### ページ: Command line options – Codex CLI | OpenAI Developers
出典: [https://developers.openai.com/codex/cli/reference](https://developers.openai.com/codex/cli/reference)

CLI reference は非常に長いが、日常的に重要な flag は絞れる。

| Flag | 意味 | 実務での使いどころ |
| --- | --- | --- |
| `--model, -m` | モデル上書き | タスク単位でモデルを変えたいとき |
| `--sandbox, -s` | `read-only` / `workspace-write` / `danger-full-access` | 変更可能範囲を制御したいとき |
| `--ask-for-approval, -a` | `untrusted` / `on-request` / `never` | 承認の厳しさを変えたいとき |
| `--full-auto` | `on-request` + `workspace-write` の近道 | 低摩擦なローカル作業 |
| `--image, -i` | 初期プロンプトに画像添付 | UI や図、スクショを読ませる |
| `--add-dir` | 追加ディレクトリに write access | 複数ディレクトリ参照が必要なとき |
| `--cd, -C` | 作業ディレクトリ指定 | 起動位置を明示したいとき |
| `--config, -c` | `config.toml` の一時 override | 1 回だけ設定を変えたいとき |
| `--search` | live web search を有効化 | cached ではなく最新情報が欲しいとき |
| `--dangerously-bypass-approvals-and-sandbox`, `--yolo` | 承認と sandbox を外す | 外部で堅牢に隔離された環境でのみ |

reference ページは、CLI の default が `~/.codex/config.toml` に寄ること、CLI の command line override がその起動回だけ優先されることも明記している。

## CLI の slash commands

### ページ: Slash commands in Codex CLI | OpenAI Developers
出典: [https://developers.openai.com/codex/cli/slash-commands](https://developers.openai.com/codex/cli/slash-commands)

CLI slash commands は、実務では次のセットを覚えると十分に強い。

### セッション制御
- `/permissions`: approval 要件を途中で変える
- `/agent`: subagent thread を切り替える
- `/status`: 現在の thread 情報や制限を見る
- `/resume`: 保存済み会話を再開する
- `/new`: 同じ CLI セッション内で新しい会話を始める
- `/quit` または `/exit`: CLI を閉じる

### 作業支援
- `/mention`: 次に見てほしい file / folder を付ける
- `/model`: model と reasoning effort を切り替える
- `/fast`: GPT-5.4 の Fast mode を切り替える
- `/personality`: `friendly` / `pragmatic` / `none`
- `/plan`: plan mode に切り替える
- `/diff`: Git diff を確認する
- `/review`: working tree review を実行する
- `/init`: `AGENTS.md` の scaffold を作る
- `/mcp`: MCP tool の設定確認

### 実務上の読み替え
- `/plan` は実装前に設計を固める
- `/diff` は commit 前の最終確認
- `/review` は peer review の代替というより、事前の自己点検
- `/permissions` と `/model` は、途中でタスク戦略を変えるときの主力

## IDE extension の導入と基本位置づけ

### ページ: IDE extension – Codex | OpenAI Developers
出典: [https://developers.openai.com/codex/ide](https://developers.openai.com/codex/ide)

IDE overview は、Codex を editor の横に置いて使う形を説明する。ポイントは次の通り。

- VS Code extension として使うが、`Cursor` や `Windsurf` のような VS Code fork にも対応する
- Codex Cloud への delegation も IDE から行える
- ChatGPT plan に含まれる
- Marketplace や IDE 別ダウンロード導線から導入する

Help Center は、VS Code extension が「most VS Code forks」と互換であり、その他の IDE では terminal 内で CLI を使う形でもよいとしている。

## IDE extension の主要機能

### ページ: Features – Codex IDE | OpenAI Developers
出典: [https://developers.openai.com/codex/ide/features](https://developers.openai.com/codex/ide/features)

IDE features の重要点は次の通り。

#### プロンプトと文脈
- open file や selected code が自然に文脈に入る
- `@example.tsx` のように file mention できる
- IDE 側の文脈があるため、CLI より短い指示で済みやすい

#### モデルと reasoning effort
- chat input 下の switcher で model を変える
- reasoning effort は `low` / `medium` / `high`
- 複雑タスクでは `high` が有利だが、時間と token 消費は増える

#### approval mode
- `Agent`: working directory 内の read / edit / command 実行を自動化
- `Chat`: 相談や planning を優先
- `Agent (Full Access)`: network を含む広い権限で動けるが、注意が必要

#### cloud delegation
- cloud environment を選んで IDE から remote task を起動できる
- `main` から新規案を作ることも、local changes から続き作業に入ることもできる
- cloud で始めた task の文脈は、local follow-up に持ち込める

## IDE extension の設定

### ページ: Settings – Codex IDE | OpenAI Developers
出典: [https://developers.openai.com/codex/ide/settings](https://developers.openai.com/codex/ide/settings)

IDE settings は editor UI 用のものと、CLI 共有設定に分かれる。

### editor 側の主な設定
- `chatgpt.cliExecutable`: 開発用の CLI path 指定
- `chatgpt.commentCodeLensEnabled`: TODO comment の上に CodeLens を出す
- `chatgpt.localeOverride`: UI 言語の優先設定
- `chatgpt.openOnStartup`: 起動時に sidebar を前面化
- `chatgpt.runCodexInWindowsSubsystemForLinux`: Windows では WSL 実行を優先

### `config.toml` 側で管理するもの
このページは、default model、approvals、sandbox のような本質的挙動は editor settings ではなく共有の `~/.codex/config.toml` で管理すると明記している。つまり、CLI / IDE / app の横断設定をここで揃えるのが基本になる。

## IDE commands と slash commands

### ページ: Commands – Codex IDE | OpenAI Developers
出典: [https://developers.openai.com/codex/ide/commands](https://developers.openai.com/codex/ide/commands)

Command Palette から使う代表 command は次の通り。

- `chatgpt.addToThread`: 選択範囲を現在 thread に追加
- `chatgpt.addFileToThread`: file 全体を thread に追加
- `chatgpt.newChat`: 新しい thread を作成
- `chatgpt.implementTodo`: 選択した TODO を Codex に処理させる
- `chatgpt.newCodexPanel`: 新しい Codex panel を作成
- `chatgpt.openSidebar`: Codex sidebar を開く

### ページ: Slash commands – Codex IDE | OpenAI Developers
出典: [https://developers.openai.com/codex/ide/slash-commands](https://developers.openai.com/codex/ide/slash-commands)

IDE slash commands は CLI より小ぶりで、IDE 向けに整理されている。

- `/auto-context`: recent files と IDE context の自動取り込みを切り替える
- `/cloud`: cloud mode に切り替える
- `/cloud-environment`: cloud mode で使う環境を選ぶ
- `/feedback`: フィードバック送信
- `/local`: local mode に戻す
- `/review`: code review mode を始める
- `/status`: thread ID、context usage、rate limits を確認する

## モデルに関する公式記述の差分

### ページ: Using Codex with your ChatGPT plan | OpenAI Help Center
出典: [https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan](https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan)

2026-03-20 確認時点の Help Center FAQ は、CLI / IDE extension について次を述べている。

- `GPT-4o` は Codex では使えない
- Codex は `GPT-5.1-Codex` family をサポートする
- default model は CLI / IDE の version と設定に依存する

一方、developers docs の CLI / IDE / pricing ページでは `GPT-5.4`、`GPT-5.4-mini`、`GPT-5.3-Codex`、`GPT-5.3-Codex-Spark` への言及がある。NotebookLM 用教材では、この差分を「モデル提供は変動が早く、client version と plan に依存する」という注意点として扱うのが安全である。

## 実務での使い分け

### CLI を選ぶ場面
- 複数コマンドの実行と差分確認を密に回したい
- shell、Git、画像入力、review を一箇所に集めたい
- `config.toml` と slash commands を中心に運用したい

### IDE extension を選ぶ場面
- open file / selected code をそのまま文脈にしたい
- editor を離れずに task を回したい
- local editing と cloud delegation を往復したい

### 共通の実務原則
1. まず `medium` reasoning から始める
2. 変更前に approval / sandbox の境界を確認する
3. `AGENTS.md` と `config.toml` を整えて、毎回の指示量を減らす
4. commit 前に `/diff` または `/review` を挟む
