# ☁️ Nube Architecture & Process Manager Guide

This document outlines the operational structure and usage instructions for the Nube environment, detailing the shift from legacy manual bash scripts to the new UI-driven **GNU Screen** multiplexing architecture and Supabase edge node integration.

## 1. System Overview

**Nube** acts as an edge cryptographic communications system built entirely matching a "Zero-Dependency C & Bash" philosophy. All operations—from JSON parsing (`stdcdr`, `stdbuscaarg`) to terminal drawing (`stdtermgoto`)—are implemented via tiny, atomic C executables without imports (`#include`).

Traditionally, processes like `n1.sh` or `querydescargausuario3wh.sh` were fired blindly using `start.sh` or manual bash chains. The output was sent to crude unmanaged files (e.g. `../n2.log`).

This has been entirely modernized with the introduction of **`manager.sh`**, an intelligent orchestrator offering a pseudo-ncurses UI natively in Bash that integrates log management and daemon compartmentalization.

## 2. Using `manager.sh`

Inside the `nube` directory, launch the UI by executing:
```bash
./manager.sh
```

### Navigating the UI

The UI interrogates the source of truth config file, `billboards.c`, using atomic sub-parsers to dynamically draw an interactive list of endpoints (consumers and publishers).

*   **`UP / DOWN` Arrows**: Moves your cursor (`>`) exactly as expected.
*   **`SPACEBAR`**: Toggles the highlighted consumer ON or OFF (`enabled`/`disabled`).
    *   *Note: This physically mutates the `billboards.c` file securely and modifies the process state in the background immediately.*
*   **`V` or `L`**: Opens the Live Log Viewer for the selected daemon.
*   **`Q` / `QUIT`**: Exits the UI.

## 3. Daemon Sandboxing & GNU Screen

When you turn a daemon ON with `SPACE`, the `manager.sh` evaluates if the host limits allow for `GNU Screen` encapsulation.

### Normal Behavior (With GNU Screen)
If `screen` is installed, the daemon is spun up into a detached multiplexed window.
```bash
screen -dmS "$consumer" bash -c "./$consumer > logs/$consumer.log 2>&1"
```
> [!TIP]
> This means operations are cleanly isolated. To interact natively with a screen session outside of `manager.sh`, you could theoretically `screen -r querydescargasupabase.sh` (though the console streams directly into the log file intentionally, so the standard way to inspect logic is via log reading).

### Graceful Fallback (Without Screen)
If `screen` is uninstalled on your bare-metal environment, `manager.sh` flawlessly switches to legacy background tasks:
```bash
./$consumer > logs/$consumer.log 2>&1 &
```
> [!NOTE]
> Even on fallback, process PIDs are diligently monitored. Turing the option to "OFF" will hunt the detached task using `ps -ef` avoiding duplicate spawned threads.

## 4. The Live Log Environment

Regardless of whether they were launched via Screen or Background, **ALL** standard out and standard error data is caught and serialized accurately inside the local `./logs/` folder.

Inside `manager.sh`, hovering over a node and pressing `V` immediately bridges you into a visualizer:
```text
Viewing live logs for querydescargasupabase.sh...
--> Press [Ctrl+C] to stop viewing and return to Manager <--
=================================================================
```

Pressing `Ctrl+C` does **not** terminate the manager or the daemon; the script intercepts standard Unix `SIGINT` trapping specifically to dump you cleanly back into the main `manager.sh` menu.
