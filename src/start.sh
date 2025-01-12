#!/bin/bash

#sed -i -e 's/DBServer=localhost/DBServer=postgres/g' /etc/ecosims.ini
rm /etc/ecosims.ini
sed -i -e 's/db.serverName=127.0.0.1/db.serverName=postgres/g' /opt/ecodms/ecodmsserver/ecodms.properties
sed -i -e 's/dms.server.data=\/opt\/ecodms/dms.server.data=\/data/g' /opt/ecodms/ecodmsserver/ecodms.properties
sed -i -e 's/dms.log.level=ERROR/dms.log.level=INFO/g' /opt/ecodms/ecodmsserver/ecodms.properties