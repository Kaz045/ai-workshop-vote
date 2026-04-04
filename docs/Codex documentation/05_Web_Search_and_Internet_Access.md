# 05 Web Search and Internet Access

## 3行要約
- Codex の web search と internet access は同じではない。前者は情報取得の tool、後者は agent がネットワークに出られる権限設定である。
- CLI の local task では web search が first-party tool として組み込まれ、default は `cached` mode、必要時だけ `live` に切り替える設計になっている。
- cloud task の internet access は default で agent phase が `Off` で、必要な domain と HTTP method だけを許可する考え方が公式に推奨されている。

## 対象読者
Codex に最新情報を調べさせたい人、cloud 実行で安全にネットワークを開けたい人、NotebookLM で安全モデルを学びたい人。

## 重要キーワード
`web_search`, `cached`, `live`, `--search`, `internet access`, `allowlist`, `GET`, `HEAD`, `OPTIONS`, `prompt injection`, `cloud environments`

## この章の範囲
このファイルは Codex 関連ページのみを使っている。一般 API の `Web search` ツール説明ページは意図的に含めていない。

## CLI における web search

### ページ: Features – Codex CLI | OpenAI Developers
出典: [https://developers.openai.com/codex/cli/features](https://developers.openai.com/codex/cli/features)

CLI features は、Codex CLI に first-party web search tool があることを明示している。重要なのは mode の考え方である。

- local task では default が `cached`
- cached mode は OpenAI-maintained index の pre-indexed results を返す
- arbitrary live content への露出を減らし、prompt injection リスクを下げる狙いがある
- ただし cached results でも untrusted として扱うべきと明記されている

この設計は、「最新性」と「安全性」の間で、default を安全寄りに置く方針だと読める。

## CLI で live search を有効にする方法

### ページ: Command line options – Codex CLI | OpenAI Developers
出典: [https://developers.openai.com/codex/cli/reference](https://developers.openai.com/codex/cli/reference)

CLI reference は web search の切り替え方法を具体的に書いている。

- `--search`: その実行だけ live web search を有効化する
- `web_search = "live"`: config で live を default にする
- `web_search = "disabled"`: tool 自体を無効化する

また、このページは interactive `codex` 実行について次を説明している。

- default は cached web search
- `--search` で live browsing に変える
- `--full-auto` と組み合わせると、より低摩擦で command 実行を進める

### 関連 flag
- `--search`
- `--sandbox`
- `--dangerously-bypass-approvals-and-sandbox` / `--yolo`

reference 上では、`--yolo` や full access 系設定では web search の default が live 寄りになることが示されている。

## app / desktop 側の既定思想

### ページ: Introducing the Codex app | OpenAI
出典: [https://openai.com/index/introducing-the-codex-app/](https://openai.com/index/introducing-the-codex-app/)

`2026-02-02` の app 発表記事は、Codex app の安全設計について次を述べる。

- native かつ open-source の system-level sandboxing を使う
- default では、作業中 folder / branch の編集と `cached web search` に限定する
- network access のような高権限操作は permission を求める

つまり、app 側でも default は「まず cached web search、必要な権限だけ昇格」という設計思想で統一されている。

## cloud task における internet access

### ページ: Agent internet access – Codex web | OpenAI Developers
出典: [https://developers.openai.com/codex/cloud/internet-access](https://developers.openai.com/codex/cloud/internet-access)

cloud task の internet access は web search より強い概念で、agent が外部ネットワークに直接出ることを意味する。

### default
- agent phase では internet access は default で blocked
- ただし setup scripts には internet access がある
- 必要な場合だけ environment 単位で有効化する

### なぜ危険か
公式 docs はリスクを 4 つに整理している。

- prompt injection from untrusted web content
- exfiltration of code or secrets
- malware や脆弱依存のダウンロード
- license restriction を持つ content の取り込み

### prompt injection の典型例
docs は GitHub issue に hidden instruction が含まれ、`git show HEAD` の内容が外部へ送られる例を示している。教材として重要なのは、問題が「web page」だけでなく「README、issue、dependency metadata」のような半信頼ソースでも起きることだ。

## internet access の設定方法

### ページ: Agent internet access – Codex web | OpenAI Developers
出典: [https://developers.openai.com/codex/cloud/internet-access](https://developers.openai.com/codex/cloud/internet-access)

設定は environment 単位で行う。

### mode
- `Off`: 完全遮断
- `On`: 許可。ただし domain allowlist と HTTP methods で絞れる

### allowlist preset
- `None`: 空 allowlist から自分で足す
- `Common dependencies`: よく使う依存取得先をまとめた preset
- `All (unrestricted)`: 全許可

### HTTP methods
追加防御として、`GET`、`HEAD`、`OPTIONS` に絞ることが推奨される。`POST`、`PUT`、`PATCH`、`DELETE` などは block される。

### 運用原則
docs の推奨は一貫している。

- 必要な domain だけを許可する
- method も必要最小限にする
- output と work log を review する

## cloud environments と internet access の関係

### ページ: Cloud environments – Codex web | OpenAI Developers
出典: [https://developers.openai.com/codex/cloud/environments](https://developers.openai.com/codex/cloud/environments)

cloud environments ページは、task 開始時に internet access settings が適用される流れを説明している。

1. container 作成
2. setup script 実行
3. internet access settings 適用
4. agent が command loop に入る
5. answer と diff を返す

この順序は実務上かなり重要である。

- setup script は internet access 前提で dependency install をしやすい
- agent phase は default では offline
- internet access を開ける場合も environment ごとに管理される

## Common dependencies preset の読み方

### ページ: Agent internet access – Codex web | OpenAI Developers
出典: [https://developers.openai.com/codex/cloud/internet-access](https://developers.openai.com/codex/cloud/internet-access)

docs は `Common dependencies` preset に、source control、package registry、language ecosystem の主要 domain を含めている。例としては次の系統が入る。

- `github.com` / `githubusercontent.com`
- `npmjs.com` / `npmjs.org`
- `pypi.org` / `pypa.io`
- `rubygems.org`
- `crates.io`
- `docker.com` / `docker.io`

重要なのは個別ドメイン一覧を暗記することではなく、「build に必要な場所だけを許可する preset がある」という設計意図を理解することである。

## 教材として押さえるべき理解

1. `cached web search` は検索機能、`internet access` は agent のネットワーク権限であり、別レイヤーの話である。
2. local CLI では cached search が default、cloud agent では internet access が default off、という安全寄りの default が採られている。
3. 最新性が必要なときだけ `--search` や environment allowlist を開ける、という運用が公式方針に最も近い。
