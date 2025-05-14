sbe() {
  pushd ~/sbevision/ && for i in $(fd -td -d1); do gitup.lua $i; done
}


# sbe () {
# 	glab repo clone --group sbevision --paginate --include-subgroups --preserve-namespace
# 	pushd ~/sbevision/
# 	for i in $(fd -td -d1)
# 	do
# 		gitup.lua $i
# 	done
# 	popd
# }
alias kupdate='/home/n0ko/sbevision/devops/gitlab-ci-scripts/kcc/rancher.sh'
