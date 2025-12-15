# Setup SSH Forwarding

## 1. Create a public key

If you don't already have an SSH key, generate one with:

```bash
ssh-keygen -t ed25519 -C "mtagliaz@login.leonardo.cineca.it"
```

## 2. Copy the public key to Leonardo

1. Log in to Leonardo.
2. Copy your public key into `~/.ssh/authorized_keys`:

```bash
echo "la_tua_chiave_pubblica_incollata_qui" >> ~/.ssh/authorized_keys
```

## 3. Configure SSH

Edit (or create) `~/.ssh/config` on your local machine and add the following (modify the username if needed):

```ssh
Host *
    ServerAliveInterval 240

Host login.leonardo.cineca.it
    HostName login01-ext.leonardo.cineca.it
    User mtagliaz
    ServerAliveInterval 60

Host lrdn*
    User mtagliaz
    ProxyJump login.leonardo.cineca.it
    ForwardAgent yes
```

---

# Running JupyterLab on Leonardo

## JupyterLab on a login node

Run the following command from your local machine:

```bash
ssh -L 8888:localhost:8888 mtagliaz@login.leonardo.cineca.it "jupyter-lab --no-browser --port=8888"
```

Then copy and paste into a browser on your local machine (or JupyterLab Desktop) the URL:

```
http://localhost:8888/lab?token=...
```

---

## JupyterLab on a computing node

1. Open a shell and log in to Leonardo.

2. Reserve a computing node, for example:

```bash
srun -A CNHPC_1478660_0 -N 1 -p dcgp_usr_prod --qos=dcgp_qos_dbg --ntasks-per-node=1 -c 8 --mem=12000 --pty /bin/bash
```

3. Take note of the allocated computing node. If it is, for example, `4194`, start JupyterLab with:

```bash
ssh -L 8888:localhost:8888 lrdn4194 "jupyter-lab --no-browser --port=8888"
```

Then copy and paste into a browser on your local machine (or JupyterLab Desktop) the URL:

```
http://localhost:8888/lab?token=...
```

