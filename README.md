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

To install the scripts and make them globally accessible, follow the steps below based on your operating system.

### For macOS and Linux Users

Run the following command:

```bash
./install.sh
```

### For Windows Users

1. **Install FFmpeg**:
   - Download the FFmpeg zip file from [https://ffmpeg.org/download.html](https://ffmpeg.org/download.html).
   - Extract the zip file to a directory, e.g., `C:\ffmpeg`.
   - Add the `C:\ffmpeg\bin` directory to your system's `PATH`:
     1. Open the Start menu and search for "Environment Variables."
     2. Click "Edit the system environment variables."
     3. In the "System Properties" window, click "Environment Variables."
     4. Under "System variables," find the `Path` variable and click "Edit."
     5. Add the path to the `bin` directory, e.g., `C:\ffmpeg\bin`.
     6. Click "OK" to save and close all dialogs.

2. **Install a Unix-like Environment**:
   - Use a terminal like **Git Bash** (comes with Git for Windows) or **WSL (Windows Subsystem for Linux)**.

3. **Run the Scripts**:
   - Open your Unix-like terminal (e.g., Git Bash or WSL).
   - Navigate to the directory where the scripts are located.
   - Run the scripts directly using the following commands:

     ```bash
     ./compress.sh <file.mov>
     ./trim.sh <file> <start_time> <end_time>
     ```

---

## Usage

Once installed, you can use the `compress` and `trim` commands from any directory in your terminal.

### 1. Compress Videos

The `compress` command reduces the size of `.mov` videos and saves them as `.mp4`.

#### Syntax

```bash
compress <file.mov>
```

#### Example

```bash
compress video.mov
```

This will compress `video.mov` and save the output as `video.mp4` in a `compressed` folder within the same directory as the input file.

#### Batch Compression

You can also compress multiple videos in a directory.

```bash
compress --batch [directory] [pattern]
```

- `directory`: The directory to search for videos (default: current directory).
- `pattern`: The file pattern to match (default: `*.mov`).

#### Example

```bash
compress --batch ./videos '*.mov'
```

This will compress all `.mov` files in the `./videos` directory.

---

### 2. Trim Videos

The `trim` command extracts a specific portion of a video by specifying start and end timestamps.

#### Syntax

```bash
trim <file> <start_time> <end_time>
```

- `<file>`: The input video file.
- `<start_time>`: The start timestamp in `HH:MM:SS` or `MM:SS` format.
- `<end_time>`: The end timestamp in `HH:MM:SS` or `MM:SS` format.

#### Example

```bash
trim video.mp4 00:01:00 00:02:30
```

This will trim `video.mp4` from 1 minute to 2 minutes and 30 seconds and save the output as `video_trimmed_00-01-00_00-02-30.mp4` in a `trimmed` folder within the same directory as the input file.

#### Notes

- Ensure the timestamps are in the correct format (`HH:MM:SS` or `MM:SS`).
- The trimmed video will be saved with a filename that includes the start and end timestamps.

---

## Troubleshooting

If you encounter issues running the scripts, consider the following:

1. Ensure `ffmpeg` is installed by running:

   ```bash
   ffmpeg -version
   ```

2. Verify that `$HOME/.local/bin` is in your `PATH` (for macOS/Linux users):

   ```bash
   echo $PATH
   ```

   If not, manually add it to your shell configuration file (`~/.zshrc` or `~/.bashrc`):

   ```bash
   export PATH="$PATH:$HOME/.local/bin"
   ```

3. For Windows users, ensure the `C:\ffmpeg\bin` directory is in your system's `PATH`.

4. Run the scripts directly from the repository directory if they are not globally accessible:

   ```bash
   ./compress.sh <file.mov>
   ./trim.sh <file> <start_time> <end_time>
   ```

---

## Notes for Windows Users

- Use a Unix-like terminal (e.g., Git Bash or WSL) to run the scripts.
- Ensure `ffmpeg` is installed and added to your system's `PATH`.
- Run the scripts directly using `./compress.sh` and `./trim.sh` commands.