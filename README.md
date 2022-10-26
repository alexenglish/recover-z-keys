# recover-z-keys
Recover private (z) address keys from Verus wallet

Dependencies are bc and xxd, which can be installed on Ubuntu/Debian based systems using: `sudo apt install bc xxd`

Invoke with the name of the wallet file you'd like to scan. Possible z-keys will be printed to the console. All helper text will be printed to STDERR, any possible keys found will be printed to STDOUT, so they can be redirected independently in your shell.

Example: `./scanforkeys.sh wallet.dat`

This is untested, but this script should also work for sapling keys for Komodo/Pirate/ZCash, and others.
