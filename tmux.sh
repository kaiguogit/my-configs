#!/bin/bash
# https://www.reddit.com/r/tmux/comments/jj35jf/launching_tmux_in_a_predefined_layout_from_the/
tmux setenv -ug TMOUT

start_session() {
    tmux new-session -d -s "$1" -c "$2"
    tmux new-window -c "$2"
    tmux split-window -h -c "$2$3"
    tmux split-window -v -c "$2$4"
    tmux select-pane -t 0
    tmux select-window -p
    tmux send-keys "vim ."
    # tmux send-keys "vim ." Enter
}

start_session fos ~/build/fos-ci/fortios-ci /migadmin/pkg/angular /migadmin/pkg/angular
start_session neutrino ~/build/neutrino/neutrino
start_session login_page ~/build/fos-ci/worktree/3 /migadmin/pkg/angular /migadmin/pkg/angular
start_session lint ~/build/fos-ci/worktree/1 /migadmin/pkg/angular /migadmin/pkg/angular


tmux attach-session -d -t fos
