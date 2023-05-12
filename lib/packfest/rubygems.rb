require 'open3'
require 'packfest/log'
require 'packfest/log'

module Packfest
  class Rubygems
    class << self
      def local_gems
        @local_gems ||= Gem::Specification.map(&:name).uniq
      end

      def install(name)
        return if local_gems.include?(name)

        Log.info("Installing #{name}", "rubygems")
        system("gem", "install", "--conservative", name)
      end

      def install_all
        Log.info("Checking gems", "rubygems")
        Packages.rubygems.each { |p| install(p) }
      end
    end
  end
end
