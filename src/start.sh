#!/bin/bash

# OLD config file which is not used, therefore deleting it if present (should be deleted during image build)
#sed -i -e "s/DBServer=localhost/DBServer=postgres/g" /etc/ecosims.ini
if [ -f /etc/ecosims.ini ]; then
  rm /etc/ecosims.ini
fi
sed -i -e "s/db.serverName=.*/db.serverName=$ECODMS_POSTGRES_HOST/g" /opt/ecodms/ecodmsserver/ecodms.properties
sed -i -e "s/db.portNumber=.*/db.portNumber=$ECODMS_POSTGRES_PORT/g" /opt/ecodms/ecodmsserver/ecodms.properties
sed -i -e "s/db.databaseName=.*/db.databaseName=$ECODMS_POSTGRES_DATABASE/g" /opt/ecodms/ecodmsserver/ecodms.properties
sed -i -e "s/db.user=.*/db.user=$ECODMS_POSTGRES_USERNAME/g" /opt/ecodms/ecodmsserver/ecodms.properties
sed -i -e "s/db.password=.*/db.password=$ECODMS_POSTGRES_PASSWORD/g" /opt/ecodms/ecodmsserver/ecodms.properties
sed -i -e "s/dms.server.data=\/opt\/ecodms/dms.server.data=\/data/g" /opt/ecodms/ecodmsserver/ecodms.properties
sed -i -e "s/dms.log.level=.*/dms.log.level=$ECODMS_LOGLEVEL/g" /opt/ecodms/ecodmsserver/ecodms.properties
# only needed for debugging:
# cat /opt/ecodms/ecodmsserver/ecodms.properties