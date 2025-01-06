FROM python:3.12-slim
WORKDIR /app

COPY . .

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY infomodule /app/infomodule

ENV FLASK_APP=run.py

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0"]