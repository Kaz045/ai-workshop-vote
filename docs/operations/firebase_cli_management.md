# Firebase CLI 管理方針メモ

## 目的

Firebase Console で直接変更していた設定のうち、少なくとも Firestore のルールとインデックス定義を Git で追える状態にする。

今回の主目的は **Firebase Hosting への移行ではなく、CLI 管理ファイルを整えて今後の差分管理を可能にすること** です。

## このリポジトリでの前提

- 現行の公開導線は GitHub Pages のルート `index.html`
- `html_experiment/` は旧 Firebase 試作として保持する
- 旧試作の Firestore / Anonymous Auth は停止・縮退方向で扱う
- そのため、CLI 管理の初期状態は Firestore を全面 deny にしている

## 追加した管理ファイル

- `.firebaserc`: Firebase CLI の既定プロジェクトを `ai-workshop-vote` に固定
- `firebase.json`: このリポジトリで CLI 管理する対象を Firestore に限定
- `firestore.rules`: 現時点の意図を表すルール定義
- `firestore.indexes.json`: Firestore インデックス定義の置き場

## なぜ Hosting を入れていないか

今回は GitHub Pages が現行の公開経路です。  
`firebase init hosting` 相当を先に入れると、`public` ディレクトリや rewrites など公開導線の設計判断まで混ざるため、今回の目的には過剰です。

まずは Firestore だけを Git 管理に乗せ、公開経路は既存のまま維持します。

## `firebase init` 相当として何を手で整えたか

CLI を対話式で走らせる代わりに、次の最小セットを手で作成しています。

```txt
.firebaserc
firebase.json
firestore.rules
firestore.indexes.json
```

これで、将来 Firebase CLI が使える状態になれば、少なくとも次のような運用に移れます。

```bash
firebase use default
firebase deploy --only firestore
```

## 重要な注意

- これらのファイルを追加しただけでは Firebase Console 側は変わりません
- 実際に反映されるのは `firebase deploy --only firestore` を実行したときです
- 今の `firestore.rules` は **閉じる側の安全デフォルト** です
- 将来 Firestore を再利用する場合は、ルールを用途に合わせて見直してから deploy します

## 今後の安全な進め方

1. ローカルに Firebase CLI を入れる
2. `firebase login` してプロジェクトに接続する
3. `firebase deploy --only firestore` を明示的に実行する
4. 再利用時は `firestore.rules` を先に更新し、Console 直変更ではなく Git でレビューする
