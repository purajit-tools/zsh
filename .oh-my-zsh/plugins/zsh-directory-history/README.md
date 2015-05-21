zsh-directory-history
=================

A per directory history for zsh.

![img](https://github.com/tymm/directory-history/wiki/demo.gif)

DESCRIPTION
-----------

zsh-directory-history is a zsh plugin giving you a history which is sensitive to the directory you are in.  
It implements forward/backward navigation as well as substring search (as [here](https://github.com/zsh-users/zsh-history-substring-search)) in a directory sensitive manner.

Behavior:  
* Commands executed in the current directory will pop up first when navigating the history or using substring search.  
* A substring unknown in the current directory, will be searched for globally (it falls back to the normal substring search behavior).

Since the plugin creates its own history, it needs some time to fill up and become useful.

INSTALL
-------

1. Install scripts

         git clone https://github.com/tymm/zsh-directory-history
         cp zsh-directory-history/dirhist /usr/bin/
         cp zsh-directory-history/dirlog /usr/bin/
         sudo chmod +x /usr/bin/dirhist /usr/bin/dirlog

  (Or just type `sudo pip install zsh-directory-history`)

2. Activate plugin by appending the following line to your _.zshrc_ file

         source /path/to/directory-history.plugin.zsh

3. Bind keyboard shortcuts in your _.zshrc_  
`directory-history-search-forward`/`directory-history-search-backward` needs to be bind for forward/backward navigation.  
`history-substring-search-up`/`history-substring-search-down` needs to be bind for substring search.  
For example:

         # Bind up/down arrow keys to navigate through your history
         bindkey '\e[A' directory-history-search-backward
         bindkey '\e[B' directory-history-search-forward

         # Bind CTRL+k and CTRL+j to substring search
         bindkey '^j' history-substring-search-up
         bindkey '^k' history-substring-search-down

For more information on how to configure substring search, take a look here: https://github.com/zsh-users/zsh-history-substring-search
