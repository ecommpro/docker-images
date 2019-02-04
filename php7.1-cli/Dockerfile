FROM php:7.1-cli-alpine

RUN set -ex \
\
&& apk update \
\
&& apk add git zsh \
&& apk add $PHPIZE_DEPS \
\
&& docker-php-ext-install pdo_mysql \
&& docker-php-ext-install mysqli \
&& docker-php-ext-install bcmath \
&& docker-php-ext-install sockets \
&& docker-php-ext-install opcache \
\
&& apk add freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev \
	&& docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install gd \
	&& apk del freetype-dev libpng-dev libjpeg-turbo-dev \
\
&& apk add libmcrypt-dev \
	&& docker-php-ext-configure mcrypt --with-mcrypt \
	&& docker-php-ext-install mcrypt \
\
&& apk add icu icu-dev \
	&& docker-php-ext-install intl \
	&& apk del icu-dev \
\
&& apk add libxml2-dev \
	&& docker-php-ext-install soap \
	&& CFLAGS=-I/usr/src/php docker-php-ext-install xmlreader \
	&& CFLAGS=-I/usr/src/php docker-php-ext-install xmlwriter \
	&& apk del libxml2-dev \
\
&& apk add libxslt libxslt-dev \
	&& docker-php-ext-install xsl \
	&& apk del libxslt-dev \
\
&& pecl install xdebug && docker-php-ext-enable xdebug \
&& pecl install igbinary && docker-php-ext-enable igbinary \
&& printf "yes\nyes\n" | pecl install redis && docker-php-ext-enable redis \
\
&& apk add libmemcached zlib-dev libmemcached-dev \
	&& printf "\n" | pecl install memcached \
	&& docker-php-ext-enable memcached \
	&& apk del zlib-dev libmemcached-dev \
\
&& apk add zlib-dev \
	&& docker-php-ext-install zip \
	&& apk del zlib-dev \
\
&& (\
	mkdir -p /opt \
	&& cd /opt \
	&& git clone https://github.com/longxinH/xhprof.git \
	&& mkdir -p /usr/src \
	&& cd /usr/src \
	&& git clone https://github.com/tideways/php-xhprof-extension.git \
	&& cd php-xhprof-extension \
	&& phpize \
	&& ./configure --with-php-config=/usr/local/bin/php-config \
	&& make \
	&& make install \
	&& docker-php-ext-enable tideways_xhprof \
	) \
\
&& apk add geoip geoip-dev \
	&& pecl install geoip-1.1.1 \
	&& docker-php-ext-enable geoip \
	&& apk del geoip-dev \
\
&& apk del $PHPIZE_DEPS \
&& rm -fr /var/cache/apk/* /usr/src/* /usr/local/bin/phpdbg /usr/local/bin/php-cgi

### CLI ###

RUN mkdir -p /work /local /opt/bin /etc/zsh && chmod 777 /work /local
WORKDIR /work

RUN git clone git://github.com/robbyrussell/oh-my-zsh.git /usr/local/share/oh-my-zsh \
	&& echo "export PROMPT=\(docker\)\ \$PROMPT" >> ~/.zshrc

RUN echo $'\
export HOME=/work\n\
export PATH=$HOME/.local/bin:/opt/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\n\
export ZSH=/usr/local/share/oh-my-zsh\n\
ZSH_THEME="robbyrussell"\n\
plugins=(\n\
  git\n\
)\n\
ZDOTDIR=/local\n\
HISTFILE=${ZDOTDIR}/.zsh_history\n\
source $ZSH/oh-my-zsh.sh\n\
export PS1="[docker] $PS1"\n'\
>> /etc/zsh/zshrc

RUN echo $'\
export PS1="[docker] $PS1"\n\
export HOME=/work\n\
export PATH=$HOME/.local/bin:/opt/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\n'\
>> /etc/profile

RUN [[ ! -f "/opt/bin/composer" ]] && curl -o /opt/bin/composer https://getcomposer.org/composer.phar && chmod +x /opt/bin/composer
RUN [[ ! -f "/opt/bin/n98-magerun.phar" ]] && curl -o /opt/bin/n98-magerun https://files.magerun.net/n98-magerun.phar && chmod +x /opt/bin/n98-magerun
RUN [[ ! -f "/opt/bin/n98-magerun2.phar" ]] && curl -o /opt/bin/n98-magerun2 https://files.magerun.net/n98-magerun2.phar && chmod +x /opt/bin/n98-magerun2
RUN [[ ! -f "/opt/bin/wp" ]] && curl -o /opt/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x /opt/bin/wp

ENTRYPOINT /bin/zsh