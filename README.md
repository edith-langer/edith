On the first start, run 
```
xhost local:docker
docker-compose --profiles first_run up
```

This will start all the necessary containers. They are:
- [voxblox](https://github.com/ethz-asl/voxblox) 
- [sparseconvnet](https://rgit.acin.tuwien.ac.at/edith-langer/sparseconvnet/-/tree/robot_experiments)
- [table_extractor](https://rgit.acin.tuwien.ac.at/leitnermrks/table_extractor)
- [png_to_klg](https://rgit.acin.tuwien.ac.at/leitnermrks/png_to_klg)
- [elasticfusion](https://github.com/edith-langer/ElasticFusion.git )

The ```.env``` file is used to set the correct variables for ```ROS_IP``` , ```ROS_MASTER_URI```  and the ```shared folder path``` . 

Voxblox and Sparseconvnet are used to create the first full semantically segmented reconstruction of the room.
After the Voxblox container started, one has to drive the robot through the room. 

To save the reconstruction, execute the according command from the table_extractor statemachine on the robot, or call 
```
rosservice call /voxblox_node/generate_mesh 
```

If you want to start from the beginning, you can clear the progress with 
```
rosservice call /voxblox_node/clear_map
```

After the reconstruction is saved, you have to call sparseconvnet with 
```
rosservice call /sparseconvnet_ros/sparseconvnet_ros_service/execute /root/share/hsrb_result.ply
```

If you run 
```
docker-compose up
```
only the following containers will be started:
- table_extractor
- png_to_klg
- elasticfusion

## Execute on the robot

On the robot, start the ```sasha_run_table_extractor.sh``` script with
```
source /home/v4r/Markus_L/devel/setup.bash
rosrun table_extractor sasha_run_table_extractor.sh
```

This starts a tmux shell, one pane starts the mongodb database, one loads the rosparams, one starts the move_around_tables.py script and one starts the statemachine, where you can give the commands. 

By pressing `m` and then `Enter`, the statemachine calls the generate_mesh rosservice and afterwards the sparseconvnet_ros_service. 
By pressing `c`, the clear_map service is called to clear the progress from voxblox. 

Press `s` to start the pipeline. 
The pipeline will do the following steps: 
1. Clear database
2. Fetch reconstruction file from the backpack to the robot
3. Extract the planes from the reconstruction file and save them in the database
4. Generate viewpoints for every extracted plane and save them in the database
5. Choose a plane
6. Move around a plane while staring at it and recording a rosbag, moving the bagfile to the backpack
7. Extract the png files from the rosbag 
8. Convert the png files to a klg file
9. Call ElasticFusion


To change the rosparams, edit the rosparam.yaml file in the table_extractor folder. You can change the call parameters for png_to_klg and elasticfusion there, and edit the topics that are recorded by the move_around_tables script for example. 
