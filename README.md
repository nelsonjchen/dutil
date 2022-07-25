# Personal Diagnostic Image

Just some utilities I could reference from anywhere.

Built on GitHub Actions for ARM and x86_64.

## Usage Examples

### `kubectl run`

```sh
kubectl run tmp-shell --restart=Never --rm -i --tty --image xxxxx --pod-running-timeout=5m
```

### `docker run`

```sh
docker run --rm -i --tty --image xxxxx
```
