require "logger"
require "colorize"

module Packfest
  class Log
    class << self
      def logger
        @logger ||= begin
          logger = Logger.new($stdout)
          logger.formatter = proc do |severity, datetime, program, msg|
            "[#{datetime}] #{severity} : #{msg}\n".blue
          end
          logger
        end
      end

      def info(msg, mod = nil)
        logger.info(fmt(msg, mod))
      end

      def fmt(msg, mod)
        return "[Packfest] #{msg}" if mod.to_s.empty?

        "[Packfest.#{mod}] #{msg}"
      end
    end
  end
end
