## How to generate

1. Initialise cue and go modules

```
cue mod init --source=git github.com/amir-ahmad/cue-k8s-modules/k8s-schema@v0
go mod init github.com/amir-ahmad/cue-k8s-modules/k8s-schema
```

2. Run generate script

```
./generate.sh
```
