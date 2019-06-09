FROM nvidia/cuda:10.1-devel-ubuntu18.04

RUN apt-get update
RUN apt-get -y install --no-install-recommends \
    python3.7 python3.7-dev python3.7-distutils \
    curl git

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

# pip & pipenv
RUN python3.7 get-pip.py
RUN rm get-pip.py
RUN pip install pipenv
COPY Pipfile ./
RUN pipenv install --system --skip-lock

ADD . /app/
WORKDIR /app

# cleanup
RUN apt-get autoremove && apt-get clean
