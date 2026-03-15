#!/bin/bash

# OS 감지
OS=$(uname -s)
TEMPLATE_FILE=".devcontainer/template.json"
OUTPUT_FILE=".devcontainer/devcontainer.json"

if [ "$OS" = "Darwin" ]; then
  # macOS 설정
  DISPLAY='host.docker.internal:0'
  RUN_ARGS='["--ipc=host"]'
  MOUNTS=''
elif [ "$OS" = "Linux" ]; then
  # Ubuntu 설정 (Linux 커널 기반)
  DISPLAY='unix:0'
  RUN_ARGS='["--net=host", "--pid=host", "--ipc=host", "-e", "DISPLAY=${env:DISPLAY}"]'
  MOUNTS='"mounts": [
    "source=/tmp/.X11-unix,target=/tmp/.X11-unix,type=bind,consistency=cached",
    "source=/dev/dri,target=/dev/dri,type=bind,consistency=cached"
  ],'
else
  echo "Unsupported OS: $OS"
  exit 1
fi

# 템플릿에서 교체 (sed 사용, OS에 따라 옵션 조정)
cp "$TEMPLATE_FILE" "$OUTPUT_FILE"
if [ "$OS" = "Darwin" ]; then
  sed -i '' "s/{{DISPLAY}}/$DISPLAY/g" "$OUTPUT_FILE"
  sed -i '' "s/{{RUN_ARGS}}/$RUN_ARGS/g" "$OUTPUT_FILE"
  sed -i '' "s/{{MOUNTS}}/$MOUNTS/g" "$OUTPUT_FILE"
else
  sed -i "s/{{DISPLAY}}/$DISPLAY/g" "$OUTPUT_FILE"
  sed -i "s/{{RUN_ARGS}}/$RUN_ARGS/g" "$OUTPUT_FILE"
  sed -i "s/{{MOUNTS}}/$MOUNTS/g" "$OUTPUT_FILE"
fi

echo "Generated $OUTPUT_FILE for $OS"