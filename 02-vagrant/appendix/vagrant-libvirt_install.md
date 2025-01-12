# Ошибки при установке плагина vagrant-libvirt
1. _bad response Not Found 404 (https://gems.hashicorp.com/specs.4.8.gz)_

```bash
 $	vagrant plugin install vagrant-libvirt
Installing the 'vagrant-libvirt' plugin. This can take a few minutes...
Vagrant failed to load a configured plugin source. This can be caused
by a variety of issues including: transient connectivity issues, proxy
filtering rejecting access to a configured plugin source, or a configured
plugin source not responding correctly. Please review the error message
below to help resolve the issue:
  bad response Not Found 404 (https://gems.hashicorp.com/specs.4.8.gz)
Source: https://gems.hashicorp.com/
```

#### Решение:
Источник: [https://discuss.hashicorp.com/t/vagrant-2-3-5-unable-to-install-plugins/53916](https://discuss.hashicorp.com/t/vagrant-2-3-5-unable-to-install-plugins/53916)

Одним из обходных путей является изменение источников для установки:

```
$ vagrant plugin install --plugin-clean-sources --plugin-source https://rubygems.org vagrant-libvirt
```

---

2. _conflicting dependencies json (= 2.7.1) and json (= 2.9.0)_

```bash
$ vagrant plugin install --plugin-clean-sources --plugin-source https://rubygems.org vagrant-libvirt
Installing the 'vagrant-libvirt' plugin. This can take a few minutes...
Vagrant failed to properly resolve required dependencies. These
errors can commonly be caused by misconfigured plugin installations
or transient network issues. The reported error is:
conflicting dependencies json (= 2.7.1) and json (= 2.9.0)
  Activated json-2.9.0
  which does not match conflicting dependency (= 2.7.1)
  Conflicting dependency chains:
    json (= 2.9.0), 2.9.0 activated
  versus:
    json (= 2.7.1)
  Gems matching json (= 2.7.1):
    json-2.7.1
```

#### Решение:
Источник: [https://gitlab.archlinux.org/archlinux/packaging/packages/vagrant/-/issues/3](https://gitlab.archlinux.org/archlinux/packaging/packages/vagrant/-/issues/3)

This isn't new though and predates this issue ; it can be worked around with

```bash
$ VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1 vagrant plugin install --plugin-clean-sources --plugin-source https://rubygems.org vagrant-libvirt
Installing the 'vagrant-libvirt' plugin. This can take a few minutes...
Fetching xml-simple-1.1.9.gem
Fetching racc-1.8.1.gem
Building native extensions. This could take a while...
Fetching nokogiri-1.18.1-x86_64-linux-gnu.gem
Fetching ruby-libvirt-0.8.4.gem
Building native extensions. This could take a while...
Fetching formatador-1.1.0.gem
Fetching fog-core-2.6.0.gem
Fetching fog-xml-0.1.5.gem
Fetching fog-json-1.2.0.gem
Fetching fog-libvirt-0.13.2.gem
Fetching diffy-3.4.3.gem
Fetching vagrant-libvirt-0.12.2.gem
Installed the plugin 'vagrant-libvirt (0.12.2)'!
```

