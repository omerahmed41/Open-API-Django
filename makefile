reload:
	make stop; make run

run:
	docker-compose up

run-d:
	docker-compose up -d

stop:
	docker-compose down

clean:
	docker-compose down --remove-orphans --volumes

setup:
	make build; make run-d; make makemigrations; make migrate;  make create_superuser; make logs_web

build:
	docker-compose build
	
migrate:
	docker-compose exec web python manage.py migrate

makemigrations:
	docker-compose exec web python manage.py makemigrations

create_superuser:
	docker-compose exec web python manage.py createsuperuser

test:
	docker-compose exec web python manage.py test $(path) --keepdb

logs_web:
	docker-compose logs web --tail 10 --follow

grep:
	docker-compose logs web --follow | grep -i $(keyword)