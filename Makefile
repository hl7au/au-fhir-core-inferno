setup:
	docker compose pull
	docker compose build
	docker compose run inferno bundle exec rake db:migrate

run:
	docker compose build
	docker compose up

run-production:
	docker compose build
	docker compose -f docker-compose.yml -f docker-compose.production.yml up

stop:
	docker compose stop

down:
	docker compose down

generate:
	bundle exec rake au_core:generate