# Rust Board

## Create Project

> Terminal

`cargo new board`

## Run Server

> Cargo.toml

    - `default-run = "board-service"`으로 설정
    
    - bin/board-service.rs를 실행

> Terminal

`cargo run`

## Test

> Terminal

`cargo test`

## API

### Article

> Create

- Endpoint : (POST) /article

`curl -X POST localhost:3000/article -H "Content-Type: application/json" -d '{"author":1, "title":"test_title1"}'`

## Remark

> Derive annotation

- Usage

    `#derive[trait1, trait2, ....]`

- 각 트래이트의 구현을 유도 (타 언어의 interface와 유사)

