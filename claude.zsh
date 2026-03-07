# --- Context-optimized Claude Code launcher ---
# --disallowedTools removes tool descriptions from the model's context,
# saving ~7.5k tokens (~3.75%) at session start.
# Subagents still get their own full tool sets via their agent definitions.
# Tools removed: WebSearch, WebFetch, NotebookEdit (rarely needed by main orchestrator)
# Chrome (--no-chrome by default): removed via flag, saves ~5.6k tokens
#
# Use 'ccc' or 'claude --chrome' when browser automation is needed.
# Use 'cf' (claude-full) to launch with all tools and no restrictions.

alias c='claude --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'
alias cs='claude --dangerously-skip-permissions --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'
alias ccc='claude --dangerously-skip-permissions --chrome'
alias csr='claude --resume --dangerously-skip-permissions --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'
alias cf='claude'  # claude-full: all tools, no restrictions

function ccp() {
  claude -p --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit "$@"
}

function claude_sessions() {
    python ~/programming/python_projects/claude_sessions.py
}

function claude_sessions_sidecar() {
    python ~/programming/python_projects/claude_sessions.py --sidecar
}

function claude_delete_session() {
    python ~/programming/python_projects/claude_delete_session.py
}

function ai_floater() {
    python ~/programming/python_projects/claude_sessions_floater.py
}

# claude_quick (uses reduced context)
function cq() {
    local prompt="$*"
    if [ -z "$prompt" ]; then
        echo "Usage: cq <your prompt here>"
        return 1
    fi
    claude --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit "$prompt"
}

function aid(){
    local prompt="/dir_instructions"
    claude -p --verbose --dangerously-skip-permissions "$prompt"
}
