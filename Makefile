ROLE_NAME            != basename $(PWD)
ANSIBLE              != which ansible
ANSIBLE_OPTIONS      := --ask-become-pass
ANSIBLE_LINT         != which ansible-lint
ANSIBLE_LINT_OPTIONS := --nocolor
HOST                 := localhost

dryrun: tasks/main.yml
	@ANSIBLE_LOCALHOST_WARNING=false \
		ANSIBLE_INVENTORY_UNPARSED_WARNING=false \
		$(ANSIBLE) \
			$(ANSIBLE_OPTIONS) \
			--check \
			--playbook-dir=../ \
			--module-name import_role \
			--args "name=$(ROLE_NAME) tasks_from=$<" $(HOST)

lint:
	@$(ANSIBLE_LINT) $(ANSIBLE_LINT_OPTIONS) .

.PHONY: \
	dryrun \
	lint

.DEFAULT_GOAL := lint
