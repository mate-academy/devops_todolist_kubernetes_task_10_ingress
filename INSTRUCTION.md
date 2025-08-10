# Install all the requirements:

```bash
pip install -r requirements.txt
```

# Create cluster using `cluster.yml`:

```bash
kind create cluster --config cluster.yml
```

# Use `bootstrap.sh` to apply all the instructions (applying all manifests and installing ingress-controller):

```bash
chmod 777 bootstrap.sh
./bootstrap.sh
```

#
