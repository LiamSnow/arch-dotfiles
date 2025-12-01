#!/bin/bash
niri msg workspaces | grep -o '^\s*\*\s*[0-9]\+' | grep -o '[0-9]\+' || echo "1"
