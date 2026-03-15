# Dev Container Setup

This workspace uses a dynamic dev container configuration that adapts to your host OS (macOS or Ubuntu).

## Setup Instructions

1. Run the generation script to create the appropriate `devcontainer.json` based on your OS:
   ```bash
   ./.devcontainer/generate-devcontainer.sh
   ```

2. Open the workspace in VS Code and use the Dev Containers extension to rebuild the container.

## How It Works

- The script detects your OS using `uname -s`.
- For macOS (Darwin): Uses settings optimized for Docker Desktop.
- For Ubuntu (Linux): Uses settings for native Linux with X11 forwarding.
- The generated `devcontainer.json` is placed in `.devcontainer/`.

## Files

- `template.json`: Template for devcontainer configuration.
- `generate-devcontainer.sh`: Script to generate `devcontainer.json`.
- `devcontainer-macos-silicon.json`: Reference config for macOS.
- `devcontainer-ubuntu.json`: Reference config for Ubuntu.