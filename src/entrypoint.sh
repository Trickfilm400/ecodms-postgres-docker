#!/bin/bash
cd /opt/ecodms/ecodmsserver/

# update ecodms config file (setting postgres connection etc.)
bash /opt/start.sh

mkdir -p /data/workdir/
mkdir -p /data/log
mkdir -p /data/contentstore
mkdir -p /data/data
mkdir -p /data/ocr
mkdir -p /data/dupai

############## backup
BACKUP_PATH=/data/restore
if [ -f $BACKUP_PATH/restore.zip ] && [ -n $BACKUP_RESTORE ]; then
  LD_LIBRARY_PATH=/opt/ecodms/ecodmsserver/tools /opt/ecodms/ecodmsserver/tools/ecoDMSBackupConsole $BACKUP_PATH/restore.zip restorenas
  if [ $? -ne 0 ]
  then
        mv $BACKUP_PATH/restore.zip $BACKUP_PATH/restore-failed.zip
  else
        mv $BACKUP_PATH/restore.zip $BACKUP_PATH/restore-processed.zip
  fi
fi
############## backup
set -m
function sigintt() {
    echo "--- GOT SIGINT ---"
    #echo $pid
    #./DMSService -t || true
    kill -s SIGINT $pid
    echo "--- SENT SIGINT TO ECODMS SERVICE ---"
}

pid=
trap 'sigintt' SIGINT
trap 'sigintt' SIGTERM
echo "Starting ECODMS"
LD_LIBRARY_PATH=/opt/ecodms/ecodmsserver/ ./DMSService -e & pid=$!
wait
pid=
#################
n=$(ps aux | grep java | wc -l)
echo ""
while [ $n -ge 2 ]
 do
   echo "Waiting for background processes to exit..."
   sleep 1
   n=$(ps aux | grep java | wc -l)
 done
echo "done. exit."

