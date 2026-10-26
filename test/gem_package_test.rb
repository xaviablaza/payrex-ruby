require "minitest/autorun"
require "open3"
require "tmpdir"
require "rubygems/package"

class GemPackageTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__)

  def test_manifest_includes_all_library_files
    Dir.chdir(ROOT) do
      spec = Gem::Specification.load("payrex-ruby.gemspec")
      assert_equal Dir["lib/**/*.rb"].sort, spec.files.grep(/\Alib\/.*\.rb\z/).sort
    end
  end

  def test_version_matches_release_file
    spec = Gem::Specification.load(File.join(ROOT, "payrex-ruby.gemspec"))
    assert_equal File.read(File.join(ROOT, "VERSION")).strip, spec.version.to_s
  end

  def test_installed_gem_loads_without_source_checkout
    Dir.mktmpdir("payrex-package-") do |directory|
      package = File.join(directory, "payrex-ruby.gem")
      run_command({}, ROOT, Gem.ruby, "-S", "gem", "build", "payrex-ruby.gemspec", "--output", package)
      version = Gem::Package.new(package).spec.version.to_s
      home = File.join(directory, "gems")
      env = {"GEM_HOME" => home, "GEM_PATH" => [home, Gem.default_dir].join(File::PATH_SEPARATOR),
             "RUBYLIB" => nil, "RUBYOPT" => nil, "BUNDLE_GEMFILE" => nil}
      run_command(env, directory, Gem.ruby, "-S", "gem", "install", package, "--local", "--no-document", "--ignore-dependencies")
      script = <<~RUBY
        gem "payrex-ruby", ARGV.fetch(0)
        require "payrex-ruby"
        path = Gem.loaded_specs.fetch("payrex-ruby").full_gem_path
        abort "Loaded gem outside isolated installation: \#{path}" unless path.start_with?(ENV.fetch("GEM_HOME") + File::SEPARATOR)
        abort "Missing SetupIntent" unless defined?(Payrex::Entities::SetupIntent)
        abort "Missing PaymentMethod" unless defined?(Payrex::Entities::PaymentMethod)
        client = Payrex::Client.new("sk_test_packaging_only")
        abort "Missing setup intents service" unless client.setup_intents.is_a?(Payrex::Services::SetupIntentsService)
      RUBY
      run_command(env, directory, Gem.ruby, "-e", script, version)
    end
  end

  private

  def run_command(env, directory, *command)
    stdout, stderr, status = Open3.capture3(env, *command, :chdir => directory)
    assert status.success?, "#{command.join(' ')} failed:\n#{stdout}\n#{stderr}"
  end
end
