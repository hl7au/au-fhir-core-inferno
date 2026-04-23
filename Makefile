MODE ?= default
ifeq ($(MODE), default)
compose = docker compose
else ifeq ($(MODE), aidbox)
compose = docker compose -f compose.aidbox.yaml
endif

inferno = run inferno
ber = bundle exec rake
gen = au_core:generate
kit_path = lib/au_core_test_kit/
sum_script = $(kit_path)generator/summary_generator.rb
generated_v2_path = $(kit_path)generated/v2.0.0/

.PHONY: setup generate summary new_release tests run pull build up stop down rubocop migrate clean_generated ig_download

setup: pull build migrate

generate:
	rm -rf $(generated_v2_path)
	$(compose) $(inferno) $(ber) $(gen)
	$(compose) $(inferno) rubocop -A $(kit_path)
	$(compose) $(inferno) ruby $(sum_script)

generate_local:
	rm -rf $(generated_v2_path)
	$(ber) $(gen)
	rubocop -A $(kit_path)

summary: build
	$(compose) $(inferno) ruby $(sum_script)

new_release: build ig_download generate summary

tests:
	$(compose) run -e APP_ENV=test inferno bundle exec rspec

run: build up

pull:
	$(compose) pull

build:
	$(compose) build

up:
	$(compose) up

stop:
	$(compose) stop

down:
	$(compose) down

rubocop:
	$(compose) $(inferno) rubocop

rubocop-fix:
	$(compose) $(inferno) rubocop -A

migrate:
	$(compose) $(inferno) $(ber) db:migrate

clean_generated:
	rm -rf $(generated_v2_path)
	git restore --source=HEAD -- $(generated_v2_path)

ig_download:
	$(compose) $(inferno) ruby lib/au_core_test_kit/generator/ig_download.rb

full_develop_restart: stop down build generate setup run
