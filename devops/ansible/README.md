# Ansible

Ansible is a configuration management and provisioning tool.

## Installation

The easiest way to install it is via pip

```
pip install ansible

# or update

pip install -U ansible
```
## Basics

### Concepts

- It is a must to have SSH access to every computer you want to access
- By default, ansible will connect as the current user
- Facts: state of the destination servers. They can be used afterwards to fill templates (or for any other use case)

### Inventory

Inventory is what is called in ansible the set of servers that will be managed. It is typically named "hosts"

Here lies an example

```
[label1]
192.168.1.2
192.168.1.4

[anotherlabel]
192.168.3.2

[yetanotherlabel]
127.0.0.1
```

Then, labels will be used to perform actions to all servers under them

### Run commands

This is a plain way to run commands to a set of hosts. Yet useful, it is not commonly used

Example

```
ansibe -i ./hosts label1 -m ping 
```

Example to localhost

```
ansible -i ./hosts --connection=local yetanotherlabel -m ping
```

Example asking for pass (useful for servers where we've not deployed an ssh key)

```
ansible -i ./hosts --ask-pass --ssh-extra-args='-o "PubkeyAuthentication=no"' label1 -m ping
```

### Modules

Modules are the basic operation unit in Ansible. They do thinks like install software, copy files, use templates...

They are basically the encapsulation of "what to do". We've seen "ping" module so far, and it encapsulates all the logic that holds ping command and its output

In the following example, we will run a command through module "shell", becoming root, to install nginx

```
ansible -i ./hosts remote -b --become-user=root all -m shell -a 'apt-get install nginx'
```

However, as you can see, it's only a plain shell script. Modules are much powerful. The following one does the same, but makes use of the builtin apt module

```
ansible -i ./hosts remote -b --become-user=root -m apt -a 'name=nginx state=installed update_cache=true'
```

Additionally, it's more powerful, as it is declarative (we say what we want, not how to do it)

### Playbooks

Playbooks can run multiple tasks and provide some more advanced functionality than plain commands. They are defined in yaml, and they are a way to compose multiple commands and steps into a single "recipe"

Following the last example, here we define it as a playbook:

```
---
- hosts: remote
  become: yes
  become_user: root
  tasks:
   - name: Install Nginx
     apt:
       name: nginx
       state: installed
       update_cache: true
```

And to run it:

```
ansible-playbook -i ./hosts nginxinstall.yml
```

As you can see, you define a list of Tasks (in this case, just 1) to be completed. Usually, it's defined the name of the module, and in the arguments, the desired state

#### Vars

In a playbook, you can define vars, to make them available to the rest of tasks

Example:

```
...
vars:
 - myvar1: /etc/conf.conf
...
myproperty: '{{ myvar1 }}'
...
```

#### Register

It's possible to register a result of a given task. You must only define "register" into a variable, and use that variable.

```
...
register: myvar
...
- debug: msg="{{ myvar.stdout }}"
...
```

### Handlers

It's a chained task. It is part of the event-driven system provided in Ansible.

In the following example, we will see the same playbook as above, with an additionally defined handler, that will start nginx

```
---
- hosts: remote
  connection: local
  become: yes
  become_user: root
  tasks:
   - name: Install Nginx
     apt:
       name: nginx
       state: installed
       update_cache: true
     notify:
      - Start Nginx

  handlers:
   - name: Start Nginx
     service:
       name: nginx
       state: started
```

### Roles

Used to organize multiple, related tasks and encapsulate data needed to accomplish those tasks. They are complementary to playbooks, and usually called from within a playbook

To create a role:

```
mkdir -p roles && cd roles
ansible-galaxy init myrole
```

The directory name "roles" is a convention.

Inside every role, there's a hierarchy of folders:

- files: files that should be copied into our servers
- handlers: handlers code (main.yml)
- meta: Role meta data, including dependencies (main.yml)
- templates: jinja2 based templates (.j2 files) that will be used in conjuntion with vars
- tasks: a list of tasks (much like the ones defined in playbooks) (main.yml)
- vars: where all variables lie (main.yml)

To run a role from a playbook, just add

```
roles:
 - myrole
```

### Ansible Vault

Encrypt any yaml file (typically vars files)

To create a file with vault:

```
ansible-vault create vars/main.yml
```

To edit:

```
EDITOR=vim ansible-vault edit vars/main.yml
```

### Parameters

Here lies a useful (although not comprehensive) list of parameters:

- -i: input hosts file
- --connection=local: run commands locally instead of connecting by ssh
- -b: become, tell ansible to become another user when runnin the command
- --become-user=root: run the following commands as user "root"
- -a: pass any arguments to the module 
- -m: module to be called
- --ask-vault-pass: prompt with vault pass (only useful if we have files encrypted with vault)
