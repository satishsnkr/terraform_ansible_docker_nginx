while true 
do 
		res=`docker stats nginx --no-stream --format "{{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}"`;
		dte=`date`;
		echo  $dte $res   >> logs/resource.log
		sleep 10
done
