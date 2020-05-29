# config for local credential
```
git config --local credential.helper ""
```


# remove wrong user commit
```
git commit --amend --reset-author
```
# export source code local master as zip
```
git archive --format zip --output
```
# get repote url
```
git config --get remote.origin.url
```

# store local password
```
git remote set-url origin https://${username}@github.com/{path}
```

# store password for git in helper
in .git/config
```
[credential]
        helper = osxkeychain
```

when keychain store 2 accounts for same github page => can be error