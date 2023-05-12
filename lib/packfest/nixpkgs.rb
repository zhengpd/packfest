require "open3"

require "packfest/log"
require "packfest/packages"

module Packfest
  module Nixpkgs
    class Installer
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

        def run(*names)
          Log.info("Installing packages", "nixpkgs")
          pkgs = if names.empty?
            Packages.nixpkgs
          else
            names
          end
          pkgs.each { |p| install(p) }
        end
      end
    end

    class Upgrader
      class << self
        def run(*names)
          Log.info("Upgrading packages", "nixpkgs")
          # TODO: support package names
          system("nix", "profile", "upgrade", ".*")
        end
      end
    end
  end
end
