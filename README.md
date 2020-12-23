## Helm plugin for patch Onesait Platform loadbalancer Desployment

This plugin allows to add new module location to loadbalancer (nginx) configuration

Requirements:

- Helm v3 installed
- oc cli installed
- OpenSSL installed

### Plugin installation

```
> helm plugin install https://cicd.onesaitplatform.com/gitlab/onesait-platform/deployment/patch-lb-helmplugin.git
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
