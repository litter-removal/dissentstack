# Invidious

[![Build Status](https://github.com/iv-org/invidious/workflows/Invidious%20CI/badge.svg)](https://github.com/iv-org/invidious/actions) [![Translation Status](https://hosted.weblate.org/widgets/invidious/-/translations/svg-badge.svg)](https://hosted.weblate.org/engage/invidious/)

## Invidious is an alternative front-end to YouTube

## Invidious instances:

[Public Invidious instances are listed here.](https://github.com/iv-org/documentation/blob/master/Invidious-Instances.md)

## Invidious features:

- [Copylefted libre software](https://github.com/iv-org/invidious) (AGPLv3+ licensed)
- Audio-only mode (and no need to keep window open on mobile)
- Lightweight (the homepage is ~4 KB compressed)
- Tools for managing subscriptions:
  - Only show unseen videos
  - Only show latest (or latest unseen) video from each channel
  - Delivers notifications from all subscribed channels
  - Automatically redirect homepage to feed
  - Import subscriptions from YouTube
- Dark mode
- Embed support
- Set default player options (speed, quality, autoplay, loop)
- Support for Reddit comments in place of YouTube comments
- Import/Export subscriptions, watch history, preferences
- [Developer API](https://github.com/iv-org/documentation/blob/master/API.md)
- Does not use any of the official YouTube APIs
- Does not require JavaScript to play videos
- No need to create a Google account to save subscriptions
- No ads
- No CoC
- No CLA
- [Multilingual](https://hosted.weblate.org/projects/invidious/#languages) (translated into many languages)

## Donate:

Bitcoin (BTC): [bc1qfhe7rq3lqzuayzjxzyt9waz9ytrs09kla3tsgr](bitcoin:bc1qfhe7rq3lqzuayzjxzyt9waz9ytrs09kla3tsgr)

Monero (XMR): [41nMCtek197boJtiUvGnTFYMatrLEpnpkQDmUECqx5Es2uX3sTKKWVhSL76suXsG3LXqkEJBrCZBgPTwJrDp1FrZJfycGPR](monero:41nMCtek197boJtiUvGnTFYMatrLEpnpkQDmUECqx5Es2uX3sTKKWVhSL76suXsG3LXqkEJBrCZBgPTwJrDp1FrZJfycGPR)

## Screenshots:

| Player                                                                                                                  | Preferences                                                                                                             | Subscriptions                                                                                                               |
| ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| [<img src="screenshots/01_player.png?raw=true" height="140" width="280">](screenshots/01_player.png?raw=true)           | [<img src="screenshots/02_preferences.png?raw=true" height="140" width="280">](screenshots/02_preferences.png?raw=true) | [<img src="screenshots/03_subscriptions.png?raw=true" height="140" width="280">](screenshots/03_subscriptions.png?raw=true) |
| [<img src="screenshots/04_description.png?raw=true" height="140" width="280">](screenshots/04_description.png?raw=true) | [<img src="screenshots/05_preferences.png?raw=true" height="140" width="280">](screenshots/05_preferences.png?raw=true) | [<img src="screenshots/06_subscriptions.png?raw=true" height="140" width="280">](screenshots/06_subscriptions.png?raw=true) |

## Installation:

To manually compile invidious you need at least 2GB of RAM. If you have less you can setup SWAP to have a combined amount of 2 GB or use Docker instead.

After installation take a look at the [Post-install steps](#post-install-configuration).

### Automated installation:

[Invidious-Updater](https://github.com/tmiland/Invidious-Updater) is a self-contained script that can automatically install and update Invidious.

### Docker:

#### Build and start cluster:

```bash
$ docker-compose up
```

Then visit `localhost:3000` in your browser.

#### Rebuild cluster:

```bash
$ docker-compose build
```

#### Delete data and rebuild:

```bash
$ docker volume rm invidious_postgresdata
$ docker-compose build
```

### Manual installation:

### Linux:

#### Install the dependencies

```bash
# Arch Linux
$ sudo pacman -S base-devel shards crystal librsvg postgresql

# Ubuntu or Debian
# First you have to add the repository to your APT configuration. For easy setup just run in your command line:
$ curl -sSL https://dist.crystal-lang.org/apt/setup.sh | sudo bash
# That will add the signing key and the repository configuration. If you prefer to do it manually, execute the following commands:
$ curl -sL "https://keybase.io/crystal/pgp_keys.asc" | sudo apt-key add -
$ echo "deb https://dist.crystal-lang.org/apt crystal main" | sudo tee /etc/apt/sources.list.d/crystal.list
$ sudo apt-get update
$ sudo apt install crystal libssl-dev libxml2-dev libyaml-dev libgmp-dev libreadline-dev postgresql librsvg2-bin libsqlite3-dev zlib1g-dev
```

#### Add an Invidious user and clone the repository

```bash
$ useradd -m invidious
$ sudo -i -u invidious
$ git clone https://github.com/iv-org/invidious
$ exit
```

#### Set up PostgresSQL

```bash
$ sudo systemctl enable --now postgresql
$ sudo -i -u postgres
$ psql -c "CREATE USER kemal WITH PASSWORD 'kemal';" # Change 'kemal' here to a stronger password, and update `password` in config/config.yml
$ createdb -O kemal invidious
$ psql invidious kemal < /home/invidious/invidious/config/sql/channels.sql
$ psql invidious kemal < /home/invidious/invidious/config/sql/videos.sql
$ psql invidious kemal < /home/invidious/invidious/config/sql/channel_videos.sql
$ psql invidious kemal < /home/invidious/invidious/config/sql/users.sql
$ psql invidious kemal < /home/invidious/invidious/config/sql/session_ids.sql
$ psql invidious kemal < /home/invidious/invidious/config/sql/nonces.sql
$ psql invidious kemal < /home/invidious/invidious/config/sql/annotations.sql
$ psql invidious kemal < /home/invidious/invidious/config/sql/playlists.sql
$ psql invidious kemal < /home/invidious/invidious/config/sql/playlist_videos.sql
$ exit
```

#### Set up Invidious

```bash
$ sudo -i -u invidious
$ cd invidious
$ shards update && shards install
$ crystal build src/invidious.cr --release
# test compiled binary
$ ./invidious # stop with ctrl c
$ exit
```

#### Systemd service:

```bash
$ sudo cp /home/invidious/invidious/invidious.service /etc/systemd/system/invidious.service
$ sudo systemctl enable --now invidious.service
```

#### Logrotate:

```bash
$ echo "/home/invidious/invidious/invidious.log {
rotate 4
weekly
notifempty
missingok
compress
minsize 1048576
}" | sudo tee /etc/logrotate.d/invidious.logrotate
$ sudo chmod 0644 /etc/logrotate.d/invidious.logrotate
```

### MacOS:

```bash
# Install dependencies
$ brew update
$ brew install shards crystal postgres imagemagick librsvg

# Clone the repository and set up a PostgreSQL database
$ git clone https://github.com/iv-org/invidious
$ cd invidious
$ brew services start postgresql
$ psql -c "CREATE ROLE kemal WITH PASSWORD 'kemal';" # Change 'kemal' here to a stronger password, and update `password` in config/config.yml
$ createdb -O kemal invidious
$ psql invidious kemal < config/sql/channels.sql
$ psql invidious kemal < config/sql/videos.sql
$ psql invidious kemal < config/sql/channel_videos.sql
$ psql invidious kemal < config/sql/users.sql
$ psql invidious kemal < config/sql/session_ids.sql
$ psql invidious kemal < config/sql/nonces.sql
$ psql invidious kemal < config/sql/annotations.sql
$ psql invidious kemal < config/sql/privacy.sql
$ psql invidious kemal < config/sql/playlists.sql
$ psql invidious kemal < config/sql/playlist_videos.sql

# Set up Invidious
$ shards update && shards install
$ crystal build src/invidious.cr --release
```

## Post-install configuration:

Detailed configuration available in the [configuration guide](https://github.com/iv-org/documentation/blob/master/Configuration.md).

If you use a reverse proxy, you **must** configure invidious to properly serve request through it:

`https_only: true` : if your are serving your instance via https, set it to true

`domain: domain.ext`: if you are serving your instance via a domain name, set it here

`external_port: 443`: if your are serving your instance via https, set it to 443

## Update Invidious

Instructions are available in the [updating guide](https://github.com/iv-org/documentation/blob/master/Updating.md).

## Usage:

```bash
$ ./invidious -h
Usage: invidious [arguments]
    -b HOST, --bind HOST             Host to bind (defaults to 0.0.0.0)
    -p PORT, --port PORT             Port to listen for connections (defaults to 3000)
    -s, --ssl                        Enables SSL
    --ssl-key-file FILE              SSL key file
    --ssl-cert-file FILE             SSL certificate file
    -h, --help                       Shows this help
    -c THREADS, --channel-threads=THREADS
                                     Number of threads for refreshing channels (default: 1)
    -f THREADS, --feed-threads=THREADS
                                     Number of threads for refreshing feeds (default: 1)
    -o OUTPUT, --output=OUTPUT       Redirect output (default: STDOUT)
    -v, --version                    Print version
```

Or for development:

```bash
$ curl -fsSLo- https://raw.githubusercontent.com/samueleaton/sentry/master/install.cr | crystal eval
$ ./sentry
🤖  Your SentryBot is vigilant. beep-boop...
```

## Documentation

The [documentation](https://github.com/iv-org/documentation) can be found in its own repository.

## Extensions

[Extensions](https://github.com/iv-org/documentation/blob/master/Extensions.md) can be found in the wiki, as well as documentation for integrating it into other projects.

## Made with Invidious

- [FreeTube](https://github.com/FreeTubeApp/FreeTube): A libre software YouTube app for privacy.
- [CloudTube](https://cadence.moe/cloudtube/subscriptions): A JavaScript-rich alternate YouTube player
- [PeerTubeify](https://gitlab.com/Cha_deL/peertubeify): On YouTube, displays a link to the same video on PeerTube, if it exists.
- [MusicPiped](https://github.com/deep-gaurav/MusicPiped): A material design music player that streams music from YouTube.
- [LapisTube](https://github.com/blubbll/lapis-tube): A fancy and advanced (experimental) YouTube front-end. Combined streams & custom YT features.
- [HoloPlay](https://github.com/stephane-r/HoloPlay): Funny Android application connecting on Invidious API's with search, playlists and favoris.

## Contributing

1.  Fork it ( https://github.com/iv-org/invidious/fork )
2.  Create your feature branch (git checkout -b my-new-feature)
3.  Commit your changes (git commit -am 'Add some feature')
4.  Push to the branch (git push origin my-new-feature)
5.  Create a new pull request

#### Translation

- Log in with an account you have elsewhere, or register an account and start translating at [Hosted Weblate](https://hosted.weblate.org/engage/invidious/).

## Contact

Feel free to join our [Matrix room](https://matrix.to/#/#invidious:matrix.org), or #invidious on freenode. Both platforms are bridged together.

## Liability

We take no responsibility for the use of our tool, or external instances provided by third parties. We strongly recommend you abide by the valid official regulations in your country. Furthermore, we refuse liability for any inappropriate use of Invidious, such as illegal downloading. This tool is provided to you in the spirit of free, open software.

You may view the LICENSE in which this software is provided to you [here](./LICENSE).

>   16. Limitation of Liability.
>
> IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR CONVEYS
THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY
GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE
USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF
DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD
PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS),
EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
