Dissentstack provides clean, private, algorithm/influence-proof services that help the user defend their brain from social media driven insanity:

![The proxy interfaces are clean and simple, a quality most of the sites themselves have lost.](https://files.catbox.moe/21vf9w.png)

To set up DissentStack, first, install docker and docker-compose

Then add the following entries to your system's hosts file, pointed at 127.0.0.1:

* nitter.dissent.com
* teddit.dissent.com
* bibliogram.dissent.com
* searx.dissent.com
* invidious.dissent.com
* freshrss.dissent.com

Then, pull the repository via github (git clone github.com/litter-removal/dissentstack.git) or by downloading and unpacking the repository.


In CMD, Powershell, Bash, or whichever commandline your system uses enter the directory of the downloaded/unzipped repository

enter the command docker network create "net"

enter the command docker-compose up -d

The build will take some time as DissentStack uses ~11 docker containers to run, but, once the build is complete the URLs will take you to your own locally hosted proxy services, no more relying on overloaded/blocked proxy services.

If you want to use freshrss, the database url is "freshrss-db", username freshrss password freshrss database freshrss

First: special thanks to all of the creators that made these applications, I am but a humble docker merchant.

Second: I do not endorse using any of these applications for anything illegal or unethical (provided the work is unimportant/an ethical alternative exists, sometimes you gotta do what you gotta do)

If you have some extra cash please throw a donation at these creators, most of the applications have btcpay and liberapay addresses included at the bottom of the screen
