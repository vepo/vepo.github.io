FROM ubuntu

RUN apt-get update
RUN apt-get install -y ruby-full build-essential zlib1g-dev python3
ENV GEM_HOME="$HOME/gems"
ENV PATH="$HOME/gems/bin:$PATH"
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
RUN gem install jekyll bundler
WORKDIR /site
ADD Gemfile /site/
ADD Gemfile.lock /site/
RUN bundle install

CMD ["bundle", "exec", "jekyll", "serve", "--trace"]