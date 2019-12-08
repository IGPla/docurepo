# GNU Privacy Guard

This is a tool that allows us to encrypt/decrypt files

## Setup

- Edit the file below 
```
~/.gnupg/gpg-agent.conf
```
with this content
```
default-cache-ttl 1
max-cache-ttl 1
```
- Restart agent
```
echo RELOADAGENT | gpg-connect-agetn
```

## Using symmetric key

- Encrypt
```
gpg -c <myfile>
```

- Decrypt
```
gpg <myencryptedfile>
```
