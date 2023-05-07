FROM ubuntu

RUN apt update 
RUN apt -y install ruby-dev build-essential
RUN gem install bundler jekyll

RUN mkdir /app
COPY ./start-script.sh /app

WORKDIR /app
EXPOSE 4000

ARG MY_GITHUB_SECRET
ENV MY_GITHUB_SECRET=$MY_GITHUB_SECRET

CMD  ./start-script.sh