# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{smartcall}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["FIXME full name"]
  s.date = %q{2009-07-01}
  s.default_executable = %q{smartcall}
  s.description = %q{Gem to provide sms functionality through the Smartcall Technology Solutions web services.}
  s.email = ["FIXME email"]
  s.executables = ["smartcall"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "website/index.txt"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "bin/smartcall", "config/website.yml.sample", "lib/smartcall.rb", "lib/smartcall/soap/default.rb", "lib/smartcall/soap/default_driver.rb", "lib/smartcall/soap/smartcall_error.rb", "lib/smartcall/soap/sms_ws_client.rb", "lib/smartcall/utility.rb", "lib/smartcall/utility/options.rb", "script/console", "script/destroy", "script/generate", "script/txt2html", "test/test_helper.rb", "test/test_smartcall.rb", "website/index.html", "website/index.txt", "website/javascripts/rounded_corners_lite.inc.js", "website/stylesheets/screen.css", "website/template.html.erb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/agilisto/smartcall}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{smartcall}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Gem to provide sms functionality through the Smartcall Technology Solutions web services.}
  s.test_files = ["test/test_helper.rb", "test/test_smartcall.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 2.3.2"])
    else
      s.add_dependency(%q<hoe>, [">= 2.3.2"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 2.3.2"])
  end
end
