# Police Reservation Scraper

A web scraper for checking appointment availability at Tokyo Metropolitan Police Driver's License Centers. This scraper runs automatically via GitHub Actions.

## Features

- Checks for available slots every 15 minutes
- Sends notifications via LINE when slots are found
- Runs completely in GitHub Actions
- Includes security checks and dependency updates

## Setup

### 1. GitHub Repository Setup

1. Fork or clone this repository
2. Go to Settings > Secrets and variables > Actions
3. Add the following repository secrets:
   - `LINE_CHANNEL_TOKEN`: Your LINE Notify token
   - `LINE_USER_ID`: Your LINE user ID

### 2. Enable GitHub Actions

1. Go to Actions tab in your repository
2. Enable workflows if not already enabled
3. The scraper will automatically run every 15 minutes

## Local Development

For testing locally:

1. Copy configuration template:

   ```bash
   cp config.example.sh config.local.sh
   ```

2. Edit `config.local.sh` with your LINE credentials

3. Run the scraper:

   ```bash
   go run cmd/scraper/main.go
   ```

## Running as Background Service (macOS)

The scraper can run continuously in the background on macOS using launchd. This allows it to run even when the screen is off or after system restarts.

### Check Service Status

```bash
launchctl list | grep policeScraper
```

**Output explanation:**

- If running: Shows `PID 0 com.user.policeScraper` (PID is process ID, 0 means success)
- If stopped: Shows `- 0 com.user.policeScraper`
- If error: Shows `- ERROR_CODE com.user.policeScraper`

### Stop the Service (when you found your slot)

**Temporary stop** (will restart on next login/reboot):

```bash
launchctl stop com.user.policeScraper
```

**Permanent stop** (won't auto-start):

```bash
launchctl unload ~/Library/LaunchAgents/com.user.policeScraper.plist
```

### Start the Service

**If stopped but still loaded:**

```bash
launchctl start com.user.policeScraper
```

**If unloaded:**

```bash
launchctl load ~/Library/LaunchAgents/com.user.policeScraper.plist
```

### View Logs

**Today's scraper logs:**

```bash
tail -f ~/Documents/Projects/policeScrapper/logs/$(date +%Y-%m-%d).log
```

**Service logs:**

```bash
tail -f ~/Documents/Projects/policeScrapper/logs/launchd.out.log
tail -f ~/Documents/Projects/policeScrapper/logs/launchd.err.log
```

### Rebuild Binary (after code changes)

If you modify the code, rebuild and restart the service:

```bash
cd ~/Documents/Projects/policeScrapper
go build -o scraper cmd/scraper/main.go
launchctl unload ~/Library/LaunchAgents/com.user.policeScraper.plist
launchctl load ~/Library/LaunchAgents/com.user.policeScraper.plist
```

## Configuration

The scraper supports two modes:

- Test mode: `go run cmd/scraper/main.go test`
- Real mode: `go run cmd/scraper/main.go`

Additional flags:

- `--no-notify`: Run without sending LINE notifications
- `notify-test`: Test LINE notification setup

**Check frequency:** Every 15 minutes
**Behavior when slots found:** Sends LINE notification but continues running (doesn't auto-stop)

## Logs

- Logs are available in GitHub Actions run history
- Failed runs upload logs as artifacts for debugging
- Local runs create logs in the `logs/` directory

## Security

- No sensitive data is stored in the repository
- All credentials are stored in GitHub Secrets
- Regular security scans via GitHub Actions
- Dependabot keeps dependencies up to date

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

[Your License Here]
