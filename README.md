# Dragonite-Public

[Unown# docs](https://unownhash.com/docs/dragonite)

## Setup
- Execute `run.sh` to download the latest release binary
- Create `config.toml` for dragonite: `cp dragonite/config.toml.example dragonite/config.toml`
- Create `config.toml` for admin: `cp admin/config.toml.example admin/config.toml`
- Be sure to setup a database
- Adjust both config.toml

## Start
- `cd dragonite` - `pm2 start ./dragonite-linux-amd64 --name dragonite -o "/dev/null"` (change filename if using different platform)
- `cd ..`
- `cd admin` - `pm2 start ./admin-linux-amd64 --name dragonite-admin`  (change filename if using different platform)
- Dragonite itself stores logs into file `dragonite/logs/dragonite.log` by default (logs are rotated),  
if you want to use pm2 logs pls adapt config and pm2 command.

## Update
- Execute `run.sh` to download the latest release
- Check Changelog, check config.toml for new config values available
- `pm2 restart dragonite`
- `pm2 restart dragonite-admin`
