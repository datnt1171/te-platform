#!/bin/bash
# Development helper script for switching between projects

case "$1" in
  django|backend)
    echo "🐍 Activating Django (backend) environment..."
    cd /workspace/backend
    source .venv/bin/activate
    echo "✅ Backend venv activated. Python: $(which python)"
    exec bash
    ;;
  
  fastapi|dw)
    echo "⚡ Activating FastAPI (dw) environment..."
    cd /workspace/dw
    source .venv/bin/activate
    echo "✅ DW venv activated. Python: $(which python)"
    exec bash
    ;;
  
  frontend|next)
    echo "⚛️  Switching to Frontend..."
    cd /workspace/frontend
    echo "✅ Frontend directory. Node: $(node --version)"
    exec bash
    ;;
  
  *)
    echo "Usage: source dev.sh [django|fastapi|frontend]"
    echo ""
    echo "Available commands:"
    echo "  source dev.sh django    - Activate Django backend environment"
    echo "  source dev.sh fastapi   - Activate FastAPI dw environment"
    echo "  source dev.sh frontend  - Switch to frontend directory"
    echo ""
    echo "Or manually:"
    echo "  cd /workspace/backend && source .venv/bin/activate"
    echo "  cd /workspace/dw && source .venv/bin/activate"
    ;;
esac