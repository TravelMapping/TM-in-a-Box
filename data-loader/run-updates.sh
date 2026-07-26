#!/bin/bash
set -e

# 1. Deploy/Update static web assets into /web/highways and /web/rail
echo "=== Step 1: Deploying Web Assets ==="
/app/install-web.sh

# 2. Compile C++ siteupdate binaries
echo "=== Step 2: Compiling C++ siteupdate binaries ==="
cd /app/DataProcessing/siteupdate/cplusplus
make siteupdate siteupdateST

# 3. Wait for MySQL to become ready
echo "=== Step 3: Waiting for MySQL database host (db) ==="
until mysqladmin ping -h"db" -u"travmap" -p"travmap_password" --silent; do
    sleep 2
done

# 4. Create initial databases
echo "=== Step 4: Ensuring MySQL databases exist ==="
mysql -h"db" -u"travmapadmin" -p"travmapadmin_password" -e "
    CREATE DATABASE IF NOT EXISTS TravelMapping;
    CREATE DATABASE IF NOT EXISTS TravelMappingRail;
"

# 5. TMHighways Update
echo "=== Step 5: Running siteupdate for TMHighways ==="
cd /app/DataProcessing/siteupdate

./siteupdate.sh \
  --tmbasedir /app \
  --webdir /web/highways \
  --nopull \
  --nodbcopy \
  --nographs \
  --numthreads 4

# 6. Optional OSF Dataset Import (for HDX)
if [ "$DOWNLOAD_OSF_DATA" = "true" ] && [ -d "/app/osf_data" ]; then
    echo "=== Step 6: Ingesting optional OSF SQL files into TravelMapping DB ==="
    for sql_file in /app/osf_data/*.sql; do
        [ -e "$sql_file" ] || continue
        echo "Importing $sql_file..."
        mysql --defaults-group-suffix=tmapadmin TravelMapping < "$sql_file"
    done
fi

# 7. TMRail Update
echo "=== Step 7: Running siteupdate for TMRail ==="
./siteupdate.sh \
  --rail \
  --tmbasedir /app \
  --webdir /web/rail \
  --nopull \
  --nodbcopy \
  --numthreads 4

echo "All Travel Mapping updates complete!"
