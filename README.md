On the first start, run 
```
xhost local:docker
docker-compose --profiles first_run up
```

This will start all the necessary containers. They are:
- voxblox
- sparseconvnet
- table_extractor
- png_to_klg
- elasticfusion

The ```.env``` file is used to set the correct variables for ``` ROS_IP``` , ``` ROS_MASTER_URI```  and the ``` shared folder path``` . 

Voxblox and Sparseconvnet are used to create the first full semantically segmented reconstruction of the room.
After the Voxblox container started, one has to drive the robot through the room. 
To save the reconstruction, call 
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