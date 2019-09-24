---
title: Dealing with Vault Leases via Accessors
published: true
description: A quick script to look up Vault tokens
tags: vault enterprise
---

After deploying Vault Enterprise, you'll need to initialize and configure it.  
Most of this configuration of Vault Enterprise happens via the Vault HTTPS API, or a wrapper of the API.

Often, when administering Vault Enterprise, after its deployment, you'll need to configure it.

However, there comes a time, especially when troubleshooting or automating anything, 
when an admin of Vault Enterprise has to manage the state within Vault itself, rather than just the configuration.  
To be more specific, performing house keeping on the platform.

Dealing with Vault's state directly is especially useful if there is a problem, 
like potential undesired access.

What if, as part of an investigation of a misbehaving application, you want to see all of the currently 
valid access tokens for Vault that were created on a specific day?

I've developed a script that will do this for you to try this out. 

Before we start looking at the leases stored in the Vault State, though, we'll set up a Vault to test on.  
You don't have to install anything, or write any configuration files.

## Download Vault

First step requires the Vault binary from HashiCorp, which can be used to run a CLI started Vault Server. Download the correct binary for you platform from the following URL:

https://www.vaultproject.io/downloads.html

Extract the binary (preferrably to a location within your $PATH) and proceed to opening a terminal prompt.

## Open Terminal
### Mac Terminal

Open your `Applications > Utilities` and double-click on `Terminal`
or
press `Command + Spacebar` to launch Spotlight, type "Terminal", and double-click on the search result.

If you have not

### Windows Terminal

Open the Run dialog by holding the `Windows + R`, then, type `powershell` and hit enter.

## Run a Vault Server

The following command will start the Vault Server in dev mode:

if in $PATH:

`vault status`

else:

`cd PATH/TO/VAULT`

`./vault status`

`./vault server -dev -dev-root-token-id=root`

Commands will no longer be able to be ran in this terminal. Open a second terminal prompt to the proceeding steps.

## Connect to Vault

Mac:
```bash
export VAULT_TOKEN=root
export VAULT_ADDR=http://127.0.0.1:8200
```
if in `$PATH`:

```bash
vault status
```

else:

```bash
cd PATH/TO/VAULT
./vault status
```

Windows:
```powershell
$VAULT_TOKEN='root'
$VAULT_ADDR='http://127.0.0.1:8200'
```
if in `$env:PATH`:

```powershell
vault status
```

else:

```powershell
cd PATH/TO/VAULT
./vault status
```

The last command, the one with `status`, should show the status of your Vault, and show that you can connect to it.

## Download the script

`git clone https://github.com/v6/delete_old_tokens`
`cd delete_old_tokens`

## Run the script

_(This part might not work on Windows, but please don't let me stop you from converting the code to PowerShell or the like.)_

`./list_accessor_issue_time.sh | grep 2019-09-13`

If you wanted to search for a different day, say, September 20, 2019, you would run the following, instead:

`./list_accessor_issue_time.sh | grep 2019-09-20`
