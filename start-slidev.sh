#!/usr/bin/env bash

# 启动 Slidev 本地预览脚本（中文）
#
# 使用说明：
#   ./start-slidev.sh [--topic <主题名>] [--entry <入口md>] [--port <端口>] [--host <主机>] [--no-open] [--kill]
#
# 约定：
# - 默认主题：coding-agents-intro
# - 入口文件：slides/<topic>/main/index.md（可用 --entry 覆盖）
# - 端口优先使用 3030；若占用则自动递增查找空闲端口
# - Node ≥ 18，使用 npx 调用 slidev
# - 对外访问：通过 --remote 开启公共监听，--bind 指定监听地址（默认 localhost，WSL2 兼容）

set -euo pipefail

usage() {
  cat <<'EOF'
用法：
  ./start-slidev.sh [--topic <主题名>] [--entry <入口md>] [--port <端口>] [--host <主机>] [--no-open] [--kill]

参数：
  --topic <主题名>   主题目录名（默认：coding-agents-intro）
  --entry <入口md>   指定入口 Markdown（覆盖默认 slides/<topic>/main/index.md）
  --port <端口>      指定起始端口（默认：3030；若占用将自动加一重试）
  --host <主机>      监听主机地址（默认：localhost，WSL2 可从 Windows 访问；等效 slidev 的 --remote + --bind）
  --no-open          不自动打开浏览器（默认：自动打开）
  --kill             启动前结束同入口的已运行 Slidev 进程
  -h, --help         显示本帮助

示例：
  ./start-slidev.sh                                 # 预览默认主题 slides/coding-agents-intro/main/index.md
  ./start-slidev.sh --topic my-talk                 # 预览 slides/my-talk/main/index.md
  ./start-slidev.sh --entry slides/x/main/intro.md  # 直接指定入口文件
  ./start-slidev.sh --port 3031 --no-open           # 指定端口且不自动打开浏览器
EOF
}

topic="coding-agents-intro"
entry=""
port=3030
host="localhost"
open_browser=true
kill_existing=false

while (($#>0)); do
  case "$1" in
    --topic)
      shift; topic="${1:-}" || true ;;
    --entry)
      shift; entry="${1:-}" || true ;;
    --port)
      shift; port="${1:-}" || true ;;
    --host)
      shift; host="${1:-}" || true ;;
    --no-open)
      open_browser=false ;;
    --kill)
      kill_existing=true ;;
    -h|--help)
      usage; exit 0 ;;
    *)
      echo "未知参数：$1" >&2; usage; exit 1 ;;
  esac
  shift || true
done

# Node / npx 检查
if ! command -v node >/dev/null 2>&1; then
  echo "错误：未检测到 node，请先安装 Node.js (>=18)" >&2
  exit 1
fi

# 入口解析
if [[ -z "$entry" ]]; then
  entry="slides/${topic}/main/index.md"
fi
if [[ ! -f "$entry" ]]; then
  echo "错误：入口文件不存在：$entry" >&2
  exit 1
fi

# 可选结束已运行实例
if $kill_existing; then
  pkill -f "slidev\s\Q$entry\E" 2>/dev/null || true
fi

# 选择空闲端口（最多尝试 20 次）
choose_port() {
  local p=$1
  for _ in $(seq 1 20); do
    if command -v lsof >/dev/null 2>&1; then
      if ! lsof -i TCP:"$p" -sTCP:LISTEN -Pn >/dev/null 2>&1; then
        echo "$p"; return 0
      fi
    else
      # 若无 lsof，直接返回指定端口
      echo "$p"; return 0
    fi
    p=$((p+1))
  done
  echo "$1"
}

port=$(choose_port "$port")

log_file=".slidev-${topic//\//-}.log"
: > "$log_file"

echo "启动 Slidev：entry=$entry host=$host port=$port log=$log_file"

# 构建 slidev 命令
# WSL2 兼容：localhost 不使用 --remote（依赖 WSL2 端口转发）
# 网络访问：0.0.0.0 使用 --remote --bind 启用对外监听
cmd=(npx slidev "$entry" --port "$port")
if [[ "$host" != "localhost" && "$host" != "127.0.0.1" ]]; then
  cmd+=(--remote --bind "$host")
fi
if $open_browser; then
  cmd+=(--open)
fi

# 直接前台运行并追加日志；中断请 Ctrl+C
"${cmd[@]}" 2>&1 | tee -a "$log_file"
