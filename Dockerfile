# Начнем создавать образ с приложением. 
# За основу возьмем дистрибутив ubuntu версии 16.04

FROM ubuntu:16.04

# Для работы приложения нам нужны mongo и ruby
# Обновим кеш репозитория и установим нужные пакеты

RUN apt-get update
RUN apt-get install -y mongodb-server ruby-full ruby-dev buildessential git
RUN gem install bundler

# Скачаем наше приложение в контейнер

RUN git clone https://github.com/yagubern/app.git

# Скопируем файлы конфигурации в контейнер

COPY mongod.conf /etc/mongod.conf
COPY db_config /app/db_config
COPY start.sh /start.sh

# Нам нужно установить зависимости приложения и произвести настройку

RUN cd /app && bundle install
RUN mkdir -p /data/db
RUN chmod 0777 /start.sh

# Выполняем старт сервиса при старте контейнера

CMD ["/start.sh"]