# merge videos into one side by side
Sample below merge 6 video into 1 with 3 videos horizontal and 2 videos vertical
```
ffmpeg -i input.mp4 -i input.mp4 -i input.mp4 -i input.mp4 -i input.mp4 -i input.mp4 -filter_complex "[0:v][1:v][2:v]hstack=3[top]; [3:v][4:v][5:v]hstack=3[bottom]; [top][bottom]vstack,format=yuv420p[v]; [0:a][1:a][2:a][3:a][4:a][5:a]amerge=inputs=6[a]" -map "[v]" -map "[a]" -ac 2 combined.mp4
```

# gernate hls file
```
 ffmpeg -i ../input.mp4 -master_pl_name master.m3u8 -map 0:v:0 -map 0:a -c:v h264_videotoolbox -f hls -var_stream_map 'a:0,agroup:cam1,default:yes a:1,agroup:cam2 a:2,agroup:cam3 v:0' -hls_segment_filename 'file_%v_%03d.ts' -hls_time 10 out_%v.m3u8
 ```
 *notes*: var_stream_map must map all stream or error
 output will get input video streams[0] audio[0, 1, 2] then group audio to audio[i] => cam{i}

 # List encoders support
 ```
 ffmpeg -encoders
 ```

 ## list support h264 encoders supports
 ```
 ffmpeg -encoders | grep 264
 ```
 