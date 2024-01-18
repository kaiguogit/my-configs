#!/bin/bash
# https://www.reddit.com/r/tmux/comments/jj35jf/launching_tmux_in_a_predefined_layout_from_the/
tmux setenv -ug TMOUT
tmux new-session -d
tmux new-window
tmux split-window -h
tmux split-window -v
tmux select-pane -t 0
tmux select-window -p
tmux attach-session -d
