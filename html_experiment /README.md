# AI時代の仕事のリアル — リアルタイム投票ページ

ワークショップ「AI時代の仕事のリアル」で使用するリアルタイム投票ページです。  
参加者がスマホやPCからアクセスし、聞きたいテーマに投票できます。

---

## クイックスタート（ローカルデモ）

**Firebase設定不要** ですぐに動作確認できます。

1. `index.html` をブラウザで直接開く（ダブルクリック or ドラッグ＆ドロップ）
2. 右下のステータスバッジに **🟡 ローカルデモモード** と表示される
3. 各テーマの「👍 投票」をタップすると投票数が増加する
4. 投票データはブラウザの **localStorage** に保存される

### ローカルデモモードの制約

- 投票データは **同一ブラウザ内のみ** に保存されます（他の端末とは同期されません）
- ブラウザのデータを消去すると投票データもリセットされます
- ワークショップ本番で複数参加者の投票をリアルタイムに集計するには、Firebase設定が必要です

---

## 本番モード（Firebase でリアルタイム同期）

複数の参加者の投票をリアルタイムで集計するには、Firebase プロジェクトの設定が必要です。

### 手順1: Firebase プロジェクトを作成

1. [Firebase Console](https://console.firebase.google.com/) にアクセス
2. 「プロジェクトを追加」をクリック
3. プロジェクト名（例: `ai-workshop-vote`）を入力して作成

### 手順2: Firestore Database を有効化

1. Firebase Console の左メニュー →「Firestore Database」
2. 「データベースを作成」をクリック
3. **テストモード** を選択（ワークショップ中のみ使用するため）
4. リージョンを選択（例: `asia-northeast1`）して作成

### 手順3: Anonymous 認証を有効化

1. Firebase Console の左メニュー →「Authentication」
2. 「Sign-in method」タブを開く
3. 「匿名」を有効にして保存

### 手順4: ウェブアプリを登録して設定値を取得

1. Firebase Console のプロジェクト設定（⚙️ アイコン）
2. 「アプリを追加」→ ウェブ（`</>`）を選択
3. アプリ名を入力して登録
4. 表示される `firebaseConfig` オブジェクトをコピー

以下のような形式です:

```javascript
const firebaseConfig = {
  apiKey: "AIza...",
  authDomain: "your-project.firebaseapp.com",
  projectId: "your-project",
  storageBucket: "your-project.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abcdef"
};
```

### 手順5: HTML に設定を埋め込む

`index.html` の `<script type="module">` ブロックの **直前** に以下を追加します:

```html
<script>
    var __firebase_config = JSON.stringify({
        apiKey: "AIza...",
        authDomain: "your-project.firebaseapp.com",
        projectId: "your-project",
        storageBucket: "your-project.appspot.com",
        messagingSenderId: "123456789",
        appId: "1:123456789:web:abcdef"
    });
    var __app_id = "workshop-ai-demo";
</script>
```

> **注意**: `__firebase_config` は **JSON文字列** として設定してください（`JSON.stringify()` で囲む）。

### 手順6: 動作確認

1. ブラウザで `index.html` を開く
2. 右下のステータスバッジが **🟢 リアルタイム同期中** に変わることを確認
3. 別のブラウザ・タブ・端末からも開いて投票が同期されることを確認

---

## Firestore セキュリティルール（推奨）

テストモードのまま公開すると誰でもデータを書き換えられます。  
ワークショップ用に最低限のルールを設定してください。

Firebase Console →「Firestore Database」→「ルール」タブ:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /artifacts/{appId}/public/{docId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

これにより、認証済みユーザー（匿名認証含む）のみが書き込み可能になります。

---

## 投票データのリセット

### ローカルデモモードの場合

ブラウザの開発者ツール → Console で以下を実行:

```javascript
localStorage.removeItem('ai_workshop_votes');
location.reload();
```

### Firebase モードの場合

Firebase Console →「Firestore Database」で該当ドキュメントを削除するか、
各 `votes_*` フィールドを `0` に更新してください。

ドキュメントパス: `artifacts/{appId}/public/survey_results`

---

## トラブルシュート

| 症状 | 原因 | 対処法 |
|------|------|--------|
| 「読み込み中...」のまま止まる | Firebase CDN に到達できない（オフライン等） | ネットワーク接続を確認。オフラインではローカルモードに自動切替される |
| ステータスが「ローカルデモモード」のまま | Firebase 設定が未入力、または apiKey が不正 | 手順5 を確認し、`__firebase_config` が正しく設定されているか確認 |
| 「Firestoreの初期化に失敗しました」と表示 | Firestore が有効化されていない、またはセキュリティルールで拒否 | Firebase Console で Firestore の有効化と匿名認証の有効化を確認 |
| 「投票に失敗しました」と表示 | Firestore の書き込み権限エラー | セキュリティルールを確認。匿名認証が有効か確認 |
| 投票しても他の端末に反映されない | ローカルデモモードで動作中 | Firebase 設定を行い、ステータスが「リアルタイム同期中」になることを確認 |
| ボタンを押しても反応しない | 連打防止（600ms のデバウンス）が動作中 | 0.6秒待ってからもう一度タップしてください |

---

## ファイル構成

```
html/
├── index.html                         # 完成版（単体で動作）
├── AI時代の仕事のリアル_企画書.html      # 修正前のオリジナル（参考用）
└── README.md                          # このファイル
```

---

## 動作確認チェックリスト

### ローカルデモモード

- [ ] `index.html` をブラウザで開いてエラーなく表示される
- [ ] ステータスバッジが「ローカルデモモード」と表示される
- [ ] デモモードのバナーが画面上部に表示される
- [ ] 6つの投票テーマがすべて表示される
- [ ] テーマの文言が企画書と一致している
- [ ] 「👍 投票」ボタンをタップすると票数が増える
- [ ] 投票後にテーマが得票順にソートされる
- [ ] プログレスバー（青い背景）が投票数に応じて伸びる
- [ ] 連打しても1回分しかカウントされない（0.6秒のデバウンス）
- [ ] ページをリロードしても投票データが保持される
- [ ] スマホ画面サイズでもレイアウトが崩れない

### Firebase 本番モード

- [ ] Firebase 設定を埋め込んだ後、ステータスが「リアルタイム同期中」に変わる
- [ ] 複数のブラウザ/端末で同じページを開き、投票が即時反映される
- [ ] ネットワーク切断時にエラーメッセージが表示される
