Ansible Python Site Role
========================

[![Build Status](https://travis-ci.org/bbatsche/Ansible-Python-Site-Role.svg)](https://travis-ci.org/bbatsche/Ansible-Python-Site-Role)
[![License](https://img.shields.io/github/license/bbatsche/Ansible-Python-Site-Role.svg)](LICENSE)
[![Role Name](https://img.shields.io/ansible/role/7433.svg)](https://galaxy.ansible.com/bbatsche/Python)
[![Release Version](https://img.shields.io/github/tag/bbatsche/Ansible-Python-Site-Role.svg)](https://galaxy.ansible.com/bbatsche/Python)
[![Downloads](https://img.shields.io/ansible/role/d/7433.svg)](https://galaxy.ansible.com/bbatsche/Python)

This role will create a site in Nginx for running applications written in Python. It supports either Python 2 or 3.

Requirements
------------

This role takes advantage of Linux filesystem ACLs and a group called "web-admin" for granting access to particular directories. You can either configure those steps manually or install the [`bbatsche.Base`](https://galaxy.ansible.com/bbatsche/Base/) role.

Role Variables
--------------

- `domain` &mdash; Site domain to be created.
- `python_version` &mdash; Python version to use with this site. Default is "3"
- `env_name` &mdash; Whether this server is a "development", "production", or other type of server. Development servers will use the global Python binaries and packages, other types will use a virtualenv setup in the site directory. Default is "dev"
- `copy_wsgi` &mdash; Whether to copy a stub passenger_wsgi.py file to the site, useful for testing. Default is no
- `http_root` &mdash; Directory all site directories will be created under. Default is "/srv/http"
- `nginx_configs` &mdash; Additional config files to add to the end of the domain's `server` block. These files should be copied to `/etc/nginx/conf.d`. Default is the domain's Python configuration: `[ python-{{ domain }}.conf ]`

Dependencies
------------

This role depends on bbatsche.Nginx. You must install that role first using:

```bash
ansible-galaxy install bbatsche.Nginx
```

Example Playbook
----------------

```yml
- hosts: servers
  roles:
     - { role: bbatsche.Python, domain: my-python-site.dev }
```

License
-------

MIT

Testing
-------

Included with this role is a set of specs for testing each task individually or as a whole. To run these tests you will first need to have [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) installed. The spec files are written using [Serverspec](http://serverspec.org/) so you will need Ruby and [Bundler](http://bundler.io/).

To run the full suite of specs:

```bash
$ gem install bundler
$ bundle install
$ rake
```

The spec suite will target Ubuntu Xenial Xerus (16.04) and Bionic Bever (18.04).

To see the available rake tasks (and specs):

```bash
$ rake -T
```

These specs are **not** meant to test for idempotence. They are meant to check that the specified tasks perform their expected steps. Idempotency is tested independently via integration testing.
