require 'thor'

module ParcelApi
  class CLI < Thor
    desc 'version', 'print version'
    def version
      puts "Version: #{ParcelApi::VERSION}"
    end
  end
end
