# Snap packaging for `ollama`

To build the package locally, first install the prerequisites (newer versions of both snapcraft and LXD should work just fine):

```bash
sudo snap install snapcraft --classic --channel=8.x/stable
sudo snap install lxd --channel=6.1/stable
lxd init
```

Then build by issuing the following in the root of the repository:

```bash
snapcraft --verbose --use-lxd
```

## Configuration

The snap exposes Ollama's configuration through `snap set` / `snap get`. For example:

```bash
sudo snap set ollama keep-alive=10m
sudo snap get ollama keep-alive
```

Changing any configuration value automatically restarts the Ollama service.

| Snap key | Environment variable | Default | Description |
|---|---|---|---|
| `host` | [`OLLAMA_HOST`](https://github.com/ollama/ollama/blob/main/docs/faq.mdx#how-can-i-expose-ollama-on-my-network) | `127.0.0.1:11434` | Address and port the server listens on |
| `models` | [`OLLAMA_MODELS`](https://github.com/ollama/ollama/blob/main/docs/faq.mdx#how-do-i-set-them-to-a-different-location) | `$SNAP_COMMON/models` | Path to the models directory |
| `origins` | [`OLLAMA_ORIGINS`](https://github.com/ollama/ollama/blob/main/docs/faq.mdx#how-can-i-allow-additional-web-origins-to-access-ollama) | `*://localhost` | Comma-separated list of allowed origins |
| `cuda-visible-devices` | `CUDA_VISIBLE_DEVICES` | *(empty — use all)* | Comma-separated list of CUDA device IDs |
| `flash-attention` | [`OLLAMA_FLASH_ATTENTION`](https://github.com/ollama/ollama/blob/main/docs/faq.mdx#how-can-i-enable-flash-attention) | `0` | Set to `1` to enable flash attention |
| `debug` | `OLLAMA_DEBUG` | `0` | Set to `1` to enable debug logging |
| `context-length` | [`OLLAMA_CONTEXT_LENGTH`](https://github.com/ollama/ollama/blob/main/docs/faq.mdx#how-can-i-specify-the-context-window-size) | *(empty — Ollama default)* | Override the default context length |
| `load-timeout` | `OLLAMA_LOAD_TIMEOUT` | *(empty — Ollama default)* | Maximum time to load a model (e.g. `5m`) |
| `keep-alive` | [`OLLAMA_KEEP_ALIVE`](https://github.com/ollama/ollama/blob/main/docs/faq.mdx#how-do-i-keep-a-model-loaded-in-memory-or-make-it-unload-immediately) | *(empty — Ollama default of `5m`)* | How long a model stays loaded after a request (e.g. `10m`, `0` to unload immediately, `-1` to keep forever) |
| `kv-cache-type` | [`OLLAMA_KV_CACHE_TYPE`](https://github.com/ollama/ollama/blob/main/docs/faq.mdx#how-can-i-set-the-quantization-type-for-the-kv-cache) | *(empty — Ollama default of `f16`)* | K/V cache quantization type: `f16`, `q8_0`, or `q4_0` |
| `no-cloud` | [`OLLAMA_NO_CLOUD`](https://github.com/ollama/ollama/blob/main/docs/faq.mdx#how-do-i-disable-ollamas-cloud-features) | *(empty — cloud enabled)* | Set to `1` to disable Ollama's cloud features |
| `max-queue` | [`OLLAMA_MAX_QUEUE`](https://github.com/ollama/ollama/blob/main/docs/faq.mdx#how-does-ollama-handle-concurrent-requests) | *(empty — Ollama default of `512`)* | Maximum number of queued requests before rejecting |
| `max-loaded-models` | [`OLLAMA_MAX_LOADED_MODELS`](https://github.com/ollama/ollama/blob/main/docs/faq.mdx#how-does-ollama-handle-concurrent-requests) | *(empty — Ollama default)* | Maximum number of models loaded concurrently |
| `num-parallel` | [`OLLAMA_NUM_PARALLEL`](https://github.com/ollama/ollama/blob/main/docs/faq.mdx#how-does-ollama-handle-concurrent-requests) | *(empty — Ollama default of `1`)* | Maximum number of parallel requests per model |
