#!/bin/bash
set -e

# GitHub Release Creator for Agent Dashboard
# ==========================================

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[RELEASE]${NC} $1"; }
log_success() { echo -e "${GREEN}[RELEASE]${NC} $1"; }
log_error() { echo -e "${RED}[RELEASE]${NC} $1"; }

# Get version and tar file
VERSION=$(cat VERSION 2>/dev/null || echo "unknown")
TAR_FILE=$(ls hexaeight-copilot-standalone-*.tar.gz 2>/dev/null | head -1)

if [ -z "$TAR_FILE" ]; then
    log_error "❌ No tar.gz file found in current directory"
    exit 1
fi

log_info "🚀 Creating GitHub release..."
log_info "📦 Version: $VERSION"
log_info "📁 Package: $TAR_FILE"

# Check for GitHub CLI
if ! command -v gh &> /dev/null; then
    log_error "❌ GitHub CLI not found"
    log_error "Install: sudo apt install gh"
    log_error "Login: gh auth login"
    exit 1
fi

# Get repository info
read -p "Enter GitHub repository (username/repo-name): " GITHUB_REPO
if [ -z "$GITHUB_REPO" ]; then
    log_error "❌ Repository required"
    exit 1
fi

# Create release
TAG_NAME="v$VERSION"
RELEASE_NOTES="🚀 **HexaEight Agent Dashboard v$VERSION**

**What's Included:**
- Complete Next.js application
- Integrated HexaEight Bridge (localhost:8000)
- Auto-setup scripts for Python environment
- Graceful service management
- Configuration preservation

**Quick Install:**
\`\`\`bash
wget https://github.com/$GITHUB_REPO/releases/download/$TAG_NAME/$TAR_FILE
tar -xzf $TAR_FILE
cd hexaeight-copilot-standalone-*
cp .env.example .env
# Edit .env as needed
./start.sh
\`\`\`

**Requirements:**
- Node.js 18+
- Python 3.8+ with venv
- 1GB+ RAM

Built: $(date -u +%Y-%m-%d)"

log_info "🏷️  Creating release: $TAG_NAME"

gh release create "$TAG_NAME" \
    --repo "$GITHUB_REPO" \
    --title "HexaEight Agent Dashboard $TAG_NAME" \
    --notes "$RELEASE_NOTES" \
    "$TAR_FILE"

log_success "🎉 Release created!"
log_info "🌐 https://github.com/$GITHUB_REPO/releases/tag/$TAG_NAME"

echo ""
log_info "📋 Installation command for users:"
echo "wget https://github.com/$GITHUB_REPO/releases/download/$TAG_NAME/$TAR_FILE"

log_success "✨ Done!"
