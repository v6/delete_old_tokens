---
title: Dealing with Vault Leases via Accessors
published: true
description: A quick script to look up Vault tokens
tags: vault enterprise
---

After deploying Vault Enterprise, you'll need to initialize and configure it. Most of this configuration of Vault Enterprise happens via its API.

Even beyond just configuration of Vault, there come times when an admin of Vault Enterprise has to manage the state within Vault, itself. 

You'll need to deal with Vault's state directly when testing automation or troubleshooting a problem, like potential undesired access or application misbehavior.

What if you want to, as part of an investigation, you want to see all of the currently valid access tokens that were created on a specific day?

I'll show you a script that will do this for you. Before we do that, though, we'll set up a Vault to test on. You don't have to install anything, or write any configuration files.

## Download Vault

We'll download the binary for HashiCorp Vault, because we can use it to run an easy Vault server:

https://www.vaultproject.io/downloads.html

After you have downloaded and extracted the binary file, open a Terminal window.

### If You're on a Mac, Open a Bash Terminal

Open your Applications folder, then Utilities and double-click on Terminal, or press Command + spacebar to launch Spotlight, then type "Terminal", and double-click on the search result. You'll see a small window with a white background open o your desktop.

### If you're on a Windows OS, Open a Shell Terminal

Open the Run dialog by holding the `Windows` key, and pressing R once. Then, enter `cmd`. When you press the `Enter` key, after entering `cmd`, you will see a black window with white text.

In your shell terminal that you just opened, use the `cd` command, along with the `dir` or `ls` commands, to navigate to where you downloaded Vault.


## Run a Vault Server

Enter the following in the terminal when you have navigated your terminal to the folder in which you have downloaded and extracted Vault:

`./vault server -dev -dev-root-token-id=root`

You should see some output, from Vault, but you will not be able to enter more commands in this terminal. 

To keep entering more commands, open another terminal, and navigate to the same folder in which you had downloaded and extracted Vault.

## Connect to Vault

Mac: `export VAULT_TOKEN=root`
`export VAULT_ADDR=http://127.0.0.1:8200`
`./vault status`

The last command, the one with `status`, should show the status of your Vault. That shows that you can connect to it. 

## Download the script

`git clone https://github.com/v6/delete_old_tokens`
`cd delete_old_tokens`

## Run the script

_(This part might not work on Windows, but please don't let me stop you from converting the code to PowerShell or the like.)_

`./list_accessor_issue_time.sh | grep 2019-09-13`

If you wanted to search for a different day, say, September 20, 2019, you would run the following, instead: 

`./list_accessor_issue_time.sh | grep 2019-09-20`
