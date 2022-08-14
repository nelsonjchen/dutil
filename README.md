# Personal Diagnostic Image

Just some utilities I could reference from anywhere.

Built on GitHub Actions for linux/arm64 and linux/amd64.

## Usage Examples

### `kubectl run`

```sh
kubectl run tmp-shell --restart=Never --rm -i --tty --image ghcr.io/nelsonjchen/dutil --pod-running-timeout=5m
```

### `docker run`

```sh
docker run --rm -i --tty --image ghcr.io/nelsonjchen/dutil
```
