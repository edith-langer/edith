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
tmux send-keys "until docker container ls | grep -q edith_table_extractor_1 ; do sleep 1 ; done ; docker exec edith_table_extractor_1 bash -c 'source /home/v4r/catkin_ws/devel/setup.bash ;  roslaunch --wait mongodb_store mongodb_store.launch db_path:=/home/v4r/mongo_db'" C-m
tmux select-pane -t 1
tmux send-keys "roscore" C-m
tmux select-pane -t 2
tmux send-keys "sleep 2" C-m
tmux send-keys "docker exec edith_table_extractor_1 bash -c 'source /home/v4r/catkin_ws/devel/setup.bash ;  cd /home/v4r/catkin_ws/src/table_extractor/scripts/ ; python table_extractor_script.py'" C-m
tmux send-keys "docker exec edith_table_extractor_1 bash -c 'source /home/v4r/catkin_ws/devel/setup.bash ;  cd /home/v4r/catkin_ws/src/table_extractor/scripts/ ; python read_rosbag.py'" C-m
tmux send-keys "until docker container ls | grep -q edith_png_to_klg_1 ; do sleep 1 ; done ; docker exec edith_png_to_klg_1 bash -c 'cd /home/v4r/data/scripts/ ; ./associate.sh'" C-m
tmux send-keys "docker exec edith_orb_slam_1 bash -c 'cd /home/v4r/data/scripts/ ; ./orb_slam.sh'" C-m
tmux send-keys "docker exec edith_png_to_klg_1 bash -c 'cd /home/v4r/data/scripts/ ; ./png_to_klg.sh'" C-m
tmux send-keys "docker attach edith_elastic_fusion_1" C-m
tmux send-keys "cd /home/v4r/data/scripts/" C-m
tmux send-keys "./elasticfusion.sh" C-m
# Attach to session
tmux -2 attach-session -t $SESSION

#docker exec edith_table_extractor_1 bash -c 'source /home/v4r/catkin_ws/devel/setup.bash ;  roslaunch --wait mongodb_store mongodb_store.launch db_path:=/home/v4r/mongo_db'

#docker exec edith_table_extractor_1 bash -c 'source /home/v4r/catkin_ws/devel/setup.bash ;  cd /home/v4r/catkin_ws/src/table_extractor/scripts/ ; python table_extractor_script.py'
