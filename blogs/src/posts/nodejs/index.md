# find missing dependence
```
npm i -g depcheck
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && depcheck" \;
```