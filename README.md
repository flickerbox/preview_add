preview_add
===========

Add preview sites.

Add preview sites for the specified host. Creates the DNS, Vhost, htpasswd file and checks the site out from revision control

Installation
------------

    $ gem install preview_add

preview_add requires a config file in /etc/preview_add, the structure should look like:

    ---
    :preview_domain: flickerbox.com
    :svn_repos: https://repos.com
    :locations:
      :htpasswd: /path/to/htpasswd/directory
      :vhosts: /path/to/vhosts/directory
      :sites_available: /path/to/sites_available/directory
    :zerigo:
      :user: zerigo_user
      :api_key: zerigo_api_key
      :zone_id: zone_id
      :cname: the cname to the preview domain