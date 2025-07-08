# Backend Project

FastAPI를 사용한 서버개발

## Set Up

> 가상환경

```
uv venv   # .venv 가상환경 생성
source .venv/bin/activate
uv init . # pyproject.toml 생성
```

> app/main.py 실행

`.venv/bin/python -m app.main`

> Docker

- 백그라운드에서 컨테이너 실행하기

`docker compose up -d`

- 실행중지

`docker compose down`
