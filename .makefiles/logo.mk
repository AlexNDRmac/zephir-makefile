.logo:
	@echo ''
	@echo ' _____              __    _		'
	@echo '/__  /  ___  ____  / /_  (_)____	'
	@echo '  / /  / _ \/ __ \/ __ \/ / ___/	'
	@echo ' / /__/  __/ /_/ / / / / / /		'
	@echo '/____/\___/ .___/_/ /_/_/_/		'
	@echo '         /_/						'
	@echo ''
	$(call print_cline,$(Cyan),$(dash_line),80)
	@echo "Makefile for Zephir lang development$(NC)"
	[ -z $(ZEPHIR_DIR) ] || $(ZEPHIR_DIR)/zephir --version
	$(call print_cline,$(Cyan),$(dash_line),80)
