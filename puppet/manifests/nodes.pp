node default {
}

node /test/ {
	# Configure mysql
	class { 'mysql::server':
		config_hash => { 'root_password' => '8ZcJZFHsvo7fINZcAvi0' }
	}

	class {'apache': 
		default_vhost => false
	}
	
	apache::vhost { 'default':
		port => 80,
		docroot => '/var/www/inventory'
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
