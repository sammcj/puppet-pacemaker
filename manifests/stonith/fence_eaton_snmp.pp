# generated by agent_generator.rb, manual changes will be lost

define pacemaker::stonith::fence_eaton_snmp (
  $ipaddr = undef,
  $login = undef,
  $passwd = undef,
  $port = undef,
  $snmp_version = undef,
  $community = undef,
  $ipport = undef,
  $inet4_only = undef,
  $inet6_only = undef,
  $passwd_script = undef,
  $snmp_auth_prot = undef,
  $snmp_sec_level = undef,
  $snmp_priv_prot = undef,
  $snmp_priv_passwd = undef,
  $snmp_priv_passwd_script = undef,
  $verbose = undef,
  $debug = undef,
  $separator = undef,
  $power_timeout = undef,
  $shell_timeout = undef,
  $login_timeout = undef,
  $power_wait = undef,
  $delay = undef,
  $retry_on = undef,

  $interval = "60s",
  $ensure = present,
  $pcmk_host_list = undef,
) {
  $ipaddr_chunk = $ipaddr ? {
    undef => "",
    default => "ipaddr=\"${ipaddr}\"",
  }
  $login_chunk = $login ? {
    undef => "",
    default => "login=\"${login}\"",
  }
  $passwd_chunk = $passwd ? {
    undef => "",
    default => "passwd=\"${passwd}\"",
  }
  $port_chunk = $port ? {
    undef => "",
    default => "port=\"${port}\"",
  }
  $snmp_version_chunk = $snmp_version ? {
    undef => "",
    default => "snmp_version=\"${snmp_version}\"",
  }
  $community_chunk = $community ? {
    undef => "",
    default => "community=\"${community}\"",
  }
  $ipport_chunk = $ipport ? {
    undef => "",
    default => "ipport=\"${ipport}\"",
  }
  $inet4_only_chunk = $inet4_only ? {
    undef => "",
    default => "inet4_only=\"${inet4_only}\"",
  }
  $inet6_only_chunk = $inet6_only ? {
    undef => "",
    default => "inet6_only=\"${inet6_only}\"",
  }
  $passwd_script_chunk = $passwd_script ? {
    undef => "",
    default => "passwd_script=\"${passwd_script}\"",
  }
  $snmp_auth_prot_chunk = $snmp_auth_prot ? {
    undef => "",
    default => "snmp_auth_prot=\"${snmp_auth_prot}\"",
  }
  $snmp_sec_level_chunk = $snmp_sec_level ? {
    undef => "",
    default => "snmp_sec_level=\"${snmp_sec_level}\"",
  }
  $snmp_priv_prot_chunk = $snmp_priv_prot ? {
    undef => "",
    default => "snmp_priv_prot=\"${snmp_priv_prot}\"",
  }
  $snmp_priv_passwd_chunk = $snmp_priv_passwd ? {
    undef => "",
    default => "snmp_priv_passwd=\"${snmp_priv_passwd}\"",
  }
  $snmp_priv_passwd_script_chunk = $snmp_priv_passwd_script ? {
    undef => "",
    default => "snmp_priv_passwd_script=\"${snmp_priv_passwd_script}\"",
  }
  $verbose_chunk = $verbose ? {
    undef => "",
    default => "verbose=\"${verbose}\"",
  }
  $debug_chunk = $debug ? {
    undef => "",
    default => "debug=\"${debug}\"",
  }
  $separator_chunk = $separator ? {
    undef => "",
    default => "separator=\"${separator}\"",
  }
  $power_timeout_chunk = $power_timeout ? {
    undef => "",
    default => "power_timeout=\"${power_timeout}\"",
  }
  $shell_timeout_chunk = $shell_timeout ? {
    undef => "",
    default => "shell_timeout=\"${shell_timeout}\"",
  }
  $login_timeout_chunk = $login_timeout ? {
    undef => "",
    default => "login_timeout=\"${login_timeout}\"",
  }
  $power_wait_chunk = $power_wait ? {
    undef => "",
    default => "power_wait=\"${power_wait}\"",
  }
  $delay_chunk = $delay ? {
    undef => "",
    default => "delay=\"${delay}\"",
  }
  $retry_on_chunk = $retry_on ? {
    undef => "",
    default => "retry_on=\"${retry_on}\"",
  }

  $pcmk_host_value_chunk = $pcmk_host_list ? {
    undef => '$(/usr/sbin/crm_node -n)',
    default => "${pcmk_host_list}",
  }

  # $title can be a mac address, remove the colons for pcmk resource name
  $safe_title = regsubst($title, ':', '', 'G')

  if($ensure == absent) {
    exec { "Delete stonith-fence_eaton_snmp-${safe_title}":
      command => "/usr/sbin/pcs stonith delete stonith-fence_eaton_snmp-${safe_title}",
      onlyif => "/usr/sbin/pcs stonith show stonith-fence_eaton_snmp-${safe_title} > /dev/null 2>&1",
      require => Class["pacemaker::corosync"],
    }
  } else {
    package {
      "fence-agents-eaton-snmp": ensure => installed,
    } ->
    exec { "Create stonith-fence_eaton_snmp-${safe_title}":
      command => "/usr/sbin/pcs stonith create stonith-fence_eaton_snmp-${safe_title} fence_eaton_snmp pcmk_host_list=\"${pcmk_host_value_chunk}\" ${ipaddr_chunk} ${login_chunk} ${passwd_chunk} ${port_chunk} ${snmp_version_chunk} ${community_chunk} ${ipport_chunk} ${inet4_only_chunk} ${inet6_only_chunk} ${passwd_script_chunk} ${snmp_auth_prot_chunk} ${snmp_sec_level_chunk} ${snmp_priv_prot_chunk} ${snmp_priv_passwd_chunk} ${snmp_priv_passwd_script_chunk} ${verbose_chunk} ${debug_chunk} ${separator_chunk} ${power_timeout_chunk} ${shell_timeout_chunk} ${login_timeout_chunk} ${power_wait_chunk} ${delay_chunk} ${retry_on_chunk}  op monitor interval=${interval}",
      unless => "/usr/sbin/pcs stonith show stonith-fence_eaton_snmp-${safe_title} > /dev/null 2>&1",
      require => Class["pacemaker::corosync"],
    } ->
    exec { "Add non-local constraint for stonith-fence_eaton_snmp-${safe_title}":
      command => "/usr/sbin/pcs constraint location stonith-fence_eaton_snmp-${safe_title} avoids ${pcmk_host_value_chunk}"
    }
  }
}
