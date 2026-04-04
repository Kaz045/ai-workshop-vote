# Firebase API Key インシデント対応メモ

## 目的
Git 履歴に残った Firebase 設定値を前提に、被害防止を最短で実施する。

## 即時対応（今日中）
1. Firebase Console で Web API キーをローテーション（旧キー無効化）
2. GitHub Secrets の `FIREBASE_API_KEY` を新キーへ更新
3. GitHub Actions `pages.yml` を手動実行して再デプロイ
4. 公開ページで `%%FIREBASE_API_KEY%%` が残っていないことを確認

## GitHub Secrets 更新（ローカルから）
```bash
scripts/security/set_github_firebase_secrets.sh Kaz045/with-portal
```

## ワークフロー実行
```bash
gh workflow run pages.yml --repo Kaz045/with-portal
gh run watch --repo Kaz045/with-portal
```

## 漏えい履歴の特定（キー値は表示しない）
```bash
scripts/security/find_firebase_key_commits.sh
```

## 追加の防御
1. Firestore ルールを最小権限に更新（匿名認証済みのみ write など）
2. API キーに API 制限 / リファラ制限を設定
3. App Check の有効化
4. 投票終了後に `git filter-repo` で履歴から実値を除去し、強制 push 後に再スキャン
