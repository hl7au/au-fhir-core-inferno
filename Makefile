setup:
	docker compose pull
	docker compose build
	docker compose run inferno bundle exec rake db:migrate

generate:
	docker compose run inferno bundle exec rake au_core:generate

summary:
	docker compose build
	docker compose run inferno ruby lib/au_core_test_kit/generator/summary_generator.rb

new_release:
	docker compose build
	docker compose run inferno ruby lib/au_core_test_kit/generator/ig_download.rb
	docker compose run inferno bundle exec rake au_core:generate

tests:
	docker build -t au-core-rspec-tests .
	docker run -e APP_ENV=test au-core-rspec-tests bundle exec rspec

run:
	docker compose build
	docker compose up

stop:
	docker compose stop

down:
	docker compose down
