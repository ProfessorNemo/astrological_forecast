# `astrological_forecast`

[![Gem Version](https://img.shields.io/gem/dt/astrological_forecast.svg)][gem]
[![Gem](https://img.shields.io/gem/v/astrological_forecast)][gem]
[![Build Status](https://github.com/ProfessorNemo/astrological_forecast/actions/workflows/ci.yml/badge.svg)][actions]
[![Test Coverage](https://codecov.io/gh/ProfessorNemo/astrological_forecast/graph/badge.svg)](https://codecov.io/gh/ProfessorNemo/astrological_forecast)
[![Depfu](https://img.shields.io/depfu/ProfessorNemo/astrological_forecast?style=flat-square)](https://depfu.com/repos/github/ProfessorNemo/astrological_forecast)

[gem]: https://rubygems.org/gems/astrological_forecast
[gem]: https://rubygems.org/gems/astrological_forecast
[actions]: https://github.com/ProfessorNemo/astrological_forecast/actions
[coveralls]: https://coveralls.io/r/ProfessorNemo/astrological_forecast
###### Язык написания - Ruby

## Описание:
Парсер зодиакальных гороскопов с сайта https://orakul.com. Программа спрашивает у пользователя дату рождения, а в качестве результата
выводит в консоль название знака зодиака, диапазон дат ему соответствующий, заголовок и сам прогноз на текущую дату, на следующий день,
на неделю, на месяц или на год по запросу пользователя. Также есть возможность выбрать разновидность (тип) гороскопа.

## Исходные данные:
---

### Дата рождения (в формате дд.мм):
* например 31.05;
### Разновидность (тип) гороскопа:
* Общий;
* Любовный;
* Семейный;
* Карьерный;
* Здоровье;
* Тинейджер;
* Флирт;
* Друзья.
### Период прогнозирования (для каждого типа гороскопа):
* На сегодня;
* На завтра;
* На неделю;
* На месяц;
* На год.

---

## Установка:

Добавьте

``` rb
gem 'astrological_forecast'
```

И сделайте

    bundle

Или сделайте

    gem install astrological_forecast

## Использование:

``` rb
require 'astrological_forecast'

AstrologicalForecast.predict(true)

# Или, если не хотите использовать консоль для ввода данных:

AstrologicalForecast.predict(true, '19.05', 'общий', 'на сегодня')

```

## Запуск (версия с вводом прогноза в консоль):

``` rb
ruby name_programm.rb

Когда вы родились (укажите дату в формате ДД.ММ, например, 31.12)
19.05

Выберите разновидность гороскопа? Введите число от 1 до 8:

1. Общий
2. Любовный
3. Семейный
4. Карьерный
5. Здоровье
6. Тинейджер
7. Флирт
8. Друзья

> 1

Выберите период прогнозирования? Введите число от 1 до 5:

1. На сегодня
2. На завтра
3. На неделю
4. На месяц
5. На год

> 1

Телец:
Апрель 21 - Май 21,
Я приобретаю! Ключевая особенность - практичность.
Тельцы обладают благородным и независимым характером. Имея силу, они, как ни странно, не спешат ее использовать, 
дожидаясь наиболее благоприятного случая, но частенько упуская его. Упорный труд, а не везение, постоянство, а не 
порыв - вот ключ к успеху Тельцов в жизни.

Общий гороскоп на сегодня, 21 мая, 2022:

Если кто-то действует Вам на нервы, просто игнорируйте. Это ведь такая мелочь! Лучше сосредоточить силы на более 
толковых делах. Рутинное и предсказуемое - безопасно. Но важно понять, почему Вы так держитесь за него. Да, это
стабильность - но не теряете ли Вы интересные возможности? Со временем зона комфорта может стать не такой уж 
комфортной. Стоит подумать о том, чтобы выйти из нее раньше, чем это случится.
```

## Запуск (версия БЕЗ вывода прогноза в консоль):

``` rb
require 'astrological_forecast'

astro = AstrologicalForecast.predict(false, '19.05', 'общий', 'на сегодня')

# astro.class -> Hash
```


## Помочь в разработке:

Шлите ваши пулреквесты в https://github.com/ProfessorNemo/astrological_forecast.

## Лицензия:

[MIT License](https://opensource.org/licenses/MIT)
