# Travel Mapping Docker Environment

This repository orchestrates the Travel Mapping (TM) infrastructure for the original Highways, the Rail, and the METAL Highway Data Examiner (HDX) web servers using Docker Compose.  The resulting system will be a fully-functional version of these websites running entirely on the Docker host system.

Note: initial development of this system has focused only on TM Highways.  TM Rail and HDX support will be added at a later time.

## Use Cases

- Anyone who would like to run their own local copy of TM and/or HDX to remove the dependency on the availability of the production TM server.

- A regular TM user who would like to test and immediately have access to the maps and stats related to updates to their `.list` and/or `.rlist` files, without having to wait for the next regular site update.

- A TM user who would like to have additional list files that they do not wish to have included on the main TM site(s).

- A TM data manager who would like to test and immediately have access to changes being made to highway and/or rail data, without having to wait for the next regular site update.

- A TM developer who would like to test changes to the site update process and/or web front end without having to upload the changes to a staging server on the main TM site or having to wait for a TM administrator to install those changes.

- A METAL/HDX user who would like to create custom graphs for subsets of the highway and/or railway data that are not already created during the standard site update process.

- An HDX developer who would like to use the environment to test changes before they are ready to be committed to the main repository and installed on the production server.

## Prerequisites

The intended host system should have Docker installed, which would include WSL on Windows machines.  These instructions assume you have the ability to run the `docker` command at an appropriate command-line terminal prompt on your system.

## Setup

1. Clone this repository into a directory on the host machine.  These instructions assume this is in a directory called `travelmapping` in the user's home directory.

   ```bash
   cd ~/travelmapping
   git clone https://github.com/TravelMapping/TM-in-a-Box
   ```

2. The directory `repos` at the top level of the cloned repository (`~/travelmapping/TM-in-a-Box/repos`) will be populated with all needed repositories from the GitHub Travel Mapping organization in a subsequent step.  Users who will be testing modifications or would otherwise like to have their own copies of any repository used should clone it/them now inside the `repos` directory.

For example, a user with a GitHub account called "SomeTMUser" who has their own fork of the `UserData` repository who would like to test out changes to their list files would clone that at this time.

   ```bash
   cd ~/travelmapping/TM-in-a-Box/repos
   git clone https://github.com/SomeTMUser/UserData
   ```

3. Clone all other required TM repositories locally into `repos/`.

   ```bash
   cd ~/travelmapping/TM-in-a-Box/repos
   ./setup.sh
   ```

4. Build and start the containers.

   ```bash
   docker compose up --build
   ```
   This process will take a few minutes.
   
## Web Servers

Once the `docker compose` processes have completed, web servers are available to browsers on the host system:

- **TMHighways**: http://localhost:8080
- **TMRail**: http://localhost:8081
- **HDX**: http://localhost:8082

## Testing Data Updates (`datacheck.sh`)

To run a data check against local edits in the repositories in your `repos` directory:
   ```bash
   docker compose run --rm data-loader /app/DataProcessing/siteupdate/datacheck.sh
   ```

## Re-ingesting Data

To re-compile `siteupdate` and re-populate the MySQL databases after data changes:
   ```bash
   docker compose run --rm data-loader
   ```

## Installing changes to the web front end

To install files that have been modified in the `Web` repository for testing on the server:
   ```bash
   docker compose run --rm --entrypoint /app/install-web.sh data-loader
   ```

## Shutting down

To shut down all components:
   ```bash
   docker compose down -v
   ```
