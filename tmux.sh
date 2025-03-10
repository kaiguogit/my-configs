#!/bin/bash
# https://www.reddit.com/r/tmux/comments/jj35jf/launching_tmux_in_a_predefined_layout_from_the/
tmux setenv -ug TMOUT

start_session() {
    if ! tmux has-session -t "$1"; then
        tmux new-session -d -s "$1" -c "$2"
        tmux new-window -c "$2"
        tmux split-window -h -c "$2$3"
        tmux split-window -v -c "$2$4"
        tmux select-pane -t 0
        tmux select-window -p
        tmux send-keys "vim ."
        # tmux send-keys "vim ." Enter
    fi
}

start_session fos ~/build/fos-ci/fortios-ci /migadmin/pkg/angular /migadmin/pkg/angular
start_session fos-1 ~/build/fos-ci/worktree/1 /migadmin/pkg/angular /migadmin/pkg/angular
start_session fos-3 ~/build/fos-ci/worktree/3 /migadmin/pkg/angular /migadmin/pkg/angular
start_session neutrino-stage-omniselect ~/build/neutrino/neutrino
start_session neutrino-3 ~/build/neutrino/worktree/3
start_session tapestry ~/build/tapestry/tapestry
start_session sase ~/build/sase


tmux attach-session -d -t fos
