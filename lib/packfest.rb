require "packfest/log"
require "packfest/homebrew"
require "packfest/nixpkgs"
require "packfest/rubygems"

module Packfest
  def self.install_all
    Log.info("Start working...")
    Homebrew.install_all
    Nixpkgs.install_all
    Rubygems.install_all
    Log.info("DONE.")
  end
end
