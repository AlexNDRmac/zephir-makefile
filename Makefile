.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell
Makefile: ;              # skip prerequisite discovery

# Determine this Makefile as Main file
THIS_MAKEFILE := $(word $(words $(MAKEFILE_LIST)), $(MAKEFILE_LIST))

# =================================================================
include ./.makefiles/colors.mk
include ./.makefiles/logo.mk
include ./.makefiles/functions.mk
# =================================================================

.PHONY: help

# Run make help by default
.DEFAULT_GOAL = help

# =================================================================
# Definitions:
# =================================================================

# Current Working Dir (Full path)
CWD  = $(shell cd $(shell dirname $(THIS_MAKEFILE)); pwd)
# Filter Makefile Input params to use they as target input params
ARGS = $(filter-out $@, $(MAKECMDGOALS))
# Read Zephir dir path from configuration
ZEPHIR_DIR = $(call config,ZEPHIR_PATH,$(CWD)/.env)

# =================================================================
# Makefile Targets:
# =================================================================

---: ## --------------------------------------------------------------
help: .logo ## Show this help and exit
	@echo "$(Yellow)Usage:$(NC)\n  make [command] [arguments]"
	@echo ''
	@echo "$(Yellow)Arguments:$(NC)"
	printf "  $(Green)%-15s$(NC) %s\n" "testName" "for all test runners - Filter which tests to run"
	@echo ''
	@echo "$(Yellow)Targets:$(NC)"
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(THIS_MAKEFILE) | awk 'BEGIN {FS = ":.*?## "}; \
		{printf "  $(Cyan)%-15s$(NC) %s\n", $$1, $$2}'
	@echo ''
%:
	@:
