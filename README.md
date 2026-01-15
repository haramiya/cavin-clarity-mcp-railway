# Clarity MCP Server for Railway

**Microsoft Clarity** の MCP サーバーを Railway にデプロイして、Claude Desktop などの MCP クライアントから利用できるようにします。

> 🎯 **ローカル起動は不要です。** GitHub リポジトリを Railway に接続するだけでデプロイできます。

---

## ✅ このリポジトリでできること

- Microsoft Clarity のデータを Claude Desktop から自然言語で分析
- ヒートマップ、セッション記録、ユーザー行動データの取得
- Railway 上で動作する Remote MCP サーバー

---

## 📋 事前準備

### 1. Clarity API Token の取得

1. [Microsoft Clarity](https://clarity.microsoft.com/) にログイン
2. プロジェクトを選択
3. **Settings** → **API** → **Generate API Token**
4. 生成されたトークンをコピー

---

## 🚀 Railway へのデプロイ手順

### Step 1: GitHub リポジトリを作成

1. このリポジトリを Fork するか、新しいリポジトリを作成
2. `Dockerfile` と `README.md` をリポジトリに追加

### Step 2: Railway でプロジェクト作成

1. [Railway](https://railway.app/) にログイン
2. **New Project** をクリック
3. **Deploy from GitHub repo** を選択
4. このリポジトリを選択

### Step 3: 環境変数（Variables）を設定

Railway のプロジェクト画面で：

1. デプロイされたサービスをクリック
2. **Variables** タブを開く
3. 以下の変数を追加：

| Variable Name | 値 | 説明 |
|--------------|-----|------|
| `CLARITY_API_TOKEN` | `your-api-token` | Clarity の API トークン |

### Step 4: デプロイ確認

1. **Deployments** タブでデプロイ状況を確認
2. ✅ **Success** になれば完了
3. **Settings** → **Networking** → **Generate Domain** で公開 URL を取得

---

## 🖥️ Claude Desktop での接続方法

### Step 1: Settings を開く

Claude Desktop を起動し、**Settings**（歯車アイコン）を開く

### Step 2: Remote MCP Server を追加

1. **Connectors** または **MCP Servers** セクションを開く
2. **Add Remote MCP Server** をクリック
3. 以下を入力：

| 項目 | 値 |
|-----|-----|
| **Name** | `Clarity` （任意の名前） |
| **Transport** | `Streamable HTTP` |
| **URL** | `https://your-app.railway.app/sse` |

> ⚠️ URL の末尾に `/sse` を付けてください

### Step 3: 接続テスト

Claude に以下のように話しかけてみてください：

```
Clarity のプロジェクト一覧を見せて
```

---

## 📁 ファイル構成

```
clarity-mcp-railway/
├── Dockerfile    # Railway デプロイ用
└── README.md     # このファイル
```

---

## 🔧 トラブルシューティング

### デプロイが失敗する

- **Variables** に `CLARITY_API_TOKEN` が設定されているか確認
- Railway の **Logs** タブでエラーメッセージを確認

### Claude Desktop から接続できない

- URL が正しいか確認（末尾の `/sse` を忘れずに）
- Railway の **Networking** で Domain が生成されているか確認
- Transport が `Streamable HTTP` になっているか確認

### API Token エラー

- Clarity で生成したトークンが有効か確認
- トークンに余分なスペースが入っていないか確認

---

## 📚 参考リンク

- [Microsoft Clarity MCP Server](https://github.com/microsoft/clarity-mcp-server)
- [Railway Documentation](https://docs.railway.app/)
- [MCP Proxy](https://github.com/anthropics/mcp-proxy)

---

## ⚠️ 注意事項

- Railway の無料プランには制限があります
- API Token は外部に漏らさないでください
- 本番利用時は Railway の有料プランを検討してください
