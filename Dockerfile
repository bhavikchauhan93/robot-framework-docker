# Use official python image as the base image
FROM python:3.12

LABEL authors   Bhavik Chauhan

# Install system dependencies
RUN apt-get update && apt-get install -y wget libnss3 \
libasound2 \
libatk-bridge2.0-0 \
libgtk-4-1 \
xdg-utils

# Install chrome 131.0.6778.204
RUN wget https://storage.googleapis.com/chrome-for-testing-public/131.0.6778.204/linux64/chrome-linux64.zip -P ~/ &&\
unzip ~/chrome-linux64.zip -d ~/ &&\
mv ~/chrome-linux64 ~/google-chrome &&\
ln -s ~/google-chrome/chrome /usr/bin/google-chrome &&\
rm ~/chrome-linux64.zip

# # Install chrome driver 131.0.6778.204
RUN wget https://storage.googleapis.com/chrome-for-testing-public/131.0.6778.204/linux64/chromedriver-linux64.zip -P ~/ &&\
unzip ~/chromedriver-linux64.zip -d ~/ &&\
mv ~/chromedriver-linux64/chromedriver /usr/bin/chromedriver &&\
rm ~/chromedriver-linux64.zip

# Install necessary robotframework and selenium packages
COPY requirements.txt /opt/app/requirements.txt
RUN pip install --no-cache-dir -r /opt/app/requirements.txt

# Set the working directory in the container to /app
WORKDIR /opt/app