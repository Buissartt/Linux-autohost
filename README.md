<p align="center">
  <img width="100%" src="https://github.com/Buissartt/Linux-autohost/blob/main/assets/linux-autohost-background.png?raw=true" />
</p>

# Overview
**Linux-autohost** is a really small Bash script which automates the configuration of a new local web site on Debian distributions or WSL based on Debian distributions.

# Installation
Using **Git** command line, you can simply cloning this repository by typing :
```bash
git clone https://github.com/Buissartt/Linux-autohost.git
```

Another method is to retrieve the latest script release from the [release](https://github.com/Buissartt/Linux-autohost/releases/latest) section.

# Usage
First of all, to make it more convenient, you can create a symbolic link under the `/usr/bin` directory.
```bash
sudo ln -s path/to/repository/linux-autohost /usr/bin/linux-autohost
```

To go into more details, here is the help message which you can retrieve using the `-h` flag.
```
Usage : linux-autohost [OPTIONS]

Example :
  linux-autohost -p=/home/user/myproject -n=blog (On Linux and WSL)
  linux-autohost -p=/mnt/d/Sites/myproject -n=blog (On WSL)
  linux-autohost -r=blog (On Linux and WSL)

Options :
  -n, --name            (Required) The name of the new website you want to create.
  -p, --path            (Required) The path of the source folder that contains source files.
  -d, --docroot         (Optional) The path of the entry point directory within the project path
  -r, --remove          (Optional) Remove a configuration.
  -q, --quiet           (Optional) Quiet mode. Nothing is written to standart output.
  -D, --database        (Optional) Quiet mode. Nothing is written to standart output.
  -V, --version         (Optional) Print the script version.
  -h, --help            (Optional) Print the help message.
  ```

# Options
