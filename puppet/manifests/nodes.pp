node default {
}

node /test/ {
	# Configure mysql
	class { 'mysql::server':
		config_hash => { 'root_password' => '8ZcJZFHsvo7fINZcAvi0' }
	}
	
	#ruby installation
	$ruby_build = ['build-essential', 'bison', 'openssl', 'libreadline6', 'libreadline6-dev', 
				   'curl', 'git-core', 'zlib1g', 'zlib1g-dev', 'libssl-dev', 'libyaml-dev', 
				   'libsqlite3-dev', 'sqlite3', 'libxml2-dev', 'libxslt1-dev', 'autoconf', 
				   'libc6-dev', 'libncurses5-dev', 'automake', 'libtool', 'libmysqlclient-dev']
				   
    #package{ $ruby_build: ensure => latest }
    
    $ruby_version = "1.9.3-p327"
    
    rbenv::install { "vagrant":
		group => "vagrant"
	}
	rbenv::compile { $ruby_version:
		user => "vagrant"
	}
	rbenv::gem { "puppet":
		user => "vagrant",
		ruby => $ruby_version
	}
    	
	# apache
	class {'apache': 
		default_vhost => false
	}
	
	apache::vhost { 'default':
		port => 80,
		docroot => '/var/www/inventory/public',
		directories => [
			{
			 path => '/var/www/inventory/public',
			 allow => 'from all',
			 options => ['-MultiViews']
			}
		]
	}
	include apache::mod::passenger


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
