# Dragonite-Public

[Unown# docs](https://unownhash.com/docs/dragonite)

## Setup (Non-Docker)
1. Clone repo

   ```bash
   git clone https://github.com/UnownHash/Dragonite-Public.git
   ```
   
2. Change Directory to the Repo

   ```bash
   cd Dragonite-Public
   ```

3. Execute `run.sh` to download the latest release binaries

   ```bash
   ./run.sh
   ```

4. Create and adjust `config.toml` for dragonite

   ```bash
   cp dragonite/config.toml.example dragonite/config.toml
   nano dragonite/config.toml
   ```

5. Create and adjust `config.toml` for admin

   ```bash
   cp admin/config.toml.example admin/config.toml
   nano admin/config.toml
   ```

6. Be sure to setup a database

## Start
1. Dragonite (change filename if using different platform)

   ```bash
   cd dragonite
   pm2 start ./dragonite-linux-amd64 --name dragonite -o "/dev/null"
   cd ..
   ```

2. Admin (change filename if using different platform)

   ```bash
   cd admin
   pm2 start ./admin-linux-amd64 --name dragonite-admin
   cd ..
   ```

Dragonite itself stores logs into file `dragonite/logs/dragonite.log` by default (logs are rotated),  
if you want to use pm2 logs pls adapt config and pm2 command.

## Update
- Execute `run.sh` to download the latest release
- Check Changelog, check config.toml for new config values available
- `pm2 restart dragonite`
- `pm2 restart dragonite-admin`

## Testing
- To download a testing binary execute
   ```bash
   ./run.sh -t
   ```
