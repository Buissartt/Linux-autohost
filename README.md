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
  linux-autohost -p /home/user/myproject -n blog (On Linux and WSL)
  linux-autohost -p /mnt/d/Sites/myproject -n blog (On WSL)
  linux-autohost -r blog (On Linux and WSL)

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
  
## New site creation
Different options are available to create a new web site configuration. Two flags are required : **Name** and **Path**. Name have to provided using the `-n` flag. Then, then path. Using the `-p` flag, you can specify the path of your project on your hard drive.
> On WSL, you can access your hard drives using the `/mnt` directory.

```bash
sudo linux-autohost -n blog -p path/to/project
```

For more configuration, you can add some more flags.

### Document Root (`-d`)

By adding the `-d` flag, you can indicate the entry directory of your project. For example, many PHP projects use the `/public` directory to store the entry point of your web site. The value of this flag needs to be relative to the path you've provided using `-p` flag.

## Remove an old configuration

# Options
| Option name       | Flags             | Required                 | Description                                                                     |
|-------------------|:-----------------:|:------------------------:|---------------------------------------------------------------------------------|
| Name              | -n<br>--name      | <ul><li>- [x] </li></ul> | This flag is required while he allow you to specify the name of the new project |
| Source path       | -p<br>--path      | <ul><li>- [ ] </li></ul> | The path flag contains the path from root to your project                       |
| Document root     | -d<br>--docroot   | <ul><li>- [ ] </li></ul> | This optionnal flag allow you to modify the document root path of the project   |
| Remove            | -r<br>--remove    | <ul><li>- [ ] </li></ul> | If this flag is specified, the project will be deleted                          |
| Quiet mode        | -q<br>--quiet     | <ul><li>- [ ] </li></ul> | With quiet mode enable, nothing is written to standart output                   |
| Database creation | -D<br>--database  | <ul><li>- [ ] </li></ul> | If this flag is used, a mysql database will be created                          |
| Version           | -V<br>--version   | <ul><li>- [ ] </li></ul> | Display the current version of the script and then exit                         |
| Help              | -h<br>--help      | <ul><li>- [ ] </li></ul> | Display the help message and then exit                                          |
