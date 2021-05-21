table=${1:-0} 
occurance=${2:-0}

echo "executing associate.py for table$table occurance$occurance"

python /pngtoklg/png_to_klg/associate.py --max_difference 0.03 /home/v4r/data/table_$table/depth_$occurance.txt /home/v4r/data/table_$table/rgb_$occurance.txt > /home/v4r/data/associations.txt
