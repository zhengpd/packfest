Gem::Specification.new do |s|
  s.name = "packfest"
  s.version = "0.1"
  s.summary = "Packages management done simple"
  s.description = "packfest is a tool to manage packages from different sources"
  s.authors = ["zpd"]
  s.files = Dir.glob("{lib,bin}/**/*")
  s.homepage = "https://github.com/zhengpd"
  s.license = "MIT"
  s.executables = ["packfest"]

  s.add_dependency "colorize", "~> 0.8.1"
  s.add_dependency "dry-cli", "~> 1.0.0"

  s.add_development_dependency "minitest", "~> 5.8"
  s.add_development_dependency "minitest-reporters", "~> 1.6.0"
end
