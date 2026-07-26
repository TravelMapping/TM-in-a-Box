#!/bin/bash
# install-web.sh
set -e

echo "Updating web assets from /app/Web..."

# 1. Update /web/highways
echo "Deploying to /web/highways...!"
cd /app/Web
/app/Web/updatelocal.sh /web/highways
echo "highways" > /web/highways/lib/tm.conf
echo "TravelMapping" >> /web/highways/lib/tm.conf
echo "travmap" >> /web/highways/lib/tm.conf
echo "travmap_password" >> /web/highways/lib/tm.conf
echo "localhost" >> /web/highways/lib/tm.conf
echo "HEREID" >> /web/highways/lib/tm.conf
echo "HEREAPIKEY" >> /web/highways/lib/tm.conf
echo "TKKEY" >> /web/highways/lib/tm.conf
echo "MAPBOXKEY" >> /web/highways/lib/tm.conf
echo "JAWGTOKEN" >> /web/highways/lib/tm.conf

# 2. Update /web/rail
echo "Deploying to /web/rail..."
/app/Web/updatelocal.sh /web/rail

echo "Web assets deployment complete!"
