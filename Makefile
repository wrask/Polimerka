include .env
export

up: ## Start up local environment   
	@echo "starting ..."
	docker-compose up -d

down: ## Stop up local environment
	@echo "stopping ..."
	docker-compose down

build: ## Build and start up local environment
	@echo "building ..."
	docker-compose up --build -d

mc: ## Make a controller
	@echo "creating a controller ..."
	docker exec $$APP_CONTAINER php app/artisan make:controller $(controller_name)

mm: ## Make a model
	@echo "creating a model ..."
	docker exec $$APP_CONTAINER php app/artisan make:model $(model_name)

tests: ## Start feature tests
	@echo "running feature tests ..."
	docker exec app /var/www/app/vendor/phpunit/phpunit/phpunit /var/www/app/tests/Feature

migrate: ## Start db migrations
	@echo "running db migrations ..."
	docker exec $$APP_CONTAINER app/artisan migrate

me: ## Enable maintenance mode
	@echo "enabling the maintenance mode ..."
	docker exec $$APP_CONTAINER app/artisan down
##	docker exec app app/artisan down --secret="1630542a-246b-4b66-afa1-dd72a4c43515"

md: ## Disable maintenance mode

	@echo "disabling the maintenance mode ..."
	docker exec $$APP_CONTAINER app/artisan up

composer: ## Composer
	docker exec $$APP_CONTAINER composer $(composer_command)

help:
	@grep -E '^[a-zA-Z_0-9-]+:.*?## .*$$' makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

