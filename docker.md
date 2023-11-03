# Simple Docker


## Part 1. Готовый докер
* Устанавливаем `brew install docker`
* Проверяем версию `docker --version`
* Устанавливаем docker desktop + запускаем его
* Проверяем, что работает `docker info`
* Устанавливаем `brew install nginx`

* Берем официальный докер образ с nginx и выкачиваем его при помощи `docker pull nginx`

![simple_docker](img/docker_pull.png)

* Проверяем наличие докер образа через `docker images`

![simple_docker](img/images.png)

* Запускаем докер образ через `docker run -d nginx` и проверяем, что образ запустился через `docker ps`

![simple_docker](img/run.png)

* Смотрим информацию о контейнере через `docker inspect d5e22a0cb449 (container_id)` и `docker inspect sweet_brown (IP адрес или имя) | grep Size`

![simple_docker](img/inspect.png)

![simple_docker](img/size.png)

* Останавливаем докер образ через `docker stop d5e22a0cb449 (container_id)` и проверяем, что образ остановился через `docker ps`

![simple_docker](img/stop.png)

* Запускаем докер с портами 80 и 443 в контейнере `docker run -d -p 80:80 -p 433:433 nginx`. Проверяем `docker ps`

![simple_docker](img/run433.png)

* Проверяем, что в браузере по адресу *localhost:80* доступна стартовая страница nginx

![simple_docker](img/localhost.png)

* Перезапускаем докер контейнер через `docker restart 7f391ad212d0 (container_id)`. Проверяем `docker ps`

![simple_docker](img/restart.png)


## Part 2. Операции с контейнером

* Смотрим конфигурационный файл nginx.conf внутри докер контейнера `docker exec 7f391ad212d0 (container_id) cat /etc/nginx/nginx.conf`

![simple_docker](img/exec.png)

* Создаем на локальной машине файл nginx.conf и настраиваем отдачу страницы статуса сервера nginx

![simple_docker](img/cat_conf.png)

* Смотрим ID контейнера `docker ps`и копируем созданный файл nginx.conf внутрь докер образа через команду `docker cp nginx.conf 7f391ad212d0:/etc/nginx/`

![simple_docker](img/copy_conf.png)

* Перезапускаем nginx внутри докер образа `docker exec 7f391ad212d0 nginx -s reload`

![simple_docker](img/reload.png)

* Проверяем, что по адресу localhost:80/status отдается страничка со статусом сервера nginx

![simple_docker](img/status_host.png)

* Экспортируем контейнер в файл container.tar `docker export -o container.tar 7f391ad212d0`, останавливаем контейнер `docker container stop 7f391ad212d0`

![simple_docker](img/docker_stop.png)

* Удаляем образ через `docker rmi -f nginx`

![simple_docker](img/del_c.png)

* Удаляем остановленный контейнер `docker rm 7f391ad212d0`

![simple_docker](img/rm.png)

* Импортируем и запускаем контейнер обратно через команду `docker import -c 'CMD ["nginx", "-g"]' container.tar`, `docker run -d -p 80:80 -p 443:433 -d nginx`

![simple_docker](img/import_g.png)

![simple_docker](img/2_2.png)

* Проверяем, что по адресу localhost:80/status отдается страничка со статусом сервера nginx

![simple_docker](img/host_2.png)

## Part 3. Мини веб-сервер

* `docker pull nginx`
* Создаем мини-сервер `touch server_fast.c`
![simple_docker](img/serv.png)

* Создаем файл и прописываем необходимые порты `touch nginx.conf`
![simple_docker](img/config.png)

* Запускаем докер с портами `docker run -d -p 81:81 nginx` + `docker ps`
![simple_docker](img/d_1.png)

`cat server/nginx/nginx.conf`

* Копируем сервер и конфиг`docker cp server/nginx/nginx.conf 1f350359902b:/etc/nginx/` + `docker cp server/server_fast.c 1f350359902b:/home` + перезапускаем `docker exec 1f350359902b nginx -s reload`
![simple_docker](img/s1.png)
![simple_docker](img/copy.png)

* Обновляем систему, устанавливаем все необходимое `docker exec -it 1f350359902b bash` + `apt-get update` + `apt-get install -y gcc spawn-fcgi libfcgi-dev`
![simple_docker](img/bas.png)

* Заходим `cd home` + `gcc server_fast.c -lfcgi -o server_fast`

* Запускаем `spawn-fcgi -p 8080 ./server_fast`
![simple_docker](img/home.png)

![simple_docker](img/host.png)


## Part 4. Свой докер

* Создаем Dockerfile
![simple_docker](img/docfile.png)

* Создаем скрипт для запуска сервера
![simple_docker](img/sh.png)

* Собираем  из папки, где файл `docker build -t docker_21 .`
![simple_docker](img/build.png)

* Проверяем `docker images`
![simple_docker](img/n_im.png)

* Запускаем `docker run `
![simple_docker](img/run_n.png)

* Проверяем `docker ps` + `curl localhost`
![simple_docker](img/curl_h.png)

* Дописать в конфиг проксирование стриницы /status + перезапустить и проверить `curl localhost/status`
![simple_docker](img/status_on.png)
![simple_docker](img/localhost_st.png)

## Part 5. **Dockle**

* Устанавливаем dockle `brew install goodwithtech/r/dockle`
![simple_docker](img/inst_dockle.png)

* Сканируем образ, исправляем Dockerfile чтобы не было ошибок, перезапускаем`dockle -ak NGINX_GPGKEY -ak NGINX_GPGKEY_PATH docker_save5`
![simple_docker](img/fale.png)
![simple_docker](img/good.png)

## Part 6. Базовый **Docker Compose**

* Создаем файл docker-compose.yml
![simple_docker](img/yml.png)

* Меняем конфиг
![simple_docker](img/6_conf.png)

* Остановить запущенные контейнеры 
![simple_docker](img/6_ps.png)

* Собираем и запускаем `docker-compose build` `docker-compose up -d`
![simple_docker](img/build_comp.png)
![simple_docker](img/up.png)

* Проверяем localhost
![simple_docker](img/p6.png)
