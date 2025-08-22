# HexaEight Agent Dashboard

Latest release: **hexaeight-copilot-standalone-20250822_054248.tar.gz**

## Installation

```bash
# Extract the release
tar -xzf hexaeight-copilot-standalone-20250822_054248.tar.gz
cd hexaeight-copilot-standalone-*

# Configure
cp .env.example .env
nano .env

# Start
./start.sh
```

## Features

- Next.js application with integrated HexaEight Bridge
- Bridge runs automatically on localhost:8000
- Automatic graceful shutdown
- Configuration preservation during updates

## System Requirements

- Node.js 18+
- Python 3.8+ with venv support
- 1GB+ RAM

Generated: Fri Aug 22 05:48:32 UTC 2025
