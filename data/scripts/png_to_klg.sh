klgfilename=${1:-scene} 
echo $klgfilename
cd /home/v4r/data/
/pngtoklg/png_to_klg/build/pngtoklg -w . -o $klgfilename.klg -s 1000 -t
