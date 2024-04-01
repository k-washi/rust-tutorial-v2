#!/bin/bash
 
# Visual Studio Code :: Package list
pkglist=(
		oderwat.indent-rainbow
		pkief.material-icon-theme
		mosapride.zenkaku
		gruntfuggly.todo-tree
        rust-lang.rust-analyzer
        vadimcn.vscode-lldb
        swellaby.vscode-rust-test-adapter
        JScearcy.rust-doc-viewer
        ritwickdey.LiveServer
        serayuzgur.crates
        tamasfe.even-better-toml
		GitHub.copilot
		GitHub.copilot-chat
)
 
for var in ${pkglist[@]}
do
    code --install-extension $var
done