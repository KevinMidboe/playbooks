# nginx prometheus exporter

this install a prometheus exporter which it can pool and proxy nginx stub in response.

Nginx needs to be configured with the following location block:

```
    location /nginx_status {
        stub_status on;   
        access_log   off;
        allow 127.0.0.1;
        deny all;
    }
```

this requires service to scrape using host in url: `http://127.0.0.1/nginx_status` and all other hosts such as public ip or localhost will receive != 20x.
