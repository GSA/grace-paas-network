hooksPath := $(git config --get core.hooksPath)

.PHONY: precommit lint_handler test_handler build_handler release_handler
default: precommit

precommit:
ifneq ($(strip $(hooksPath)),.github/hooks)
	@git config --add core.hooksPath .github/hooks
endif

lint_handler: precommit
	make -C handler lint

test_handler: precommit
	make -C handler test

build_handler: precommit
	make -C handler build

release_handler: precommit
	make -C handler release
