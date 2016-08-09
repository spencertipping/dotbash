# dotbash: all of my bash stuff, managed
I have a bunch of [useful](https://github.com/spencertipping/cd)
[bash](https://github.com/spencertipping/bashrc-tmux)
[extensions](https://github.com/spencertipping/bash-prompt), but it's a lot of
work to set them all up. This repo makes it easy:

```sh
$ git clone git://github.com/spencertipping/dotbash ~/.bash
$ echo '. ~/.bash/init' >> ~/.bashrc
```

`.bash` will clone all of the other repositories and set everything up for you.
You can pull the latest versions of everything using `dotbash pull`.

## Trying it out
```sh
$ docker run --privileged -v $PWD:/data --rm -it $(docker build -q .)
```

Or, if you're already using `.bash`:

```sh
$ dr --privileged
```

## Usage
`.bash` provides some aliases, functions, etc, that you may find useful
depending on your preferences. They're organized into layers, which you can
enable or disable by editing `.bash/layers`:

### `cd-aliases`
Sets the following aliases:

```sh
alias b='cd -'                  # previous directory
alias bb='cd -2'                # two directories ago (requires the cd module)
alias b2='cd -2'
alias b3='cd -3'
alias b4='cd -4'

alias u='cd ..'                 # up one directory
alias uu='cd ../..'
alias u2='cd ../..'
alias u3='cd ../../..'
alias u4='cd ../../../..'
alias u5='cd ../../../../..'
alias u6='cd ../../../../../..'
```

### `cd [all|extensions...]`
If active, enables [this custom cd
script](https://github.com/spencertipping/cd) with the specified extensions.
Enabled by default, and generates warnings if you don't have various FUSE
helpers installed.

I highly recommend using this; by now it's something I can't live without.

### `docker`
Defines the `dr` function for dockerized repl support, which makes it easy to
create transient images and containers. `dr` automatically connects X11 inside
the container, so graphical apps work seamlessly, and `/data` is mounted to the
current directory:

```sh
$ cat > Dockerfile <<EOF
FROM ubuntu:16.04
WORKDIR /data
CMD /bin/bash
EOF
$ dr
root@924f76e8c14d:/data# echo foo > bar
root@924f76e8c14d:/data# ^D
$ cat bar
foo
$
```

Arguments you pass to `dr` are forwarded to `docker run`. Here's how it works,
minus the details for X11:

```sh
dr() {
  docker run -v $PWD:/data $X11_STUFF --rm -it "$@" $(docker build -q .)
}
```

### `git-aliases`
Sets the following:

```sh
alias gc='git commit -am'
alias gU='git push'
alias gu='git pull'
alias gs='git status'
alias gd='git diff'
alias gL='git log'
```

### `hats`
Enables [bash hats](https://github.com/spencertipping/bash-hats), which is
utter crap so it's disabled by default.

### `history`
Runs the following:

```sh
export HISTCONTROL=ignoredups:ignorespace
alias otr='history -c; export HISTIGNORE="*"'
```

`otr` means "oops, I typed a password as a command argument" and both erases
your current session history and deactivates future history for this session.

### `lambda`
Defines a `bl` function, which will initialize [bash
lambda](https://github.com/spencertipping/bash-lambda). I don't exactly
recommend using this, but it's enabled by default.

### `ls-aliases`
Sets the following:

```sh
alias ls='ls --color=auto'
alias ll='ls -ilh'
alias la='ls -a'
alias lst='ls -tr'              # most recent files last (surprisingly useful)
alias s='ls'                    # typo insurance
```

### `nfu`
Installs a symlink to `nfu` into `~/bin`.

### `path`
**Disabled by default for security reasons.**

Adds `~/bin` and `.` to your `$PATH`, in that order. This isn't as risky as
_prepending_ `.` to your `$PATH` (which would be insane), but it makes typos
potentially very dangerous.

### `prompt`
Sets up a [double-sided bash
prompt](https://github.com/spencertipping/bash-prompt) with a series of
indicators on the right.

### `tmux`
If active, enables [tmux and xpra SSH
persistence](https://github.com/spencertipping/bashrc-tmux).
