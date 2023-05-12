require "yaml"

module Packfest
  class Packages
    class << self
      def manifest_path
        @manifest_path ||= ENV["PACKFEST_YAML"] || File.join(Dir.home, ".config/packfest.yaml")
      end

      def manifest
        @manifest ||= YAML.load_file(manifest_path)["packages"]
      end

      def homebrew
        manifest["brew_formulae"] || []
      end

      def nixpkgs
        manifest["nixpkgs"] || []
      end

      def rubygems
        manifest["rubygems"] || []
      end
    end
  end
end
