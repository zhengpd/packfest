require "open3"
require "packfest/log"

module Packfest
  module Rubygems
    class Installer
      class << self
        def local_gems
          @local_gems ||= Gem::Specification.map(&:name).uniq
        end

        def install(name)
          return if local_gems.include?(name)

          Log.info("Installing #{name}", "rubygems")
          system("gem", "install", "--conservative", name)
        end

        def run(*name)
          Log.info("Installing gems", "rubygems")
          Packages.rubygems.each { |p| install(p) }
        end
      end
    end

    class Upgrader
      class << self
        def outdated_gems
          @outdated_gems ||= begin
            stdout, _ = Open3.capture2("gem", "outdated")
            stdout.split("\n").map { |line| line.split(" ", 2).first }
          end
        end

        def upgrade(name)
          Log.info("Upgrading #{name}...", "rubygems")
          system("gem", "update", name)
        end

        def run(*names)
          Log.info("Upgrading gems", "rubygems")
          gems = Packages.rubygems.select { |name| outdated_gems.include?(name) }

          Log.info("#{gems.size} gems to upgrade: #{gems.inspect}", "rubygems")
          gems.each { |p| upgrade(p) }
        end
      end
    end
  end
end
