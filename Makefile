

build:
	docker build -t livox-ros-driver .

run: build
	docker compose up -d

stop:
	docker compose down