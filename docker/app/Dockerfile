FROM amazonlinux:2

# TimeZone
RUN cp /usr/share/zoneinfo/Japan /etc/localtime

# update yum
RUN yum update -y \
    && yum upgrade -y

# install basement
RUN yum install -y \
        curl \
        git \
        libxml2 \
        libxml2-devel \
        httpd \
        mysql \
        gcc \
        vim \
        make \
        mod_ssl \
        wget \
        unzip \
        tar

# psコマンド等を叩けるようにする
RUN yum install -y yum-utils

##### PHP関連のパッケージインストール #####
# php7.3用epel, remi repositoryをインスール
RUN yum install -y \
        https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
        http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# enable to availlable PHP7.3 package
RUN yum-config-manager --enable remi-php73

# install PHP packages
RUN yum install -y \
        php73 \
        php73-php \
        php73-php-mysql \
        php73-php-php-mysqlnd \
        php73-php-bcmath \
        php73-php-ctype \
        php73-php-json \
        php73-php-mbstring \
        php73-php-openssl \
        php73-php-PDO \
        php73-php-tokenizer \
        php73-php-xml

# clean cache
RUN yum clean all

# install mariadb
RUN yum install -y mariadb

# change working directory
WORKDIR /work/surveycloud/
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# change the path of php command
RUN ln -s /usr/bin/php73 /usr/bin/php

# setting change Apache
# httpsをするのを阻止
RUN sed -ie '354,356d' /etc/httpd/conf/httpd.conf 
# httpsをするのを阻止
RUN mv /etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.confdisable 
# Changing document root
RUN sed -i -e 's#DocumentRoot "/var/www/html"#DocumentRoot "/work/surveycloud/public"#' /etc/httpd/conf/httpd.conf
RUN echo $'\n\
<Directory "/work/surveycloud/public">\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>\n\
' >> /etc/httpd/conf/httpd.conf

# setting change php.ini
RUN sed -i -e "s|^expose_php = On|expose_php = Off|g" /etc/opt/remi/php73/php.ini
RUN sed -i -e "s|^memory_limit = 128M|memory_limit = 256M|g" /etc/opt/remi/php73/php.ini
RUN sed -i -e "s|^post_max_size = 8M|post_max_size = 16M|g" /etc/opt/remi/php73/php.ini
RUN sed -i -e "s|^upload_max_filesize = 2M|upload_max_filesize = 16M|g" /etc/opt/remi/php73/php.ini
RUN sed -i -e "s|^;date.timezone =.*|date.timezone = Asia/Tokyo|g" /etc/opt/remi/php73/php.ini

# install composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

##### install nodejs, npm #####
RUN curl --silent --location https://rpm.nodesource.com/setup_12.x | bash -

RUN yum install -y nodejs

# RUN npm cache clean -f
RUN npm install -g npm@6.13.4 \
    && npm install -g n@6.2.0\
    && n 12.14.1

RUN ln -sf /usr/local/bin/node /usr/bin/node

# install vue.js
RUN npm i -g yarn && yarn global add vue-cli

# remove nodejs
RUN yum remove -y nodejs

EXPOSE 80
COPY entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh
CMD ["/etc/entrypoint.sh"]

