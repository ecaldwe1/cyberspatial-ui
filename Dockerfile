FROM python:2.7

ENV PYTHONUNBUFFERED 1
EXPOSE 8000

RUN mkdir /code
WORKDIR /code

# Setup Debian linux
RUN export DEBIAN_FRONTEND=noninteractive

# This section is borrowed from the official Django image but adds GDAL and others
RUN apt-get update && apt-get install -y  python-dev libgdal-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN pip install GDAL==1.10 --global-option=build_ext --global-option="-I/usr/include/gdal"

ADD requirements.txt /code/
RUN pip install -r requirements.txt

ADD . /code/

CMD python manage.py runserver 0.0.0.0:8000