require "packfest/log"
require "packfest/homebrew"
require "packfest/nixpkgs"
require "packfest/rubygems"

module Packfest
  def self.install_all
    Log.info("Start working...")
    Homebrew::Installer.run
    Nixpkgs::Installer.run
    Rubygems::Installer.run
    Log.info("DONE.")
  end

  def self.upgrade_all
    Log.info("Start upgrading packages...")
    Homebrew::Upgrader.run
    Nixpkgs::Upgrader.run
    Rubygems::Upgrader.run
    Log.info("DONE.")
  end
end
