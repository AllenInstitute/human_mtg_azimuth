# Modified from https://github.com/sylhare/docker-stats-graph
function dockerstats()
{
while true
#runtime="30 minutes"
#endtime=$(date -ud "$runtime" +%s)
#while [[ $(date -u +%s) -le ${endtime} ]]
    do docker stats --no-stream --format "table {{.Name}};{{.CPUPerc}};{{.MemPerc}};{{.MemUsage}};{{.NetIO}};{{.BlockIO}};{{.PIDs}}" > TEMPFILE
    tail -n +2 TEMPFILE | awk -v date=";$(date +%T)" '{print $0, date}' >> $1
    sleep 1
done
}