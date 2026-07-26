-- to handle long user lists
SET GLOBAL group_concat_max_len = 10000;

-- 1. Ensure databases exist
CREATE DATABASE IF NOT EXISTS TravelMapping CHARACTER SET = 'utf8mb4';
CREATE DATABASE IF NOT EXISTS TravelMappingRail CHARACTER SET = 'utf8mb4';

-- 2. Explicitly create both users (allowing connection from anywhere '%' and 'localhost')
CREATE USER IF NOT EXISTS 'travmap'@'%' IDENTIFIED BY 'travmap_password';
CREATE USER IF NOT EXISTS 'travmap'@'localhost' IDENTIFIED BY 'travmap_password';

CREATE USER IF NOT EXISTS 'travmapadmin'@'%' IDENTIFIED BY 'travmapadmin_password';
CREATE USER IF NOT EXISTS 'travmapadmin'@'localhost' IDENTIFIED BY 'travmapadmin_password';

-- 3. Read-Only Grants for 'travmap' (Web Frontends)
GRANT SELECT ON `TravelMapping`.* TO 'travmap'@'%';
GRANT SELECT ON `TravelMapping`.* TO 'travmap'@'localhost';

GRANT SELECT ON `TravelMappingRail`.* TO 'travmap'@'%';
GRANT SELECT ON `TravelMappingRail`.* TO 'travmap'@'localhost';

-- 4. Read-Write & Schema Management Grants for 'travmapadmin' (Data Loader)
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, REFERENCES ON `TravelMapping`.* TO 'travmapadmin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, REFERENCES ON `TravelMapping`.* TO 'travmapadmin'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, REFERENCES ON `TravelMappingRail`.* TO 'travmapadmin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, REFERENCES ON `TravelMappingRail`.* TO 'travmapadmin'@'localhost';

FLUSH PRIVILEGES;

