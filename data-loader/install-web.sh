#!/bin/bash
# install-web.sh
set -e

echo "Updating web assets from /app/repos/Web..."

# 1. Update /web/highways
echo "Deploying to /web/highways..."
cd /app/repos/Web
/app/repos/Web/install-local.sh /web/highways

# 2. Update /web/rail
echo "Deploying to /web/rail..."
/app/repos/Web/install-local.sh /web/rail

echo "Web assets deployment complete!"
