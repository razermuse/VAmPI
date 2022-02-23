FROM python:3.7-alpine

RUN mkdir /vampi
RUN apk --update add bash nano g++ gcc make autoconf autotools build-essential

ENV vulnerable=1
ENV tokentimetolive=60

COPY . /vampi
WORKDIR /vampi

RUN pip3 install -r requirements.txt

ENTRYPOINT ["python"]
CMD ["app.py"]
