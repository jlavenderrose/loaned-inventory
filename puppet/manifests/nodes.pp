node default {
}

node /test/ {
	# Configure mysql
	class { 'mysql::server':
		config_hash => { 'root_password' => '8ZcJZFHsvo7fINZcAvi0' }
	}
				   
    $bundle_dep = ['sqlite3', 'libmysqlclient-dev', 'libsqlite3-dev']
    $passenger_dep = ['libcurl4-openssl-dev','apache2-threaded-dev', 'libapr1-dev', 'libaprutil1-dev']
    $gems = ['puppet', 'passenger']
    
    package{ $bundle_dep: ensure => latest }
    package{ $passenger_dep: ensure => latest }
    
    $ruby_version = "1.9.3-p327"
    $ruby_major = "1.9.1"
    $deploy_home = "/home/vagrant"
    
    rbenv::install { "vagrant":
		group => "vagrant",
		home => $deploy_home
	}
	rbenv::compile { $ruby_version:
		user => "vagrant"
	}->
	
	rbenv::gem { $gems:
		user => "vagrant",
		ruby => $ruby_version
	}->
	exec {
	  'install-passenger':
		command => 'passenger-install-apache2-module --auto',
		path => "${deploy_home}/.rbenv/bin:${deploy_home}/.rbenv/versions/${ruby_version}/bin:/bin:/usr/bin",
		creates => "/home/vagrant/.rbenv/versions/1.9.3-p327/lib/ruby/gems/1.9.1/gems/passenger-4.0.10/buildout/apache2/mod_passenger.so",
		user => 'root',
		require => Package[$passenger_dep]
	}->	
	file { '/var/www/inventory/.ruby-version':
		ensure => file,
		owner => 'vagrant',
		group => 'vagrant',
		content => $ruby_version
	}->
	exec { 'bundle install':
		cwd => "/var/www/inventory",
		path => "${deploy_home}/.rbenv/bin:${deploy_home}/.rbenv/versions/${ruby_version}/bin:/bin:/usr/bin",
		user => "vagrant",
		require => [File['/var/www/inventory/.ruby-version', '/var/www/inventory/'], Package[$bundle_dep]]
	}->
	class {'apache': 
		default_vhost => false
	}
	
	apache::vhost { 'default':
		port => 80,
		docroot => '/var/www/inventory/public',
		custom_fragment => 'RackEnv development',
		directories => [
			{
			 path => '/var/www/inventory/public',
			 allow => 'from all',
			 options => ['-MultiViews']
			}
		]
	}
	#class { 'apache::mod::passenger':
	#	lib => '/home/vagrant/.rbenv/versions/1.9.3-p327/lib/ruby/gems/1.9.1/gems/passenger-4.0.10/buildout/apache2/mod_passenger.so',
	#	passenger_root => '/home/vagrant/.rbenv/versions/1.9.3-p327/lib/ruby/gems/1.9.1/gems/passenger-4.0.10',
	#	passenger_ruby => '/home/vagrant/.rbenv/versions/1.9.3-p327/bin/ruby'
	#}

	#passenger grossness
	   file { '/etc/apache2/mods-available/passenger.load':
        ensure  => present,
        content => "LoadModule passenger_module /home/vagrant/.rbenv/versions/1.9.3-p327/lib/ruby/gems/1.9.1/gems/passenger-4.0.10/buildout/apache2/mod_passenger.so",
        owner   => '0',
        group   => '0',
        mode    => '0644',
        notify  => Service['httpd'],
      }

      file { '/etc/apache2/mods-available/passenger.conf':
        ensure  => present,
        content => "PassengerRoot /home/vagrant/.rbenv/versions/1.9.3-p327/lib/ruby/gems/1.9.1/gems/passenger-4.0.10
PassengerDefaultRuby /home/vagrant/.rbenv/versions/1.9.3-p327/bin/ruby",
        owner   => '0',
        group   => '0',
        mode    => '0644',
        notify  => Service['httpd'],
      }

      file { '/etc/apache2/mods-enabled/passenger.load':
        ensure  => 'link',
        target  => '/etc/apache2/mods-available/passenger.load',
        owner   => '0',
        group   => '0',
        mode    => '0777',
        require => File['/etc/apache2/mods-available/passenger.load'],
        notify  => Service['httpd'],
      }

      file { '/etc/apache2/mods-enabled/passenger.conf':
        ensure  => 'link',
        target  => '/etc/apache2/mods-available/passenger.conf',
        owner   => '0',
        group   => '0',
        mode    => '0777',
        require => File['/etc/apache2/mods-available/passenger.conf'],
        notify  => Service['httpd'],
      }

	# Configure Docroot and index.html
	file { '/var/www':
		ensure => directory
	} 

	file { '/var/www/inventory':
		ensure => 'link',
		target => '/vagrant',
		require => File['/var/www']
	}
}
