<div align="center">

# asdf-sops [![Build](https://github.com/virtual-repetitions/asdf-sops/actions/workflows/build.yml/badge.svg)](https://github.com/virtual-repetitions/asdf-sops/actions/workflows/build.yml) [![Lint](https://github.com/virtual-repetitions/asdf-sops/actions/workflows/lint.yml/badge.svg)](https://github.com/virtual-repetitions/asdf-sops/actions/workflows/lint.yml)

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
asdf plugin add vreps-sops https://github.com/virtualrepetitions/asdf-sops.git
```

sops:

```shell
# Show all installable versions
asdf list-all vreps-sops

# Install specific version
asdf install vreps-sops latest

# Set a version globally (on your ~/.tool-versions file)
asdf global vreps-sops latest

# Now sops commands are available
sops --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# FAQ

## Why vreps-sops instead of sops?

We call it vreps-sops to avoid a naming conflict with [this sops plugin](https://github.com/feniix/asdf-sops). This was created without realizing that plugin existed. However, I think maintaining our own asdf plugin allows for greater security around a core piece of our codebase.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/virtualrepetitions/asdf-sops/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Virtual Repetitions](https://github.com/virtualrepetitions/)
