Welcome to my dotfiles!
=======================

> Top down, chrome spinnin'.<br/>
> -- Pusha T

### `clink`
This folder holds lua scripts for use with [Clink](http://mridgers.github.io/clink/) on Windows machines.

### `shortcuts`
This folder contains some handy batch files that I use to handle common tasks, like:
  - Git configuration, when switching from work to personal Github accounts
  - `uru auto` to default to my user-specific Ruby version

### `.tmux.conf`
This file houses my tmux configuration, which is about as bare-bones as can be. There's a single setting, which fixes a pasting issue with the Vim `set clipboard=unnamed` configuration, leveraging a Homebrew joint called [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard). Though I'm sure this file will grow over time, for now I like how tiny (but powerful) it is.

Before this tmux configuration will work, however, make sure you:

`$ brew install reattach-to-user-namespace`

To ensure the package is where the file expects it to be!

### `_vimrc`
Dayum! That handsome devil is my work and personal laptop Vim configuration, for using gVim on Windows 7 (at the office) and Windows 8 (at home).

### `.vimrc`
Whaddup? That lil' guy is my home desktop Vim configuration, for using macVim on Mac OS X.

### Downloading
Don't be a dingus, use [cURL](http://curl.haxx.se/) to download the files straight away!

```
> cd directory_where_you_want_the_file
> curl -k -O raw_github_user_content_link
```

Boom!
