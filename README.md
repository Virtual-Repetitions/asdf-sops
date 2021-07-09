<div align="center">

# asdf-sops [![Build](https://github.com/virtualrepetitions/asdf-sops/actions/workflows/build.yml/badge.svg)](https://github.com/virtualrepetitions/asdf-sops/actions/workflows/build.yml) [![Lint](https://github.com/virtualrepetitions/asdf-sops/actions/workflows/lint.yml/badge.svg)](https://github.com/virtualrepetitions/asdf-sops/actions/workflows/lint.yml)


[sops](https://github.com/mozilla/sops) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add sops
# or
asdf plugin add sops https://github.com/virtualrepetitions/asdf-sops.git
```

sops:

```shell
# Show all installable versions
asdf list-all sops

# Install specific version
asdf install sops latest

# Set a version globally (on your ~/.tool-versions file)
asdf global sops latest

# Now sops commands are available
sops --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/virtualrepetitions/asdf-sops/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Virtual Repetitions](https://github.com/virtualrepetitions/)
