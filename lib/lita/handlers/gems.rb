require "lita"
require 'open-uri'

module Lita
  module Handlers
    class Gems < Handler
      route /^gem\s+q[ ]+(.+)/i, :search, :help => {
        "gem q KEYWORDS" => "search rubygems by KEYWORDS"
      }
      def search(response)
        keyword = response.matches[0][0]
        results = ::Gems.search(keyword)
        if results.size == 0
          response.reply "Not found: #{keyword}"
        else
          response.reply "http://rubygems.org/search?query=#{URI::encode(keyword)}"
          response.reply results.map{ |d| "#{d["name"]}( #{d["version"]} ) : #{d["project_uri"]}" }.join("\n")
        end
      end

      route(/^gem\s+([^ ]+)/i, :info, :help => {
        "gem GEM_NAME" => "fetch gem's information"
      })
      def info(response)
        gem_name = response.args[0]
        return if gem_name == "q"
        data = ::Gems.info(gem_name)
        if data["version"]
          lines = ["version: #{data["version"]}", "rubygems: #{data["project_uri"]}"]
          lines << "homepage: #{data["homepage_uri"]}" if data["homepage_uri"]
          lines << "documentation: #{data["documentation_uri"]}" if data["documentation_uri"]
          lines << "source code: #{data["source_code_uri"]}" if data["source_code_uri"]
          response.reply lines.join("\n")
        else
          response.reply "This rubygem could not be found: #{gem_name}"
        end
      end
    end

    Lita.register_handler(Gems)
  end
end
