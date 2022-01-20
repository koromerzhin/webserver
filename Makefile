include make/general/Makefile
STACK         := webserver
NETWORK       := proxywebserver serverwebserver
include make/docker/Makefile

SUPPORTED_COMMANDS := linter
SUPPORTS_MAKE_ARGS := $(findstring $(firstword $(MAKECMDGOALS)), $(SUPPORTED_COMMANDS))
ifneq "$(SUPPORTS_MAKE_ARGS)" ""
  COMMANDS_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(COMMANDS_ARGS):;@:)
endif

DOCKER_EXECMARIADB := @$(DOCKER_EXEC) $(STACK)_mariadb.1.$$(docker service ps -f 'name=$(STACK)_mariadb' $(STACK)_mariadb -q --no-trunc | head -n1)

install: node_modules ## Installation application
	@make docker create-network
	@make docker deploy

linter: ### Scripts Linter
ifeq ($(COMMANDS_ARGS),all)
	@make linter readme -i
else ifeq ($(COMMANDS_ARGS),readme)
	@npm run linter-markdown README.md
else
	@printf "${MISSING_ARGUMENTS}" linter
	@printf "${NEED}" "all" "Launch all linter"
	@printf "${NEED}" "readme" "linter README.md"
endif