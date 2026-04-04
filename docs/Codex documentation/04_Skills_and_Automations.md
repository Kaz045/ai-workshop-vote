# 04 Skills and Automations

## 3行要約
- `Skills` は Codex に新しい専門性とワークフローを与える仕組みで、`SKILL.md` を中心に instructions、scripts、references、assets を束ねる。
- `Automations` は Codex app 上で定期実行される unattended task で、結果は inbox 的な `Triage` に集約される。
- 両者を組み合わせると、チーム固有の定型作業を「毎回説明する」から「再利用する」へ変えられる。

## 対象読者
Codex を単発支援ではなく、チーム固有の workflow engine として育てたい開発者や運用担当者。

## 重要キーワード
`Skills`, `SKILL.md`, `progressive disclosure`, `skill-creator`, `Automations`, `Triage`, `worktree`, `approval_policy`, `rules`, `config.toml`

## Skills の基本構造

### ページ: Agent Skills – Codex | OpenAI Developers
出典: [https://developers.openai.com/codex/skills](https://developers.openai.com/codex/skills)

skills overview は、skill を「Codex に task-specific capability を与えるパッケージ」と説明する。

- skill は instructions、resources、optional scripts をまとめたもの
- CLI、IDE extension、Codex app で共通利用できる
- `open agent skills standard` を土台にしている

### skill のディレクトリ構成
最小単位は directory 1 つで、中心は `SKILL.md`。

- `SKILL.md`: 必須。instructions と metadata を持つ
- `scripts/`: 任意。決定的な処理や外部 tool 呼び出しに使う
- `references/`: 任意。参照文書
- `assets/`: 任意。template や resource
- `agents/openai.yaml`: 任意。appearance や dependencies

### progressive disclosure
Codex は最初から全文を読むのではなく、まず各 skill の metadata を見て、必要なときだけ `SKILL.md` を読み込む。これにより context を節約しつつ、多数の skill を持てる。

## Skills の起動方法

### ページ: Agent Skills – Codex | OpenAI Developers
出典: [https://developers.openai.com/codex/skills](https://developers.openai.com/codex/skills)

Codex は skill を 2 通りで起動する。

### 明示的起動
- prompt に skill を直接書く
- CLI / IDE では `/skills` または `$skill-name` で mention する

### 暗黙的起動
- task が skill の `description` に一致すると、Codex が自動選択する

このため `description` は、いつ使うべきかだけでなく、いつ使うべきでないかまで明確に書くのが重要になる。

## Skills の作り方

### ページ: Agent Skills – Codex | OpenAI Developers
出典: [https://developers.openai.com/codex/skills](https://developers.openai.com/codex/skills)

公式 docs は、まず built-in creator を使うことを勧める。

```text
$skill-creator
```

creator は次を聞く。

- 何をする skill か
- いつ発火すべきか
- instruction-only にするか、script を含めるか

manual 作成も可能で、その場合は folder と `SKILL.md` を用意し、`name` と `description` を必須で入れる。変更は自動検知されるが、反映しない場合は Codex 再起動が必要。

## Skills の保存場所と有効化

### ページ: Agent Skills – Codex | OpenAI Developers
出典: [https://developers.openai.com/codex/skills](https://developers.openai.com/codex/skills)

Codex は repository、user、admin、system の複数 location から skill を読む。repo では `.agents/skills` を current working directory から repository root まで辿って探索する。

同名 skill は merge されず、selector に両方出ることがある。

### 無効化
削除せず止めたいときは `~/.codex/config.toml` の `[[skills.config]]` を使う。

```toml
[[skills.config]]
path = "/path/to/skill/SKILL.md"
enabled = false
```

## Skills のベストプラクティス

### ページ: Agent Skills – Codex | OpenAI Developers
出典: [https://developers.openai.com/codex/skills](https://developers.openai.com/codex/skills)

公式 best practices は次の 4 点にまとまる。

- 1 skill = 1 job に寄せる
- deterministic behavior や外部 tool が不要なら、script より instruction を優先する
- imperative steps で、input と output を明確に書く
- prompt と skill description の相性を実際に試す

## app から見た Skills

### ページ: Features – Codex app | OpenAI Developers
出典: [https://developers.openai.com/codex/app/features](https://developers.openai.com/codex/app/features)

app features は、skills を app 横断の shared asset として扱う。

- app は CLI / IDE と同じ skills を使える
- sidebar の `Skills` から、異なる project にある skill を閲覧できる
- skill と automation を組み合わせ、telemetry triage、fix 提案、report 作成のような routine task に繋げられる

### ページ: Introducing the Codex app | OpenAI
出典: [https://openai.com/index/introducing-the-codex-app/](https://openai.com/index/introducing-the-codex-app/)

発表記事は、skills を「code generation を超えて、情報収集、problem-solving、writing まで広げる装置」と説明する。製品思想としては、skill によって Codex は「コードを書く agent」から「仕事を進める agent」へ変わる。

## Automations の基本構造

### ページ: Automations – Codex app | OpenAI Developers
出典: [https://developers.openai.com/codex/app/automations](https://developers.openai.com/codex/app/automations)

automations は「定期実行される Codex task」であり、app が起動していて、対象 project が disk 上に存在することが前提になる。

- findings があれば inbox に追加される
- 何も報告がなければ auto archive される
- Git repo では `local project` か `new worktree` を選べる
- non-version-controlled project では project directory 直下で動く
- model と reasoning effort は default のままでも、明示指定でもよい

## Automations の運用

### ページ: Automations – Codex app | OpenAI Developers
出典: [https://developers.openai.com/codex/app/automations](https://developers.openai.com/codex/app/automations)

### 管理場所
- app sidebar の automations pane
- `Triage` セクションが inbox 役
- unread filter や automation run 一覧を持つ

### local と worktree の違い
- `worktree`: unfinished local work と衝突しにくい
- `local`: main checkout を直接更新できるが、作業中 file を壊す可能性がある

### skills との組み合わせ
- maintainability と shareability を上げるため、公式 docs は skill 併用を推奨する
- automation prompt 中で `$skill-name` を使えば明示起動できる

## Automations を安全に作る

### ページ: Automations – Codex app | OpenAI Developers
出典: [https://developers.openai.com/codex/app/automations](https://developers.openai.com/codex/app/automations)

公式 docs は、schedule を有効化する前に通常 thread で手動検証することを勧める。確認ポイントは次の 3 つ。

- prompt が十分に明確で scope が適切か
- default または selected model / reasoning / tools が期待通りか
- resulting diff が review 可能か

そのうえで、最初の数 run は出力をよく確認し、prompt や cadence を調整する。

## Automations の権限モデル

### ページ: Automations – Codex app | OpenAI Developers
出典: [https://developers.openai.com/codex/app/automations](https://developers.openai.com/codex/app/automations)

automations は unattended 実行のため、権限設定を雑にすると危険度が上がる。

### sandbox mode ごとの挙動
- `read-only`: file change、network、computer 操作を伴う tool call は失敗する
- `workspace-write`: workspace 外変更、network、computer 操作は失敗する
- `full access`: unattended で file change、command、network 実行まで進み得るためリスクが高い

### admin 制御
- 管理環境では `approval_policy = "never"` を禁止できる
- 許可されていれば automations は `approval_policy = "never"` を使う
- 禁止されている場合は selected mode の approval behavior に fallback する

## Worktree cleanup

### ページ: Automations – Codex app | OpenAI Developers
出典: [https://developers.openai.com/codex/app/automations](https://developers.openai.com/codex/app/automations)

frequent schedule は worktree を増やしやすい。公式 docs は次を勧める。

- 不要な automation run は archive する
- 残す意図がない限り pin しない

つまり automation は「schedule を作ったら終わり」ではなく、artifact cleanup を含めて運用するものとして設計されている。

## 教材として押さえるべき理解

1. skill は reusable instruction package、automation は scheduled execution container である。
2. skill 単体より、skill + automation の組み合わせで価値が大きくなる。
3. unattended 実行では、prompt の明確さより先に sandbox / approval / worktree 戦略を決めるべきである。
