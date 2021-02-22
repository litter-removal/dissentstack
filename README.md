Good news! No more nasty hosts file edits!

The latest version includes two major changes: The introdution of variables in the docker-compose file, and a pihole container that will configure itself with your chosen IP address and Domain Name (this also means no more cringeworthy DISSENT DOT COM hostnames. Makes branding a lot easier.)

Dissentstack provides clean, private, algorithm/influence-proof services that help the user defend their brain from social media driven insanity:

![The proxy interfaces are clean and simple, a quality most of the sites themselves have lost.](https://files.catbox.moe/21vf9w.png)

To set up DissentStack, first, install git, docker and docker-compose

Then, pull the repository via github (git clone github.com/litter-removal/dissentstack.git) or by downloading and unpacking the repository.


In CMD, Powershell, Bash, or whichever commandline your system uses enter the directory of the downloaded/unzipped repository

enter the command docker network create "net"

export IPADDR={your IP address, that you will access the system on}

export DOMAINNAME={example.com, the domain suffix that you will access services on}

enter the command docker-compose up -d

The build will take some time as DissentStack uses ~11 docker containers to run, but, once the build is complete the URLs will take you to your own locally hosted proxy services, no more relying on overloaded/blocked proxy services.

Services will be availabe at:

nitter.{yourdomain}.com
invidious.{yourdomain}.com
bibliogram.{yourdomain}.com
freshrss.{yourdomain}.com
pihole.{yourdomain}.com
teddit.{yourdomain}.com

If you want to use freshrss, the database url is "freshrss-db", username freshrss password freshrss database freshrss

First: special thanks to all of the creators that made these applications, I am but a humble docker merchant.

Second: I do not endorse using any of these applications for anything illegal or unethical (provided the work is unimportant/an ethical alternative exists, sometimes you gotta do what you gotta do)

If you have some extra cash please throw a donation at these creators, most of the applications have btcpay and liberapay addresses included at the bottom of the screen
