#######################################

# Create CINECA HPC account in UserDB

#######################################

If you don't have a CINECA HPC account, you must register on the UserDB portal:

```
userdb.hpc.cineca.it
```

After registration, you can be added to the CN project to gain access to the resources.

---

####################################

# Access to Leonardo (LINUX guide)

####################################

## 1. Set up two-factor authentication (2FA)

Follow the instructions at:

```
https://wiki.u-gov.it/confluence/display/SCAIUS/How+to+activate+the+2FA+and+configure+the+OTP
```

## 2. Download and install the Smallstep client

Download the client:

```bash
wget https://dl.smallstep.com/cli/docs-cli-install/latest/step-cli_amd64.deb
```

Install it:

```bash
sudo dpkg -i step-cli_amd64.deb
```

Bootstrap the CA and start the SSH agent:

```bash
step ca bootstrap --ca-url=https://sshproxy.hpc.cineca.it --fingerprint 2ae1543202304d3f434bdc1a2c92eff2cd2b02110206ef06317e70c1c1735ecd

eval $(ssh-agent)
```

## 3. Authenticate to CINECA

Run:

```bash
step ssh login 'matteo.tagliazucchi2@unibo.it' --provisioner cineca-hpc
```

## 4. Access Leonardo

Enter your

