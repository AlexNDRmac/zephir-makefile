# Zephir Makefile

## Makefile for Zephir development

This Makefile helps Zephir developers with running all necessary tools as simple as possible. You can use this Makefile on local machine or various CI and also with PHPStorm/Clion as `Run configurations`

Zephir makefile automaticaly detects folder from which you run this makefile, so you dont need to configure paths or copying this makefile to your project. You can clone this repository to your local machine and just run `zephir.makefile`

## How it looks

```text
  _____              __    _                         __
 /__  /  ___  ____  / /_  (_)____   ____ ___  ____ _/ /__ ___
   / /  / _ \/ __ \/ __ \/ / ___/  / __ `__ \/ __ `/ //_/ __/
  / /__/  __/ /_/ / / / / / /     / / / / / / /_/ / ,< / __/
 /____/\___/ .___/_/ /_/_/_/     /_/ /_/ /_/\__,_/_/|_|\___/
          /_/

Usage:
  make -f zephir.makefile <target> <target options>

Example:
  make -f zephir.makefile memcheck

Targets:

  ---             --------------------------------------------------------------
  memcheck        Check Zephir extension for memory leaks
  ---             --------------------------------------------------------------
  help            Show this help and exit

```

## Features

- Run Valgrind [memcheck][memcheck link] for your compiled extension to check the memory leaks

## Requirements

- [Valgrind][valgrind link] 3.13 or newer
- [Graphviz dot][graphviz link] for Call graph vizualization
- [KCachegrind][kcachegrind link] for Linux or [QCachegrind][qcachegrind link] for macOS

(*) under development

## License

Zephir licensed under the MIT License. See the [LICENSE](https://github.com/phalcon/zephir/blob/master/LICENSE) file for more information.

[valgrind link]: https://valgrind.org
[memcheck link]: https://valgrind.org/docs/manual/mc-manual.html
[kcachegrind link]: https://github.com/KDE/kcachegrind
[qcachegrind link]: https://formulae.brew.sh/formula/qcachegrind
[graphviz link]: https://graphviz.gitlab.io/download
