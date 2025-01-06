FROM python:3.12-slim

RUN apt-get update && apt-get install -y git

WORKDIR /app


ENV GIT_USERNAME=${GIT_USERNAME}
ENV GIT_TOKEN=${GIT_TOKEN}


RUN git config --global credential.helper store

RUN git config --global url."https://${GIT_USERNAME}:${GIT_TOKEN}@github.com/".insteadOf "https://github.com/"

RUN git clone --recurse-submodules https://github.com/TheN4meless0ne/Den-store-f-rjulsoppgaven_YFF-Elias .

RUN git submodule update --init --recursive


COPY . .

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY infomodule /app/infomodule


ENV FLASK_APP=run.py

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0"]