alias gdelj='gl ci delete $(gl ci list | fzf | awk '{print $3}' | cut -c2-)'
