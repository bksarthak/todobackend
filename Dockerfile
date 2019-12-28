#Test Stage
FROM alpine as test 
LABEL application=todobackend

#Build base utlities
RUN apk add --no-cache bash git

#Install base dependencies
RUN apk add --no-cache gcc python3-dev libffi-dev musl-dev linux-headers mariadb-dev
RUN pip3 install wheel

COPY /src/requirements* /build/
WORKDIR /build

#build and install requirements
RUN pip3 wheel -r requirements.txt --no-cache-dir --no-input
RUN pip3 install -r requirements_test.txt -f /build --no-index --no-cache-dir 

#copy source code
COPY /src /app
WORKDIR /app

#Test entrypoint
CMD ["python3", "manage.py","test","--no-input","--settings=todobackend.setting_test"]

