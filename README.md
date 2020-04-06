
 # find text in directory
 ```
 grep -rnw '/path/to/somewhere/' -e 'pattern'
 ```
 
 - pass properties to children react props by using React.cloneElement
 - using withStyles from @material-ui/core/styles for react-admin


## add git submodule
git add submodule [url] name

## git remove submodule
# Remove the submodule entry from .git/config
git submodule deinit -f path/to/submodule

# Remove the submodule directory from the superproject's .git/modules directory
rm -rf .git/modules/path/to/submodule

# Remove the entry in .gitmodules and remove the submodule directory located at path/to/submodule
git rm -f path/to/submodule

# cors error when 301
remove trailing / at end of apis

# config vscode for tsx, jsx, js, ts support
"files.associations": {
        "*.js":"javascriptreact",
        "*.ts": "typescriptreact",
        "*.jsx": "javascriptreact",
        "*.tsx":"typescriptreact"
    },
## delete node_modules recursive
find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +
find . -name "node_modules" -type d -prune -print | xargs du -chs
find . -name 'node_modules' -type d -prune -print -exec rm -rf '{}' \;

## common lib
 - logger for js: loglevel
 
# install npm module for sub dir
```
find . -maxdepth 1 -type d \( ! -name . \) -exec sh -c "cd '{}' && echo '>>>>>>>> run in {}' && rm -rf node_modules && npm install" \;
```
 
