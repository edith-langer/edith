The start script should build the docker images if they are not built already and start the containers. 
```
./start_containers.sh
```


outside of containers: 
- start a roscore
- run this command in a terminal: `xhost local:docker`


and start a roscore

In the container tmux window, there are 4 panes. 

 	png_to_klg 	 	|	elastic_fusion 	
 	------------------------|------------------------
	table_extractor tmux	|	orb_slam 		
	

Put the files reconstruction.ply and rosbag.bag into the data folder.

###  1. step in table_extractor pane 
Then you can run the `table_extractor_script.py` to get the tables.
Afterwards start `read_rosbag.py`. Execution takes some minutes for that one.

###  2. step in png_to_klg pane 

Run the `associate.sh` script. For example:
```
./associate.sh 3 0
```
This command runs the associate.py script for table 3 occurance 0. Default values for table and occurance are 0.

###  3. step in orb_slam pane 

```
./orb_slam.sh
```

###  4. step in png_to_klg pane 
```
./png_to_klg.sh
```

###  5. step in elastic_fusion pane 

~~ not tested yet ~~
