# Travel Mapping Docker Environment

This repository orchestrates the Travel Mapping infrastructure for TMHighways, TMRail, and HDX web servers using Docker Compose.

## Quick Start

1. Clone all required TravelMapping repositories locally into `./repos/`:
   ```bash
   ./setup.sh
   ```

2. Build and start the containers:
   ```bash
   docker compose up --build
   ```

## Web Servers

- **TMHighways**: http://localhost:8080
- **TMRail**: http://localhost:8081
- **HDX**: http://localhost:8082

## Testing Data Updates (`datacheck.sh`)

To run a data check against local edits in your `repos/` directories:
```bash
docker compose run --rm data-loader /app/DataProcessing/siteupdate/datacheck.sh
```

## Re-ingesting Data

To re-compile `siteupdate` and re-populate the MySQL databases after data changes:
```bash
docker compose run --rm data-loader
```
