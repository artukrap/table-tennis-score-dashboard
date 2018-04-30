#!/bin/sh
# Adapted from Alex Kleissner's post, Running a Phoenix 1.3 project with docker-compose
# https://medium.com/@hex337/running-a-phoenix-1-3-project-with-docker-compose-d82ab55e43cf

set -e

# Sleep to let the db server come up
sleep 5

mix deps.get
mix ecto.create
mix ecto.migrate
mix s
