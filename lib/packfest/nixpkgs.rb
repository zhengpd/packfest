require "open3"

require "packfest/log"
require "packfest/packages"

module Packfest
  class Nixpkgs
    class << self
      def local_pkgs
        @local_pkgs ||= begin
          list, _ = Open3.capture2("nix", "profile", "list")
          list.split("\n").map { |line| line.split(" ")[1].split(".").last }
        end
      end

      def install(name)
        return if local_pkgs.include?(name)

        Log.info("Installing nixpkgs##{name}", "nixpkgs")
        system("nix", "profile", "install", "nixpkgs##{name}")
      end

      def install_all
        Log.info("Checking packages", "nixpkgs")
        Packages.nixpkgs.each { |p| install(p) }
      end
    end
  end
end
