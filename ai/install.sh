#!/usr/bin/env bash
#
# ai/install.sh — symlink AI agent config (Claude Code, Codex, and friends)
#
# Links the files in ~/.dotfiles/ai into place:
#
#   ~/.claude/CLAUDE.md               -> ai/CLAUDE.md
#   ~/.agents/AGENTS.md               -> ai/AGENTS.md      (canonical, tool-agnostic)
#   ~/.codex/AGENTS.md                -> ~/.agents/AGENTS.md
#   ~/.claude/settings.json           -> ai/claude/settings.json
#   ~/.claude/statusline.sh           -> ai/claude/statusline.sh
#   ~/.claude/keybindings.json        -> ai/claude/keybindings.json
#   ~/.claude/output-styles/<style>   -> ai/claude/output-styles/<style>
#   ~/.claude/skills/<skill>          -> ai/skills/<skill>  (personal skills)
#   ~/.agents/skills                  -> ~/.claude/skills   (one home for skills)
#
# Run this BEFORE installing the shared ai-tools repo
# (github.com/adaptivemedia/ai-tools), so the ~/.agents/skills symlink exists
# when ai-tools links the team skills into ~/.claude/skills.
#
# Idempotent. Never overwrites a real (non-symlink) file.

set -euo pipefail

AI_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "AI config: $AI_DIR"

# Symlink $src -> $dst, replacing any existing symlink. Refuses to clobber a
# real (non-symlink) file/dir so local copies are never lost silently.
link() {
    local src="$1" dst="$2"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "  SKIP (real file present, not overwriting): $dst"
        return
    fi
    rm -f "$dst"
    ln -s "$src" "$dst"
    echo "  linked: $dst"
}

mkdir -p "$HOME/.claude/skills" "$HOME/.claude/output-styles" "$HOME/.agents" "$HOME/.codex"

echo "Instructions:"
link "$AI_DIR/AGENTS.md" "$HOME/.agents/AGENTS.md"
link "$AI_DIR/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
link "$HOME/.agents/AGENTS.md" "$HOME/.codex/AGENTS.md"

echo "Claude Code config:"
link "$AI_DIR/claude/settings.json" "$HOME/.claude/settings.json"
link "$AI_DIR/claude/statusline.sh" "$HOME/.claude/statusline.sh"
link "$AI_DIR/claude/keybindings.json" "$HOME/.claude/keybindings.json"
for style in "$AI_DIR"/claude/output-styles/*.md; do
    [ -e "$style" ] || continue
    link "$style" "$HOME/.claude/output-styles/$(basename "$style")"
done

echo "Personal skills:"
for skill in "$AI_DIR"/skills/*/; do
    [ -d "$skill" ] || continue
    link "${skill%/}" "$HOME/.claude/skills/$(basename "$skill")"
done

echo "One home for skills (~/.agents/skills follows ~/.claude/skills):"
link "$HOME/.claude/skills" "$HOME/.agents/skills"

echo "Done."
