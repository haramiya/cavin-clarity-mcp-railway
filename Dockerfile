# ===========================================
# Clarity MCP Server - Railway Deploy用
# ===========================================
# Microsoft Clarity MCP サーバーを mcp-proxy で HTTP 化し、
# Remote MCP として公開するための Dockerfile
# ===========================================

FROM node:20-slim

# セキュリティアップデートと必要なパッケージのインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# mcp-proxy をグローバルインストール
# stdio MCP サーバーを HTTP/StreamableHTTP に変換するために必要
RUN npm install -g mcp-proxy

# @microsoft/clarity-mcp-server を事前にダウンロード
# npx のキャッシュを作成し、起動時間を短縮
RUN npx -y @microsoft/clarity-mcp-server --help || true

# Railway は PORT 環境変数を自動設定する
# 明示的なデフォルトは設定しない（Railway が注入）
ENV HOST=0.0.0.0

# ヘルスチェック用（オプション）
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:${PORT:-8080}/health || exit 1

# mcp-proxy で stdio サーバーを HTTP 化して起動
# --sse オプションで StreamableHTTP (SSE) を有効化
CMD mcp-proxy --host 0.0.0.0 --port ${PORT} -- npx -y @microsoft/clarity-mcp-server --clarity_api_token=${CLARITY_API_TOKEN}
