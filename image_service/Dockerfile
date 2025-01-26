FROM python:3.13-alpine

WORKDIR /service

COPY . .

RUN pip install -r requirements.txt

CMD [ "fastapi", "run", "main.py" ]