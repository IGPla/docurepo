# ffmpeg

This utility is the reference on transcoding audio/video. It is a really interesting tool, that holds nearly all known codecs for audio and video transcoding, and provides a simple yet powerful command line interface to transcode audio and video files

## Common strucure

ffmpeg -i INPUT1 -i INPUT2 -i INPUTN MODIFIERS OUTPUT

- It accepts several inputs
- Each input can be simple (Single stream, single channel) or complex (Multiple streams, multiple channels)
- Modifiers allows to tune the conversion
- Output must be the file where it will output the result

## Considerations

- ffmpeg infers input and output file codecs by extension. 
- Anyway, you can choose the codec used in MODIFIERS section
- It works with both audio and video 
- By default, if not specified, even if source files have multiple streams and channels, output file will only have 1 of them

## Useful samples

### Get ffmpeg available codecs

```
ffmpeg -codecs
```

### Get ffmpeg available formats

```
ffmpeg -formats
```

### Get media info

```
ffmpeg -i source.mp4
```

It outputs source video information. Really useful to know which streams / channels / codecs / quality contains the source file.

### Simple transcode

```
ffmpeg -i source.avi dest.mp4
```

Takes source.avi from input and selects the properly codec to encode dest.mp4 from input

### Create multiple outputs from single input

```
ffmpeg -i source.mp4 -map 0:0 dest.mp4 -map 0:1 dest.mp3
```

It creates multiple outputs based on source multiple channels (from stream 0, it takes its audio and video channel and maps to different destiny files)

### Create single output from multiple input

```
ffmpeg -i source.mp4 -i source.mp3 -map 0:0 -map 1:0 dest.mp4
```

Merges channel 0 from stream 0 (source.mp4) and channel 0 from stream 1 (source.mp3) into dest.mp4

### Tune common params

```
ffmpeg -i source.mp4 -c:v libx264 -b:v 128k -c:a aac -b:a 98k output.mp4
```

Common video params (codec and bitrate) can be tuned with params -c:v and -b:v. Common audio params (codec and bitrate) can be tuned with params -c:a and -b:a. 

### Tune params on channels

```
ffmpeg -i source.mp4 -map 0:0 -map 0:1 -map 0:2 -c:v libx264 -b:v 1000k -c:a aac -b:a:0 100k -b:a:1 200k output.mp4
```

In this example, it takes a source.mp4 with single video channel and 2 audio channels. It maps both audio channels to be transcoded, with the same codec, but with different bitrates

### Increase audio volume

```
ffmpeg -i source.mp4 -af volume=2 dest.mp4
```

Use audio filters to double the volume

### Rescale a video

```
ffmpeg -i source.mp4 -vf scale=320:240 dest.mp4
```

Rescales source.mp4 to 320x240

```
ffmpeg -i source.mp4 -vf scale=320:-1 dest.mp4
```

Rescales source.mp4 to 320xA, where A will keep the scale factor of original video (it will prevent deformations based on source.mp4 aspect ratio)

```
ffmpeg -i source.mp4 -vf scale=iw/2:ih/2 dest.mp4
```

Rescales source.mp4 to half width and half height

### Cut video

```
ffmpeg -i source.mp4 -ss 30 -t 20 dest.mp4
```

Cuts source.mp4 from second 30 to 50 and outputs to dest.mp4

```
ffmpeg -i source.mp4 -ss 00:30 -to 00:50 dest.mp4
```

Same as above, but controlling absolute timings

### Concatenate

```
ffmpeg -f concat -safe 0 -i concat_list.txt -c copy dest.mp4
```

The content of concat_list.txt as example

```
file './videos/vid1.mp4'
file './videos/vid2.mp4'
file './videos/vid3.mp4'
```

Concatenates all files in your concatenation list into a new file 

### libx264

This is a common encoder. It should be set (c:v libx264) with a preset option, telling which quality is desired

```
ffmpeg -i source.mp4 -v:c libx264 -preset veryfast dest.mp4
```

Possible preset options: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow

A preset is simply a collection of options that provide a certain encoding speed to compression ratio. Slower preset will provide better compression (quality per filesize). It means that if you target a certain file size or constant bit rate, you will achieve better compression with a slower preset.
