require "open3"

require "packfest/log"
require "packfest/packages"

module Packfest
  module Homebrew
    class Installer
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

        def run(*names)
          Log.info("Installing packages", "homebrew")
          pkgs = if names.empty?
            Packfest::Packages.homebrew
          else
            names
          end
          pkgs.each { |pkg| install(pkg) }
        end
      end
    end

    class Upgrader
      class << self
        def outdated_formulae
          @local_formulae ||= begin
            stdout, _ = Open3.capture2("brew", "outdated", "--formula")
            stdout.split("\n")
          end
        end

        def upgrade(name)
          return unless outdated_formulae.include?(name)

          Log.info("Upgrading #{name}", "homebrew")
          system("brew", "upgrade", name)
        end

        def run(*names)
          Log.info("Upgrading packages", "homebrew")
          pkgs = Packfest::Packages.homebrew
          pkgs = pkgs.select { |pkg| names.include?(pkg) } unless names.empty?
          pkgs = pkgs.select { |pkg| outdated_formulae.include?(pkg) }

          Log.info("#{pkgs.size} packages to upgrade: #{pkgs.inspect}", "homebrew")
          pkgs.each { |pkg| upgrade(pkg) }
        end
      end
    end
  end
end
