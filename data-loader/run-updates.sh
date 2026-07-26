#!/bin/bash
set -e

# 1. Compile C++ siteupdate binaries
echo "Compiling C++ siteupdate binaries..."
cd /app/DataProcessing/siteupdate/cplusplus
make siteupdate siteupdateST

# 2. Wait for MySQL to become ready
echo "Waiting for MySQL database host (db)..."
until mysqladmin ping -h"db" -u"travmap" -p"travmap_password" --silent; do
    sleep 2
done

# 3. Create initial databases
echo "Ensuring MySQL databases exist..."
mysql -h"db" -u"travmapadmin" -p"travmapadmin_password" -e "
    CREATE DATABASE IF NOT EXISTS TravelMapping;
    CREATE DATABASE IF NOT EXISTS TravelMappingRail;
"

# 4. TMHighways Update
echo "Running siteupdate for TMHighways..."
cd /app/DataProcessing/siteupdate

./siteupdate.sh \
  --tmbasedir /app \
  --webdir /web/highways \
  --nopull \
  --nodbcopy \
  --nographs \
  --numthreads 4

# 5. Optional OSF Dataset Import (for HDX)
if [ "$DOWNLOAD_OSF_DATA" = "true" ] && [ -d "/app/osf_data" ]; then
    echo "Ingesting optional OSF SQL files into TravelMapping DB..."
    for sql_file in /app/osf_data/*.sql; do
        [ -e "$sql_file" ] || continue
        echo "Importing $sql_file..."
        mysql --defaults-group-suffix=tmapadmin TravelMapping < "$sql_file"
    done
fi

# 6. TMRail Update
echo "Running siteupdate for TMRail..."
./siteupdate.sh \
  --rail \
  --tmbasedir /app \
  --webdir /web/rail \
  --nopull \
  --nodbcopy \
  --numthreads 4

echo "All Travel Mapping updates complete!"
