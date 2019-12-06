
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
