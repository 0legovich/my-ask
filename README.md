# Приложение Ask me

### Идея приложения
Приложение является скромным аналогом популярного сайта [ask.fm](https://ask.fm) предназначено для обмена сообщениями в формате вопрос-ответ.
Для создания нового вопроса, выберите адресата, перейдите в его профиль и оставьте вопрос. *Обратите внимание, что на сайте предусмотрена система защиты от спама [ReCapcha](https://www.google.com/recaptcha/intro/android.html) от Google.*
### Быстрый запуск
Для развертывания приложения Вам необходим интерпретатор [Ruby](https://ru.wikipedia.org/wiki/Ruby) (v. >= 2.4.0) и [Rails](https://ru.wikipedia.org/wiki/Ruby_on_Rails) (рекомендуется v. 4.2.9).
После git clone выполните команды:
* bundle install
* bundle exec rake db:mirgate
### Зависимости
Приложение использует следующие гемы:
* rails-i18n
* rails_12factor
* uglifier
* recaptcha
* jquery-rails
* pg
* byebug
* sqlite3
* web-console ~> 2.0