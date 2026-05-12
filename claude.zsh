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
alias cs='claude --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'
alias csb='CLAUDE_CONFIG_DIR=$HOME/.claude-business claude --permission-mode bypassPermissions --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'
alias ccc='claude --permission-mode bypassPermissions --chrome'
alias csr='claude --resume --permission-mode bypassPermissions --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'
alias cf='claude'  # claude-full: all tools, no restrictions

# claude-business: isolates entire config dir (creds, projects, memory) for the business OAuth token.
# First run: `cb` then `/login` to populate ~/.claude-business/.credentials.json.
# Personal `c` / `cs` / etc. continue to use ~/.claude/ untouched.
alias cb='CLAUDE_CONFIG_DIR=$HOME/.claude-business claude --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'
alias cbs='CLAUDE_CONFIG_DIR=$HOME/.claude-business claude --permission-mode bypassPermissions --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'
alias ccb='CLAUDE_CONFIG_DIR=$HOME/.claude-business claude --permission-mode bypassPermissions --chrome'
alias csrb='CLAUDE_CONFIG_DIR=$HOME/.claude-business claude --resume --permission-mode bypassPermissions --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'

function ccp() {
  claude -p --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit "$@"
}

function claude_sessions() {
    python ~/programming/python_projects/claude_sessions.py
}

function claude_sessions_business() {
    python ~/programming/python_projects/claude_sessions.py --business
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

# claude with model selector via flisty
function csm() {
    local model
    model=$(printf '%s\n' \
        claude-opus-4-6 \
        claude-sonnet-4-6 \
        claude-haiku-4-5-20251001 \
        gemini-2.5-pro \
        gemini-2.5-flash \
        | flisty 'Claude Code Models')
    [[ -z "$model" ]] && return 1
    claude --permission-mode bypassPermissions --no-chrome \
        --disallowedTools WebSearch WebFetch NotebookEdit \
        --model "$model"
}

function aid(){
    local prompt="/dir_instructions"
    claude -p --verbose --permission-mode bypassPermissions "$prompt"
}
