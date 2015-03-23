class Zhjoppa
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def copy_view
        copy_file '_zhjoppa.html.erb', 'app/views/zhjoppa/_zhjoppa.html.erb'
      end
    end
  end
end
