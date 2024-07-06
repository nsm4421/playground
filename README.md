docker compose up -d db
docker exec -it db psql -U postgres
create database chat;
create user karma with encrypted password '1221';
grant all privileges on database chat to karma;
\c chat

python3 -m venv .venv
source .venv/bin/activate
pip3 install "fastapi[all]" SQLAlchemy psycopg2-binary