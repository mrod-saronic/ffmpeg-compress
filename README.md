# FFmpeg Video Compressor and Trimmer

This repository provides two simple yet powerful Bash scripts for video processing using `ffmpeg`. These scripts allow you to compress `.mov` videos into `.mp4` format and trim videos into smaller segments based on specific timestamps.

## Features

- **Video Compression**: Reduce the size of `.mov` videos while maintaining quality.
- **Video Trimming**: Extract specific portions of a video by specifying start and end timestamps.

The scripts included are:

- `compress.sh`: Compress videos.
- `trim.sh`: Trim videos.

---

## Installation

To install the scripts and make them globally accessible, run the following command:

```bash
./install.sh
```

### What the Installation Does:

1. Installs `ffmpeg` (if not already installed).
2. Copies the `compress.sh` and `trim.sh` scripts to `$HOME/.local/bin`.
3. Adds `$HOME/.local/bin` to your system's `PATH` (if not already added).

After installation, restart your terminal or run the following command to reload your shell configuration:

```bash
source ~/.zshrc  # For Zsh users
source ~/.bashrc # For Bash users
```

---

## Usage

Once installed, you can use the `compress` and `trim` commands from any directory in your terminal.

### 1. Compress Videos

The `compress` command reduces the size of `.mov` videos and saves them as `.mp4`.

#### Syntax:

```bash
compress <file.mov>
```

#### Example:

```bash
compress video.mov
```

This will compress `video.mov` and save the output as `video.mp4` in a `compressed` folder within the same directory as the input file.

#### Batch Compression:

You can also compress multiple videos in a directory.

```bash
compress --batch [directory] [pattern]
```

- `directory`: The directory to search for videos (default: current directory).
- `pattern`: The file pattern to match (default: `*.mov`).

#### Example:

```bash
compress --batch ./videos '*.mov'
```

This will compress all `.mov` files in the `./videos` directory.

---

### 2. Trim Videos

The `trim` command extracts a specific portion of a video by specifying start and end timestamps.

#### Syntax:

```bash
trim <file> <start_time> <end_time>
```

- `<file>`: The input video file.
- `<start_time>`: The start timestamp in `HH:MM:SS` or `MM:SS` format.
- `<end_time>`: The end timestamp in `HH:MM:SS` or `MM:SS` format.

#### Example:

```bash
trim video.mp4 00:01:00 00:02:30
```

This will trim `video.mp4` from 1 minute to 2 minutes and 30 seconds and save the output as `video_trimmed_00-01-00_00-02-30.mp4` in a `trimmed` folder within the same directory as the input file.

#### Notes:

- Ensure the timestamps are in the correct format (`HH:MM:SS` or `MM:SS`).
- The trimmed video will be saved with a filename that includes the start and end timestamps.

---

## Troubleshooting

If you encounter issues running the scripts, consider the following:

1. Ensure `ffmpeg` is installed by running:

   ```bash
   ffmpeg -version
   ```

2. Verify that `$HOME/.local/bin` is in your `PATH`:

   ```bash
   echo $PATH
   ```

   If not, manually add it to your shell configuration file (`~/.zshrc` or `~/.bashrc`):

   ```bash
   export PATH="$PATH:$HOME/.local/bin"
   ```

3. Run the scripts directly from the repository directory if they are not globally accessible:

   ```bash
   ./compress.sh <file.mov>
   ./trim.sh <file> <start_time> <end_time>
   ```
