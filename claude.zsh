alias c='claude'
alias cs='claude --dangerously-skip-permissions'
alias ccc='claude --dangerously-skip-permissions --chrome'
alias csr='claude --resume --dangerously-skip-permissions'

function ccp() {
  claude -p "$@"
}

function claude_sessions() {
    python ~/programming/python_projects/claude_sessions.py
}

function claude_delete_session() {
    python ~/programming/python_projects/claude_delete_session.py
}

function ai_floater() {
    zellij run --floating --close-on-exit -- python ~/programming/python_projects/claude_sessions_floater.py
}

# claude_quick
function cq() {
    local prompt="$*"
    if [ -z "$prompt" ]; then
        echo "Usage: claude_quick <your prompt here>"
        return 1
    fi
    claude "$prompt"
}
