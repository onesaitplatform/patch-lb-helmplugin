## Helm plugin for patch Onesait Platform loadbalancer Deployment

This plugin allows to add new module location to loadbalancer (nginx) configuration

Requirements:

- Helm v3 installed
- oc cli installed
- OpenSSL installed

### Plugin installation

```
> helm plugin install https://gitlab.devops.onesait.com/onesait/platform/engine/onesait-platform/deployment/patch-lb-helmplugin.git
```

### Uninstall

```
> helm plugin uninstall addconfig
```

### List plugins

```
> helm plugin list
```

### Plugin usage:

```
> helm addconfig --module <module_name>

or

> helm addconfig --module <module_name> + install platform_chart

where module_name can take one of these values:

  - base
  - opendata
  - intelligence
  - api
  - engine
  - tools
  - things
  - log
  - im
```
