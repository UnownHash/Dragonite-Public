# Dragonite-Public

## Usage
- Execute `run.sh` to download the latest release binary (use the prefered platform as argument)  
e.g. `./run.sh linux-amd64`
- Make sure jq is installed for executing `run.sh` - `sudo apt-get install jq`
- Create config.toml (`cp config.toml.example config.toml`)
- Adjust config.toml
- `pm2 start ./dragonite-linux-amd64 --name dragonite -o "/dev/null"` (change filename if using different platform)

## Update
- Execute `run.sh` to download the latest release
- Check Changelog, check config.toml for new config values available
- `pm2 restart dragonite`
