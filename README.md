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
