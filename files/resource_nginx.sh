while true; do res=`docker stats nginx --no-stream --format "{{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}"`; dte=`date`; tr="</tr><tr>"; echo  $dte $res $tr >> html/resource.html; sleep 10; done