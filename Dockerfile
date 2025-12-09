FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY sample-app/ .

EXPOSE 5000

ENV FLASK_APP=app.py
ENV ENVIRONMENT=development

CMD ["python", "app.py"]
