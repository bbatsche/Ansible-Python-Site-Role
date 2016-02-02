Ansible Python Site Role
========================

[![Build Status](https://travis-ci.org/bbatsche/Ansible-Python-Site-Role.svg?branch=master)](https://travis-ci.org/bbatsche/Ansible-Python-Site-Role)

This role will create a site in Nginx for running applications written in Python. It supports either Python 2.7 or 3.4.

Role Variables
--------------

- `domain` &mdash; Site domain to be created.
- `python_version` &mdash; Python version to use with this site. Default is "3". Other possible values are "3.4", "2", or "2.7". In general, you should probably stick to major version numbers.
- `env_name` &mdash; Whether this server is a "development", "production", or other type of server. Development servers will use the global Python binaries and packages, other types will use a virtualenv setup in the site directory. Default is "dev".
- `copy_wsgi` &mdash; Whether to copy a stub passenger_wsgi.py file to the site, useful for testing. Default is no.
- `http_root` &mdash; Directory all site directories will be created under. Default is "/srv/www".

Dependencies
------------

This role depends on bbatsche.Nginx. You must install that role first using:

```bash
ansible-galaxy install bbatsche.Nginx
```

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

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

Included with this role is a set of specs for testing each task individually or as a whole. To run these tests you will first need to have [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) installed. The spec files are written using [Serverspec](http://serverspec.org/) so you will need Ruby and [Bundler](http://bundler.io/). _**Note:** To keep things nicely encapsulated, everything is run through `rake`, including Vagrant itself. Because of this, your version of bundler must match Vagrant's version requirements. As of this writing (Vagrant version 1.8.1) that means your version of bundler must be between 1.5.2 and 1.10.6._

To run the full suite of specs:

```bash
$ gem install bundler -v 1.10.6
$ bundle install
$ rake
```

To see the available rake tasks (and specs):

```bash
$ rake -T
```

There are several rake tasks for interacting with the test environment, including:

- `rake vagrant:up` &mdash; Boot the test environment (_**Note:** This will **not** run any provisioning tasks._)
- `rake vagrant:provision` &mdash; Provision the test environment
- `rake vagrant:destroy` &mdash; Destroy the test environment
- `rake vagrant[cmd]` &mdash; Run some arbitrary Vagrant command in the test environment. For example, to log in to the test environment run: `rake vagrant[ssh]`

These specs are **not** meant to test for idempotence. They are meant to check that the specified tasks perform their expected steps. Idempotency can be tested independently as a form of integration testing.
