### Deploying Azimuth on a publicly available remote
 - Set up account on [digital ocean](https://www.digitalocean.com/)
 - Get [droplet with shinyproxy and docker pre-installed](https://marketplace.digitalocean.com/apps/shinyproxy)
 - Start droplet and then assign a static IP to it from the dashboard
 - Log into droplet through ssh and follow the steps below

#### 1. get the latest azimuth image and build it
```
git clone https://github.com/satijalab/azimuth
cd azimuth
docker build -t azimuth .
```

#### 2. upload these files
```
/root/mtg_ref
├── config.json # contains azimuth settings
├── demo.rds    # demo file referred to within config.json and the app
├── idx.annoy   # pre-calculated reference file used by azimuth
└── ref.rds     # pre-calculated reference file used by azimuth
```

#### 3. upload/ edit these files
```
/etc/shinyproxy
├── application.yml   # point to the correct shiny apps
└── favicon.ico       # this displays on the browser tab
```

#### 4. get changes to take effect
```
sudo service shinyproxy restart
```

#### 5. enable large file uploads on the webserver
Set `client_max_body_size` to a large value (e.g. `600M`) in `/etc/nginx/sites-enabled/default` (See [this issue](https://github.com/analythium/shinyproxy-1-click/issues/7))

---

At this point, visiting the IP address of the droplet should allow the user to interact with the launch one of the apps specified within `application.yml`.