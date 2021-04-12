FROM elasticsearch:1.5
ENV LANG C.UTF-8
ENV RUBY_VERSION 2.5.1
ENV PATH="/usr/share/elasticsearch/bin/elasticsearch:${PATH}"

# upgrade to debian 9
RUN apt-get upgrade && apt-get dist-upgrade
# update repositories
COPY debian_upgrade/sources.list /etc/apt/
# remove old (undavailable) backports
RUN rm /etc/apt/sources.list.d/jessie-backports.list
# add missing signatures
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 16126D3A3E5C1192 \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138 \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AA8E81B4331F7F50 \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 112695A0E562B32A \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EF0F382A1A7B6500
# install dependencies
RUN apt-get update \
    && apt-get -y install git curl libcurl4-openssl-dev libssl-dev libreadline-dev zlib1g-dev autoconf \
        bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev

# install ruby
RUN gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c ". /etc/profile.d/rvm.sh && rvm install 2.5"

RUN /bin/bash -l -c "gem install bundler:2.2.7"

ENV APP_HOME /es_ruby
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

RUN /bin/bash -l -c "rake bundle"

EXPOSE 9200
EXPOSE 9300
