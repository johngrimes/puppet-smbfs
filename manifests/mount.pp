define smbfs::mount($source, $dest, $credential_file) {
  $credential_path = "/etc/samba/${title}.credentials"

  file { $credential_path:
    ensure  => file,
    source  => $credential_file,
    owner   => 'root',
    group   => 'admin',
    mode    => '440',
    require => Package['smbfs']
  }

  fstab { $title:
    source  => $source,
    dest    => $dest,
    type    => 'cifs',
    opts    => "noauto,credentials=${credential_path},noexec",
    dump    => 0,
    passno  => 0,
    require => [
      Package['smbfs'],
      File[$credential_path]
    ]
  }
}
