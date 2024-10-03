compose = docker compose
inferno = run inferno

.PHONY: setup generate summary new_release tests run pull build up stop down rubocop migrate clean_generated ig_download

setup: pull build migrate

generate:
	rm -rf lib/au_core_test_kit/generated/
	$(compose) $(inferno) bundle exec rake au_core:generate
	$(compose) $(inferno) rubocop -A lib/au_core_test_kit/
	$(compose) $(inferno) ruby lib/au_core_test_kit/generator/summary_generator.rb

generate_local:
	rm -rf lib/au_core_test_kit/generated/
	bundle exec rake au_core:generate
	rubocop -A lib/au_core_test_kit/

summary: build
	$(compose) $(inferno) ruby lib/au_core_test_kit/generator/summary_generator.rb

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

migrate:
	$(compose) $(inferno) bundle exec rake db:migrate

clean_generated:
	sudo rm -rf lib/au_core_test_kit/generated/
	git checkout lib/au_core_test_kit/generated/

ig_download:
	$(compose) $(inferno) ruby lib/au_core_test_kit/generator/ig_download.rb

full_develop_restart: stop down generate setup run
