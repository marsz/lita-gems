require "lita"
require 'open-uri'

module Lita
  module Handlers
    class Gems < Handler
      route /^gem\s+q[ ]+(.+)/i, :search, :help => {
        t("help.search.command") => t("help.search.text")
      }
      def search(response)
        keyword = response.matches[0][0]
        results = ::Gems.search(keyword)
        if results.size == 0
          response.reply t("not_found", keyword: keyword)
        else
          response.reply "http://rubygems.org/search?query=#{URI::encode(keyword)}"
          response.reply results.map{ |d| "#{d["name"]}( #{d["version"]} ) : #{d["project_uri"]}" }.join("\n")
        end
      end

      route(/^gem\s+([^ ]+)/i, :info, :help => {
        t("help.info.command") => t("help.info.text")
      })
      def info(response)
        gem_name = response.args[0]
        return if gem_name == "q"
        data = ::Gems.info(gem_name)
        if data["version"]
          lines = ["#{t("version")}: #{data["version"]}", "#{t("rubygems")}: #{data["project_uri"]}"]
          lines << "#{t("homepage")}: #{data["homepage_uri"]}" if data["homepage_uri"]
          lines << "#{t("documentation")}: #{data["documentation_uri"]}" if data["documentation_uri"]
          lines << "#{t("source")}: #{data["source_code_uri"]}" if data["source_code_uri"]
          response.reply lines.join("\n")
        else
          response.reply t("gem_not_found", gem: gem_name)
        end
      end
    end

    Lita.register_handler(Gems)
  end
end
