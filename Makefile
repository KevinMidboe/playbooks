.PHONY: add help
.ONESHELL:

FILE="host_vars/$(name).yml"

add: check_name add_file add_host add_ports add_motd

check_name:
ifndef name
	$(error Parameter missing, view 'make help')
endif

help:
	@echo "Add ansible host with variables:"
	@echo "  name		TEXT"
	@echo "  host		TEXT"
	@echo "  type		vm/lxc"
	@echo "* ports		NUMBER[,NUMBER]"
	@echo "* motd		TEXT"
	@echo "* = optional"
	@echo ""
	@echo 'Example: make add name=web type=vm host=ambrosia ports=80,443 motd="Webpage for displaying"'

add_file:
	@echo "Creating file:\n  $(FILE)"
	@touch $(FILE)
	@echo "---" > $(FILE)

add_host:
	@echo "Adding host:\n  $(name)"
	@echo "hostname: $(name)" >> $(FILE)

add_ports:
ifdef ports
	@echo "Adding firewall ports:\n  $(shell echo $(ports) | sed -r 's/,/ /g')"
	@echo "custom_firewall_ports:" >> $(FILE)
	
	@for i in $(shell echo $(ports) | sed -r 's/,/ /g') ; do \
		echo "  - $$i" >> $(FILE) ; \
	done

endif

add_motd:
ifdef motd
	@echo "Adding motd message:\n  $(motd)"
	@echo "motd_abstract: $(motd)" >> $(FILE)
endif



