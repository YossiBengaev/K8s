FROM python:3.10-buster

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt 

EXPOSE 5000

CMD ["python3", "web-app.py"] 