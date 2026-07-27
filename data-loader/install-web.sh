#!/bin/bash
# install-web.sh
set -e

echo "Updating web assets from /app/Web..."

# 1. Update /web/highways
echo "Deploying to /web/highways..."
cd /app/Web
/app/Web/updatelocal.sh /web/highways

# create a tm.conf
echo "highways" > /web/highways/lib/tm.conf
echo "TravelMapping" >> /web/highways/lib/tm.conf
echo "travmap" >> /web/highways/lib/tm.conf
echo "travmap_password" >> /web/highways/lib/tm.conf
echo "db" >> /web/highways/lib/tm.conf
echo "HEREID" >> /web/highways/lib/tm.conf
echo "HEREAPIKEY" >> /web/highways/lib/tm.conf
echo "TKKEY" >> /web/highways/lib/tm.conf
echo "MAPBOXKEY" >> /web/highways/lib/tm.conf
echo "JAWGTOKEN" >> /web/highways/lib/tm.conf

# create motd
echo "This is an instance of Travel Mapping Highways running in a Docker environment.  The production TM server is <a href=\"https://travelmapping.net\">here</a>" > /web/highways/motd

echo "Installing custom Leaflet to /web/highways..."
cp -r /app/leaflet-1.9.4 /web/highways/

# 2. Update /web/rail
echo "Deploying to /web/rail..."
/app/Web/updatelocal.sh /web/rail

echo "Web assets deployment complete!"
