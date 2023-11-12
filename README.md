# Dragonite-Public

## Setup
- Execute `run.sh` to download the latest release binary
- Create config.toml for dragonite: `cp dragonite/config.toml.example dragonite/config.toml`
- Create config.toml for admin: `cp admin/config.toml.example admin/config.toml`
- Adjust both config.toml

## Start
- `cd dragonite` - `pm2 start ./dragonite-linux-amd64 --name dragonite -o "/dev/null"` (change filename if using different platform)
- `cd ..`
- `cd admin` - `pm2 start ./admin-linux-amd64 --name dragonite-admin -o "/dev/null"`  (change filename if using different platform)

## Update
- Execute `run.sh` to download the latest release
- Check Changelog, check config.toml for new config values available
- `pm2 restart dragonite`
- `pm2 restart dragonite-admin`
