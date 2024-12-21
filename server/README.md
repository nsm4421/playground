# Express Server

## Database

### Postgres

#### Set Up

- Install Docker Desktop

- Get Postgres Image

  `docker pull postgres:latest`

- Run Container

  `docker run -p 5432:5432 --name dev_db -e POSTGRES_DB=dev_db -e POSTGRES_USER=karma -e POSTGRES_PASSWORD=1221 -e TZ=Asia/Seoul -d postgres:latest`

- Check Container

  `docker ps`

- Create Database

  ```
  docker exec -it 8176bfd55900 psql -U karma -d dev_db
  psql -U postgres
  create database dev_db
  ```

- Create Super User
  ```
    create role karma with login password '1221';
    alter user karma with createdb;
    alter user karma with superuser;
    grant all privileges on database dev_db to karma
  ```

#### DDL

```
CREATE TABLE ACCOUNTS (
  ID UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
  USERNAME VARCHAR(50) UNIQUE NOT NULL,
  EMAIL VARCHAR(50) UNIQUE NOT NULL,
  PASSWORD VARCHAR(255) NOT NULL,
  CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UPDATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```
