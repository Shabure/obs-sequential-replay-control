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

### Key Parts of the Code

Here’s a summary of the main parts of the code for users who may want to modify it:

- **Hotkey Initialization and Control (`sequence_hotkey_id`)**:  
  This variable is the identifier for the hotkey used to trigger the replay sequence. The function `execute_replay_sequence()` manages hotkey presses, ensuring that only one sequence runs at a time by checking the `current_phase`.

- **Replay Sequence Phases (`current_phase`)**:  
  This variable tracks the stage of the replay sequence: idle, save, stop, and start. It begins at idle and updates to the next phase after completing each step, returning to idle after restarting the replay buffer.

- **Save Replay (`save_replay`)**:  
  This function initiates replay saving using `obs.obs_frontend_replay_buffer_save()`. It includes `check_if_saved()`, which checks if saving is complete and advances to the stop phase if so.

- **Stop Replay (`stop_replay`)**:  
  This function halts the replay buffer through `obs.obs_frontend_replay_buffer_stop()`. It uses `check_if_stopped()` to ensure stopping has finished before moving on to start the replay again.

- **Start Replay (`start_replay`)**:  
  This function restarts the replay buffer with `obs.obs_frontend_replay_buffer_start()`, completing the sequence by setting `current_phase` back to idle.

- **Automatic Start on Launch (`script_load`)**:  
  This function automatically launches the replay buffer when OBS starts if it's not already active. It also registers the hotkey for the sequence.

- **Settings Save and Load (`script_save`, `script_load`)**:  
  These functions handle saving and loading the hotkey settings, ensuring that the user’s preferred hotkey is preserved across sessions.

### Acknowledgments
This script was developed with the assistance of ChatGPT, an AI language model by OpenAI.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
