setup:
	docker compose pull
	docker compose build
	docker compose run inferno bundle exec rake db:migrate

generate:
	docker compose run inferno bundle exec rake au_core:generate
	docker compose run inferno rubocop -A lib/au_core_test_kit/generated/

summary:
	docker compose build
	docker compose run inferno ruby lib/au_core_test_kit/generator/summary_generator.rb

new_release:
	docker compose build
	docker compose run inferno ruby lib/au_core_test_kit/generator/ig_download.rb
	docker compose run inferno bundle exec rake au_core:generate
	docker compose run inferno rubocop -A lib/au_core_test_kit/generated/
	docker compose run inferno ruby lib/au_core_test_kit/generator/summary_generator.rb

tests:
	docker compose run -e APP_ENV=test inferno bundle exec rspec

run:
	docker compose build
	docker compose up

stop:
	docker compose stop

down:
	docker compose down

rubocop:
	docker compose run inferno rubocop

clean_generated:
	sudo rm -rf lib/au_core_test_kit/generated/
	git checkout lib/au_core_test_kit/generated/