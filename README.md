Is a man not entitled to the sanctity of his mind?

No! Says that man in Silicon Valley. It belongs to The Algorithm!

No! Says the man in the capitol, It belongs to me!

No! Says the man behind the news desk, It belongs to our sponsors!

I chose differently. I chose, dissent.

You can change the world by changing how you interact with it.

Dissentstack provides clean, private, algorithm/influence-proof services that help the user defend their brain from social media driven insanity. It also includes a pihole instance to keep telemetry servers from monitoring your activity online.

When the FreshRSS installation included in the stack is used correctly, the user can follow their friends, favorite artists, pundits, and entertainers, only receiving updates on their activity and keeping themselves away from advertising and influence campaigns... Perhaps, even from endless scroll sessions.


Good news! No more nasty hosts file edits!

Good news(2)! Restyaboard has been added to dissentstack, privately track your own tasks and sync to your calendar with ical files.

The latest version includes two major changes: The introdution of variables in the docker-compose file, and a pihole container that will configure itself with your chosen IP address and Domain Name (this also means no more cringeworthy DISSENT DOT COM hostnames. Makes branding a lot easier.)


![The proxy interfaces are clean and simple, a quality most of the sites themselves have lost.](https://files.catbox.moe/21vf9w.png)

To set up DissentStack, first, install git, docker and docker-compose

Then, pull the repository via github (git clone github.com/litter-removal/dissentstack.git) or by downloading and unpacking the repository.


In CMD, Powershell, Bash, or whichever commandline your system uses enter the directory of the downloaded/unzipped repository

enter the command docker network create "net"

export IPADDR={your IP address, that you will access the system on}

export DOMAINNAME={example.com, the domain suffix that you will access services on}

enter the command docker-compose up -d

While the services are building, set the DNS server of any machine that will use dissenstack to the IP address of the machine running dissenstack (this includes the machine itself for local hosting, 127.0.0.1 will not work due to some complexity with DNS port assignments on redhat systems)

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
