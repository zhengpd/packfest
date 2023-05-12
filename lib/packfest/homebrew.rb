require "open3"

require "packfest/log"
require "packfest/packages"

module Packfest
  class Homebrew
    class << self
      def local_formulae
        @local_formulae ||= begin
          stdout, _ = Open3.capture2("brew", "list", "--formula")
          stdout.split("\n")
        end
      end

      def install(name)
        return if local_formulae.include?(name)

        Log.info("installing #{name}", "homebrew")
        system("brew", "install", name)
      end

      def install_all
        Log.info("Checking packages", "homebrew")
        Packfest::Packages.homebrew.each { |pkg| install(pkg) }
      end
    end
  end
end
