#!/bin/bash

SESSION=edith_pipeline



tmux -2 new-session -d -s $SESSION
tmux set -g mouse on

tmux new-window -t $SESSION

tmux select-window -t $SESSION:1
tmux send-keys "docker-compose up" C-m
tmux select-window -t $SESSION:0
tmux split-window -h
tmux split-window -v
tmux select-pane -t 0
tmux split-window -v
tmux select-pane -t 0
tmux send-keys "until docker container ls | grep -q edith_png_to_klg_1 ; do sleep 1 ; done ; docker attach edith_png_to_klg_1" C-m
tmux select-pane -t 1
tmux send-keys "until docker container ls | grep -q edith_table_extractor_1 ; do sleep 1 ; done ; docker attach edith_table_extractor_1 " C-m
tmux send-keys "source /home/v4r/catkin_ws/devel/setup.bash" C-m
tmux send-keys "src/table_extractor/run_table_extractor.sh" C-m
tmux select-pane -t 2
tmux send-keys "until docker container ls | grep -q edith_elastic_fusion_1 ; do sleep 1 ; done ; docker attach edith_elastic_fusion_1" C-m
tmux select-pane -t 3
tmux send-keys "until docker container ls | grep -q edith_orb_slam_1 ; do sleep 1 ; done ; docker attach edith_orb_slam_1" C-m


# Attach to session
tmux -2 attach-session -t $SESSION

