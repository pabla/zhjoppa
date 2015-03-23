# Zhjoppa

Zhjoppa - это капча для Rails 4. Капча генерируется на лету, без сохранения на диск и использования базы данных.

## Установка

Добавьте в Gemfile:

```ruby
gem 'zhjoppa', git: 'https://github.com/pabla/zhjoppa.git'
```

Затем выполните комманды:

```console
bundle install
rails g zhjoppa:install
```

## Настройка

По-умолчанию, создается картинка размером 160x80, на которой написано 4 буквы.
Чтобы изменить это поведение, вам нужно создать файл `config/initializers/zhjoppa.rb` и ввести собственные настройки.

```ruby
Zhjoppa.configure do |config|
  # путь до файла шрифта, по-умолчанию используется шрифт Certege http://openfontlibrary.org/en/font/certege-italic
  config.font = '/path/to/custom_font.ttf'
  # размер шрифта
  config.font_size = 80
  # ширина изображения
  config.width = 160
  # высота изображения
  config.height = 80
  # количество букв
  config.key_len = 4
end
```

## В контроллере

Используйте метод `zhjoppa_valid?` для проверки капчи в контроллере.

```ruby
class RegistrationsController < ApplicationController
  def create
    @form = UserCreator.new(post_params)
    if request.post?
      unless zhjoppa_valid?
        @form.errors[:base] << 'Invalid captcha.'
        return render 'new'
      end
      ...
    end
  end
end
```

## В шаблоне

Для вывода капчи в шаблоне есть хелпер `zhjoppa_tag`.

```ruby
<%= zhjoppa_tag %>
```

Этот хелпер сгенерирует следующий html:

```html
<img id="zhjoppa_image" src="/zhjoppa?t=f0ds" alt="" />
<input id="zhjoppa_key" maxlength="4" name="zhjoppa_key" type="text" />
<br />
<a href="javascript:void(0)" onclick="(function(){var k=Math.round(Math.random()*1000000).toString(36);var i=document.getElementById('zhjoppa_image');i.src=i.src.replace(/\?t=\w+/,'?t='+k)})()">Change image</a>
```

Вы можете изменить шаблон `app/views/zhjoppa/_zhjoppa.html.erb` для генерации нужной вам разметки.
