# ZAlexanderV_microservices
ZAlexanderV microservices repository
![example workflow](https://github.com/Otus-DevOps-2023-11/ZAlexanderV_microservices/actions/workflows/run-tests.yml/badge.svg)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
<details><summary>Выполнено ДЗ №13 - Написание Dockerfile и сборка образа с тестовым приложением. Сохранение образа на DockerHub</summary>

  - Установлено окружение для работы с docker
  - Выполнил операции с docker локально
  - Создал docker-host в yandex cloud с помощью docker-machine
  - Собрал образ из Dockerfile
  - Поработал с docker на docker-host
  - Зарегистрировался на  docker hub
  - Загрузил образ на docker hub

  Задания со :star:
   - Создан код terraform для динамического развёртывания машин с docker
   - Создан код для packer подготавливающий образ с docker
   - Создан playbook для развёртывания docker и запуска контейнера
   - Создан файл для динамического поиска инветаря и объеденения в группу

</details>

<details><summary>Выполнено ДЗ №14 - Написание Dockerfile и сборка образа с тестовым приложением. Сохранение образа на DockerHub</summary>

  - Собрано приложение из нескольких контейнеров
  - Обновил dockerfile для сброки всех компонентов
  - Создана сеть для работы приложения
  - Примонтирован том для хранения данных

  Задания со :star:
   - Собран ui с базовым alpine образом

</details>

<details><summary>Выполнено ДЗ №15 - Декларативное описание Docker инфраструктуры при помощи Docker Compose</summary>

   Изменение названия проекта(префикс который задаётся контейнерам) происходит при установке переменной окружения `COMPOSE_PROJECT_NAME`

  - Описана структура проекта в docker compose
  - Создан файл переменных для подмены переменных окружения
  - Описаны несколько сетей для подключения к контейнеру


  Задания со :star:
  - Создан файл переопределения базовых переменных для запуска приложений с доп. флагами

</details>

<details><summary>Выполнено ДЗ №16 - Построение процесса непрерывной интеграции</summary>

   Изменение названия проекта(префикс который задаётся контейнерам) происходит при установке переменной окружения `COMPOSE_PROJECT_NAME`

  - Создана ВМ для запуска GitLab
  - Установлен DockerEngine через Ansible
  - Запущен Gitlab через Docker
  - Добавлен runner для исполнения задач
  - Сконфигурирован пайплайн для теста развёртывания
  - Определены переменные для развёртывания
  - Создана динамическая среда
  - Создан Compose файл для развёртывания Gitlab

</details>


<details><summary>Выполнено ДЗ №18 - Логгирование</summary>

  - Добавлена инфраструктура для логгирования
  - Создан DOckerfile для кастомного образа логгирования
  - Подготовлен файл конфигурации для агента логгирования

</details>
