setup:
	docker compose pull
	docker compose build
	docker compose run inferno bundle exec rake db:migrate

generate:
	docker compose run inferno bundle exec rake au_core:generate

tests:
	docker build -t au-core-rspec-tests -f Dockerfile.test .
	docker run au-core-rspec-tests

run:
	docker compose build
	docker compose up

stop:
	docker compose stop

down:
	docker compose down
