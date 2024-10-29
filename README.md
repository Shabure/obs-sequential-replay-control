# OBS Sequential Replay Control Script

This script allows OBS users to sequentially save, stop, and start the replay buffer with a single hotkey. It's particularly useful for streamers and content creators who want to save replay clips without interrupting their workflow.

## Features
- **Save, Stop, and Start Replay Buffer with One Hotkey**: All actions are triggered in a specific sequence by pressing a single hotkey.
- **Automatic Replay Start**: Replay buffer starts automatically when OBS is launched, ensuring replays are always ready to capture.
- **Sequential Execution**: The script ensures each action (Save -> Stop -> Start) completes successfully before moving to the next.

## Getting Started

### Prerequisites
- [OBS Studio](https://obsproject.com/) (tested with version 30.2.3, but compatible with most recent versions).
- Basic understanding of how to add scripts in OBS.

### Installation

1. **Download the Script**: Download the `sequential_replay_control.lua` file from this repository.
2. **Move to OBS Scripts Folder**: Place the downloaded `.lua` script in your OBS scripts folder, typically located at: C:\Program Files\obs-studio\data\obs-plugins\frontend-tools\scripts\
3. **Add Script to OBS**:
- Open OBS and navigate to `Tools` > `Scripts`.
- In the Scripts dialog, click the `+` button and select `sequential_replay_control.lua`.
4. **Set Hotkey**:
- Go to `Settings` > `Hotkeys`.
- Find `Save-Stop-Start Replay` under the script's name and assign a preferred hotkey.

### Usage
Once installed and configured, press the assigned hotkey in OBS to:
1. Save the current replay buffer.
2. Stop the replay buffer.
3. Restart the replay buffer.

### Acknowledgments
This script was developed with the assistance of ChatGPT, an AI language model by OpenAI.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

