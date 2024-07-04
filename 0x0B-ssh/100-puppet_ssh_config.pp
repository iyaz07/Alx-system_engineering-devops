file { '/root/.ssh':
  ensure => directory,
  owner  => 'root',
  group  => 'root',
  mode   => '0700',
}

# Ensure the SSH configuration file exists
file { '/root/.ssh/config':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0600',
  require => File['/root/.ssh'], # Ensure directory exists before creating the file
}

# Add or update the IdentityFile line in the SSH configuration file
file_line { 'Declare identity file':
  path  => '/root/.ssh/config',
  line  => '  IdentityFile ~/.ssh/school',
  match => '^\\s*IdentityFile\\s+',
  require => File['/root/.ssh/config'], # Ensure file exists before adding/updating the line
}

# Add or update the PasswordAuthentication line in the SSH configuration file
file_line { 'Turn off passwd auth':
  path  => '/root/.ssh/config',
  line  => '  PasswordAuthentication no',
  match => '^\\s*PasswordAuthentication\\s+',
  require => File['/root/.ssh/config'], # Ensure file exists before adding/updating the line
}

