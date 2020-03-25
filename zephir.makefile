# ==============================================================================
# This Makefile helps to run all tools for Zephir lang development
#
# How-to:
#   1. copy `zephir.makefile` to root of your project
#   2. add `zephir.makefile` to your local or global gitignore
#   3. make -f zephir.makefile <target> <options>
#   or
#   Run this makefile with PHPStorm "Run/Debug configurations":
#   - PHPStorm -> Run -> Edit Configurations...
#   - Add new configurations -> Makefile
#   In configuration window, ensure next config
#       - Name: Enter tool display name (ex.: Memcheck with Valgrind)
#       - Makefile: -> Browse full path to `zephir.makefile`
#       - Targets: -> type the name of `zephir.makefile` target (ex.: memcheck)
#       - Working directory: -> Browse full path to your current project
#       - Save and Run (Choose your newly configured "Run task" and press "RUN")
# ==============================================================================

.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell

# http://patorjk.com/software/taag/#p=display&f=Slant&t=Zephir%20make
define LOGO

  _____              __    _                         __
 /__  /  ___  ____  / /_  (_)____   ____ ___  ____ _/ /__ ___
   / /  / _ \/ __ \/ __ \/ / ___/  / __ `__ \/ __ `/ //_/ __/
  / /__/  __/ /_/ / / / / / /     / / / / / / /_/ / ,< / __/
 /____/\___/ .___/_/ /_/_/_/     /_/ /_/ /_/\__,_/_/|_|\___/
          /_/

endef

SHELL := /bin/bash

# Run this makefile help by default
.DEFAULT_GOAL = help

# Determine this Makefile as Main file
THIS_MAKEFILE := $(word $(words $(MAKEFILE_LIST)), $(MAKEFILE_LIST))
ARGS := $(filter-out $@, $(MAKECMDGOALS))
# Current Working Dir of Makefile (Full path)
CWD := $(shell cd $(shell dirname $(THIS_MAKEFILE)); pwd)
# Project dir (always current dir from which runs this makefile)
PROJECT_DIR := $(CURDIR)

## Zephir lang project specific path
ZEPHIR_EXT := $(PROJECT_DIR)/ext/modules/test.so
ZEPHIR_PHPUNIT := $(PROJECT_DIR)/vendor/bin/simple-phpunit

TEST_SUITE  = Extension_Php72
ifeq ($(shell test "$(shell php-config --vernum 2>/dev/null)" -lt "70200"; echo $$?),0)
TEST_SUITE=Extension_Php70
endif

.PHONY: help memcheck
---: ## --------------------------------------------------------------
memcheck: ## Check Zephir extension for memory leaks
	if test ! "$(shell valgrind --version 2>/dev/null)"; then \
		>&2 printf "Valgring does not exist. Can not check for memory leaks.\n"; \
		>&2 printf "Aborting.\n"; \
		exit 1; \
	fi

	# Correctly show the stack frames for extensions compiled as shared libraries
	export ZEND_DONT_UNLOAD_MODULES=1
	# Disable Zend memory manager before running PHP with valgrind
	export USE_ZEND_ALLOC=0
	# Do not stop testing on failures
	export PHPUNIT_DONT_EXIT=1

	valgrind \
	--read-var-info=yes \
	--fullpath-after= \
	--error-exitcode=1 \
	--track-origins=yes \
	--leak-check=full \
	--num-callers=20 \
	--run-libc-freeres=no \
	php -d extension=$(ZEPHIR_EXT) $(ZEPHIR_PHPUNIT) --no-coverage --testsuite "$(TEST_SUITE)"

---: ## --------------------------------------------------------------
help: ## Show this help and exit
	echo "$${LOGO}"
	echo "Usage:"
	echo "  make -f $(THIS_MAKEFILE) <target> <target options>"
	echo ''
	echo "Example:"
	echo "  make -f $(THIS_MAKEFILE) memcheck"
	echo ''
	echo "Targets:"
	echo ''
	grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(THIS_MAKEFILE) | awk 'BEGIN {FS = ":.*?## "}; \
		{printf "  %-15s %s\n", $$1, $$2}'
	echo ''
%:
	@:
