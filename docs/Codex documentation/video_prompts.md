# Video Prompts

## 1. Codex 全体像を 90 秒で説明する
- 対象読者: Codex をまだ触っていないソフトウェア開発者
- 学習ゴール: Codex が何で、どの surface があり、何を得意とするかを掴ませる
- 参照ファイル: `01_What_is_Codex.md`, `99_Glossary.md`
- 想定尺: 60-90 秒
- プロンプト:

```text
以下の教材だけを根拠に、日本語で 60-90 秒の短い解説動画台本を作成してください。テーマは「Codexとは何か」。冒頭10秒で Codex を一言で定義し、その後に CLI・IDE extension・Codex web・Codex app の違いを直感的に説明してください。最後に、どんな開発者に向くのかを 1 文で締めてください。専門用語は最小限にし、初見でも理解できる比喩を 1 つ入れてください。
```

## 2. CLI と IDE extension の使い分け
- 対象読者: すでに VS Code や terminal を日常利用している開発者
- 学習ゴール: CLI と IDE extension の違い、共通点、選び方を理解させる
- 参照ファイル: `02_CLI_and_IDE.md`, `99_Glossary.md`
- 想定尺: 60-90 秒
- プロンプト:

```text
以下の教材を使って、日本語で 60-90 秒の解説動画台本を作ってください。テーマは「Codex CLI と IDE extension の使い分け」。CLI の強み、IDE extension の強み、共通して重要な model / reasoning effort / approval mode を順に説明し、最後に「まずどちらから始めるべきか」を実務目線で提案してください。説明は箇条書きではなく、自然なナレーション文で出してください。
```

## 3. Codex web と Codex app の違い
- 対象読者: 長時間タスクや並列作業に Codex を使いたい開発者
- 学習ゴール: web の cloud delegation と app の multi-thread / worktree 運用の違いを理解させる
- 参照ファイル: `03_Codex_Web_and_App.md`, `99_Glossary.md`
- 想定尺: 60-90 秒
- プロンプト:

```text
以下の教材をもとに、日本語で 60-90 秒の短い解説動画台本を作成してください。テーマは「Codex web と Codex app の違い」。前半で Codex web を “クラウド委任の入口” として、後半で Codex app を “複数エージェントの司令塔” として説明してください。worktree、review pane、cloud environment を一言ずつ噛み砕いて説明し、最後にどんな人が app を使うと効果が大きいかを述べてください。
```

## 4. Skills と Automations で定型作業を減らす
- 対象読者: チームの開発運用を改善したいエンジニアリングマネージャーやテックリード
- 学習ゴール: Skills と Automations の関係と、安全な導入順序を理解させる
- 参照ファイル: `04_Skills_and_Automations.md`, `99_Glossary.md`
- 想定尺: 60-90 秒
- プロンプト:

```text
以下の教材だけを使って、日本語で 60-90 秒の動画台本を作ってください。テーマは「Skills と Automations で Codex を再利用可能にする」。skill が何か、automation が何か、なぜ組み合わせると強いのかを説明し、最後に sandbox / approval / worktree の観点から安全な始め方を 3 ステップでまとめてください。抽象論ではなく、開発チームが翌日から試せる語り口にしてください。
```

## 5. Web search・Internet access・GitHub review の安全運用
- 対象読者: Codex を実務導入するセキュリティ意識の高い開発者
- 学習ゴール: cached web search と internet access の違い、GitHub review まで含めた安全運用の勘所を理解させる
- 参照ファイル: `05_Web_Search_and_Internet_Access.md`, `06_GitHub_and_PR_Workflows.md`, `99_Glossary.md`
- 想定尺: 60-90 秒
- プロンプト:

```text
以下の教材を根拠に、日本語で 60-90 秒の短い解説動画台本を作成してください。テーマは「Codex を安全にネットと GitHub につなぐ」。cached web search と live search の違い、cloud internet access が default off である理由、`@codex review` や GitHub Action を使うときに気をつけるべきことを順番に説明してください。prompt injection を 1 つの具体例で短く示し、最後は「まず何を最小権限で有効化するべきか」で締めてください。
```
