## examples

This directory contains some examples of how to use the app module to generate kubernetes manifests.

## multi-app-package

This shows a single multi directory package which can consist of multiple apps under the apps/ directory.

app_tool.cue defines a custom dump command for outputting manifests to yaml: `cue cmd dump ./apps/...`

```
multi-app-package/
├── app.cue          # Declares the `app` definition using the app module
└── app_tool.cue     # Tool to render app configs into Kubernetes YAML
├── apps/
│   └── foobar/
│       └── foobar.cue  # A sample app definition using the app module schema
```
