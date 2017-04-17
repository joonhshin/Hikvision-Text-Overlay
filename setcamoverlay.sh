#!/bin/bash

# STORES CURRENT TIME IN "UTIME" IN <HH12:MM:SS XM> FORMAT
UTIME=$(date +%r)

# PASS IN THE FOLLOWING VARS IN ORDER WHEN INVOKING THIS SHELL COMMAND:
# 1 & 2 = TEMP & HUM READINGS FROM SENSOR
# 3, 4, 5, & 6 = USER ID, PASSWORD, IP ADDRESS, AND PORT # OF THE CAMERA, RESPECTIVELY

# CREATES THE 1ST XML FILE TO BE UPLOADED
echo '<?xml version="1.0" encoding="UTF-8"?>
<TextOverlay version="1.0" xmlns="http://www.hikvision.com/ver10/XMLSchema">
<id>1</id>
<enabled>true</enabled>
<posX>1</posX>
<posY>0</posY>
<message>T:'$1'F  H:'$2'%</message>
</TextOverlay>
' > /scripts/cam5overlay.xml

# CREATES THE 2ND XML FILE TO BE UPLOADED; DISPLAY THE SENSOR DATA UPDATED TIME
echo '<?xml version="1.0" encoding="UTF-8"?>
<TextOverlay version="1.0" xmlns="http://www.hikvision.com/ver10/XMLSchema">
<id>2</id>
<enabled>true</enabled>
<posX>1</posX>
<posY>20</posY>
<message>@ '$UTIME'</message>
</TextOverlay>
' > /scripts/updatedtime.xml

# USES CURL TO UPLOAD THE TWO XML FILES
curl -T /scripts/cam5overlay.xml http://$3:$4@$5:$6/Video/inputs/channels/1/overlays/text/1 &> /dev/null
curl -T /scripts/updatedtime.xml http://$3:$4@$5:$6/Video/inputs/channels/1/overlays/text/2 &> /dev/null
