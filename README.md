# CommentHub

A Rails 8 application where users can write comments, mention each other by username, and receive notifications when they are mentioned. Comments are searchable in real time using Meilisearch.

## Tech stack

Rails 8.1, PostgreSQL, Meilisearch, Hotwire (Turbo + Stimulus), Tailwind CSS 4, Devise for authentication.

## Requirements

Ruby 3.x, Node.js, Docker (for PostgreSQL and Meilisearch).

## Getting started

Start the database and Meilisearch with Docker, then install dependencies and set up the database.

```bash
docker-compose up -d
bundle install
npm install
bin/rails db:create db:migrate db:seed
```

To run the app locally with asset compilation:

```bash
bin/dev
```

The app will be available at `http://localhost:3000`. Seed data creates 8 users (alice, bob, charlie, diana, evan, fiona, george, hannah) with the password `Password1!`.

## Environment variables

Create a `.env` file in the project root. This file is gitignored and should never be committed.

```
DATABASE_HOST=your_postgres_host
DATABASE_USER=your_postgres_user
DATABASE_PASSWORD=your_postgres_password
DATABASE_NAME=your_database_name

MEILISEARCH_URL=http://localhost:7700
# MEILISEARCH_API_KEY is not required in development
```


## Running the server

```bash
bundle exec rails s
```

Assets (CSS and JS) are compiled separately. If you need to rebuild them:

```bash
npm run build && npm run build:css
```

## Search index

To build the Meilisearch index from existing comments, run:

```bash
bin/rails meilisearch:import CLASS=Comment
```

## Tests

```bash
bundle exec rspec spec
```
