# Make the app's "gems" directory a place where gems are loaded from
Gem.clear_paths
Gem.path.unshift(Merb.root / "gems")

# Make the app's "lib" directory a place where ruby files get "require"d from
$LOAD_PATH.unshift(Merb.root / "lib")

Merb::Config.use { |c|
  c[:session_store]      = 'cookie'
  c[:session_secret_key] = "2c24532b38b8c46d8acf1b5ed71bdd5426dadd9b"
}

### Merb doesn't come with database support by default.  You need
### an ORM plugin.  Install one, and uncomment one of the following lines,
### if you need a database.

use_orm :datamapper

Merb::BootLoader.before_app_loads do
  DataMapper.setup(:default, 'sqlite3::memory:')
end

dependency File.join(File.dirname(__FILE__),'..','..','..','lib','merb-helpers')

Merb::BootLoader.after_app_loads do
  Merb::Plugins.config[:helpers] = {
    :default_builder => Merb::Helpers::Form::Builder::FormWithErrors
  }

  DataMapper.auto_migrate!
end
