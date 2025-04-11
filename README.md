# FFmpeg Video Compressor and Trimmer

Simple scripts to compress `.mov` videos and save the output as `.mp4`. Then, you can also trim the newly compressed videos into smaller videos from specific timetamps of interest.

The two scripts provided here are:

- `./compress.sh`
- `./trim.sh`

## How to Install

Run the `./install.sh` command to make the compress and trim scripts executable and also add it to your PATH automatically.

This will also install `ffmpeg` in your machine if not installed already.

## How to Use

You can now run the script from any directory in your CLI. If somehow you get an error when running the commands, it might be due to not being added to your path correctly or something in the `./install.sh` command failed. You can still access the scripts by going to the directory repo and run them from there.

Run following command to learn how to run the scripts:

```bash
compress --help
```

or
 
```bash
trim --help
```
