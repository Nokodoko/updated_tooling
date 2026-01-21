alias c='claude'
alias cs='claude --dangerously-skip-permissions'
alias csr='claude --dangerously-skip-permissions --resume'
# --resume
# /security-review

claude_sessions() {
    zellij run --floating --close-on-exit -- python /home/n0ko/programming/python_projects/claude_sessions.py
}

claude_delete_session() {
    zellij run --floating --close-on-exit -- python /home/n0ko/programming/python_projects/claude_delete_session.py
}
