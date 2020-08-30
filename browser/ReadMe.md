# Browser
## max parallel connection
| Browser              | Connections per Domain         | Max Connections                |
| -------------------- | ------------------------------ | ------------------------------ |
| Chrome 81            | 6 [^note1]                     | 256[^note2]                    |
| Edge 18              | *same as Internet Explorer 11* | *same as Internet Explorer 11* |
| Firefox 68           | 9 [^note1] or 6 [^note3]       | 1000+[^note2]                  |
| Internet Explorer 11 | 12 [^note4]                    | 1000+[^note2]                  |
| Safari 13            | 6 [^note1]                     | 1000+[^note2] 

[^note1]: tested with 72 requests , 1 domain(127.0.0.1)
[^note2]: tested with 1002 requests, 6 requests per domain * 167 domains (127.0.0.*)
[^note3]: when called in async context, e.g. in callback of setTimeout, + requestAnimationFrame, then...
[^note4]: of which the last 6 are follow-ups (2,4,6 available at 0.5s,1s,1.5s respectively)
