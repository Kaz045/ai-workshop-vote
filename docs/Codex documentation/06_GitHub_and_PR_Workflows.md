# 06 GitHub and PR Workflows

## 3行要約
- Codex は GitHub と結びつけると、PR review、PR 作成、CI 内実行まで workflow を広げられる。
- 最も軽い導入は PR comment の `@codex review`、より自動化したい場合は automatic reviews、さらに CI へ組み込む場合は `openai/codex-action@v1` を使う。
- app / web / cloud / GitHub Action は別 surface だが、差分レビュー、PR 化、follow-up という流れで繋がっている。

## 対象読者
Codex を GitHub review、PR 作成、CI/CD 自動化に組み込みたい開発者、チーム運用設計者。

## 重要キーワード
`GitHub`, `pull request`, `@codex review`, `automatic reviews`, `AGENTS.md`, `GitHub Action`, `codex exec`, `prompt-file`, `review pane`

## GitHub 接続の前提

### ページ: Web – Codex | OpenAI Developers
出典: [https://developers.openai.com/codex/cloud](https://developers.openai.com/codex/cloud)

Codex web は、利用開始時に GitHub account 接続を要求する。これにより Codex は repository を読み、成果物から PR を作成できる。

### ページ: Introducing Codex | OpenAI
出典: [https://openai.com/index/introducing-codex/](https://openai.com/index/introducing-codex/)

`2025-05-16` の発表記事でも、Codex は task 完了後に次の流れへ進めると説明されている。

- result を review する
- further revisions を依頼する
- GitHub pull request を開く
- local environment に取り込む

つまり GitHub 連携は後付けの add-on ではなく、最初期から Codex の主要導線に組み込まれていた。

## GitHub 上での PR review

### ページ: Use Codex in GitHub | OpenAI Developers
出典: [https://developers.openai.com/codex/integrations/github](https://developers.openai.com/codex/integrations/github)

最も簡単な使い方は、pull request comment に `@codex review` を書くこと。

- repository で Code review を有効化する
- PR comment に `@codex review`
- Codex が standard GitHub code review として返信する

この導線の利点は、追加の CI 設定なしで human-like review を始められる点にある。

## automatic reviews

### ページ: Use Codex in GitHub | OpenAI Developers
出典: [https://developers.openai.com/codex/integrations/github](https://developers.openai.com/codex/integrations/github)

manual trigger を毎回書きたくない場合は、settings の `Automatic reviews` を有効にする。

- 新しい PR が review 用に開かれると自動でレビューする
- `@codex review` comment は不要になる

チームの標準ワークフローに Codex review を常設したい場合はこちらが向く。

## review ルールのカスタマイズ

### ページ: Use Codex in GitHub | OpenAI Developers
出典: [https://developers.openai.com/codex/integrations/github](https://developers.openai.com/codex/integrations/github)

Codex は repository 内の `AGENTS.md` を探し、その中の review guidelines に従う。つまり GitHub review の品質は、モデル性能だけでなく repository ルールの言語化に大きく依存する。

教材として重要なのは、`AGENTS.md` が local CLI だけでなく GitHub review でも効く点である。

## app 内での差分レビューと PR 化

### ページ: Features – Codex app | OpenAI Developers
出典: [https://developers.openai.com/codex/app/features](https://developers.openai.com/codex/app/features)

app features は、Codex app に built-in Git tools があると説明している。

- diff pane で差分を確認
- inline comments を付けて Codex に follow-up
- specific chunk や file を stage / revert
- commit / push / pull request を app 内で実行

### ページ: Review – Codex app | OpenAI Developers
出典: [https://developers.openai.com/codex/app/review](https://developers.openai.com/codex/app/review)

review pane は、PR に出す前の差分整形に向く。

- uncommitted changes 全体を見られる
- line anchored な inline comment を残せる
- staged / unstaged の両方を確認できる
- diff 全体、file 単位、hunk 単位で stage / unstage / revert できる

この段階で差分を磨いてから commit / PR に進むのが app 的な流れである。

## GitHub Action で CI に埋め込む

### ページ: Codex GitHub Action – Codex | OpenAI Developers
出典: [https://developers.openai.com/codex/github-action](https://developers.openai.com/codex/github-action)

`openai/codex-action@v1` は、GitHub Actions workflow 内で Codex を実行するための action である。

### 何ができるか
- CI/CD job で Codex を走らせる
- patch を当てる
- review を投稿する
- release prep や migration の repeatable task を workflow 化する

### action の中で起きること
- Codex CLI を install する
- API key を渡した場合は Responses API proxy を起動する
- 指定権限で `codex exec` を実行する

## GitHub Action の前提条件

### ページ: Codex GitHub Action – Codex | OpenAI Developers
出典: [https://developers.openai.com/codex/github-action](https://developers.openai.com/codex/github-action)

docs が挙げる prerequisites は次の通り。

- OpenAI key を GitHub secret に保存する
- runner は Linux か macOS を使う
- Windows runner では `safety-strategy: unsafe` が必要
- action 実行前に `actions/checkout` で code を取っておく
- prompt は inline の `prompt` か repo 内 `prompt-file` で渡す

## 典型 workflow

### ページ: Codex GitHub Action – Codex | OpenAI Developers
出典: [https://developers.openai.com/codex/github-action](https://developers.openai.com/codex/github-action)

公式 example は、PR が `opened` / `synchronize` / `reopened` されたときに Codex review を走らせ、結果を PR に返す workflow である。

主要要素は次の通り。

- `pull_request` event で起動
- `contents: read` と `pull-requests: write` の permission
- `actions/checkout@v5`
- `final-message` output を取り出す
- prompt file を差し替えることで review 方針を変える

docs では、example が最終 message を `codex-output.md` にも保存すると説明している。後続 job で artifact upload や inspection に回しやすい構成である。

## local / cloud / GitHub の接続点

### ページ: Cloud environments – Codex web | OpenAI Developers
出典: [https://developers.openai.com/codex/cloud/environments](https://developers.openai.com/codex/cloud/environments)

cloud task 完了時には answer と diff が返り、そこから PR 作成や follow-up へ進める。つまり flow は次のように繋がる。

1. task を cloud に委任する
2. diff を確認する
3. follow-up または review を行う
4. PR として外へ出す

### ページ: Features – Codex IDE | OpenAI Developers
出典: [https://developers.openai.com/codex/ide/features](https://developers.openai.com/codex/ide/features)

IDE から cloud delegation した場合も、context を保持したまま local follow-up に戻せる。つまり PR 前の最終調整は IDE / app / terminal のどこでやってもよい。

## 教材として押さえるべき理解

1. GitHub 連携には 3 段階ある。`@codex review`、automatic reviews、GitHub Action である。
2. `AGENTS.md` は GitHub review の品質にも効くため、review 観点の言語化が重要である。
3. app の review pane と GitHub 上の review は競合ではなく、PR 前後で使い分ける補完関係にある。
