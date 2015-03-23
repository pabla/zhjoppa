require 'RMagick'
require 'rails/engine'
require 'action_controller/railtie'
require 'action_view/railtie'

class Zhjoppa
  def generate_key
    vowels = %w(a e i o u y)
    consonants = %w(b c d f g h j k m n p q r s t u v w x z)
    letters = []
    (Zhjoppa.configuration.key_len / 2.0).ceil.times do
      letters << consonants.sample
      letters << vowels.sample
    end
    letters.slice(0, Zhjoppa.configuration.key_len).join ''
  end

  def generate_image(key)
    image = Image.new
    image.generate(key)
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    class Configuration
      attr_accessor :font, :font_size, :width, :height, :key_len

      def initialize
        @font = File.expand_path("#{File.dirname(__FILE__)}/Certege.ttf")
        @font_size = 80
        @width = 160
        @height = 80
        @key_len = 4
      end
    end
  end
end

class Zhjoppa
  class Image
    def generate(key)
      corner1 = Random.rand(30) + 10
      corner2 = Random.rand(30) + 10
      roll = Random.rand(100) + 50
      amplitude = 5
      wavelength = 75
      # text
      img = Magick::Image.new(Zhjoppa.configuration.width, Zhjoppa.configuration.height) do
        self.background_color = '#ffffff'
      end
      txt = Magick::Draw.new
      txt.annotate(img, 0, 0, 0, 0, key) do
        txt.font = Zhjoppa.configuration.font
        txt.pointsize = Zhjoppa.configuration.font_size
        txt.kerning = -5
        txt.gravity = Magick::CenterGravity
        txt.stroke_width = 1
        txt.stroke = '#000000'
        txt.fill = '#ffffff'
      end
      # transform
      img = img.roll roll, 0
      img = img.swirl(-corner1)
      img = img.roll(-roll * 2, 0)
      img = img.swirl(corner2)
      img = img.roll(roll, 0)
      img = img.wave(amplitude, wavelength)
      img.crop!(Magick::CenterGravity, Zhjoppa.configuration.width, Zhjoppa.configuration.height)
      # write
      blob = img.to_blob do
        self.format = 'PNG'
      end
      img.destroy!
      blob
    end
  end
end

class Zhjoppa
  module ViewHelper
    def zhjoppa_tag
      @image = zhjoppa_path nil, t: Random.rand(1_000_000).to_s(36)
      @image_id = :zhjoppa_image
      @field_name = :zhjoppa_key
      @field_length = Zhjoppa.configuration.key_len
      render 'zhjoppa/zhjoppa'
    end
  end
end

class Zhjoppa
  module ControllerHelper
    def zhjoppa_valid?
      return true if Rails.env.test?
      if session.key?(:zhjoppa)
        ret = params[:zhjoppa_key] == session[:zhjoppa][:key]
        session.delete(:zhjoppa)
        ret
      else
        false
      end
    end
  end
end

class Zhjoppa
  class Controller < ActionController::Base
    def image
      z = Zhjoppa.new
      key = z.generate_key
      session[:zhjoppa] = { key: key }
      png = Zhjoppa.new.generate_image key
      send_data png, type: 'image/png', disposition: 'inline'
    end
  end
end

class Zhjoppa
  class Engine < ::Rails::Engine
    config.after_initialize do |app|
      ActionView::Base.send(:include, Zhjoppa::ViewHelper)
      ActionController::Base.send(:include, Zhjoppa::ControllerHelper)
      app.routes.prepend do
        get 'zhjoppa', to: Zhjoppa::Controller.action(:image), as: :zhjoppa
      end
    end
  end
end
