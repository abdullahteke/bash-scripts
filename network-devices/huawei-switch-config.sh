#!/usr/bin/expect

# All parameteter started with "$tc_" come from HP Network automation
set ip $tc_device_ip$

set username $tc_device_username$
set password $tc_device_password$

set timeout 1000

spawn ssh  -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $username@$ip

expect "assword:"
send "$password\r"
expect ">"
send "sys\r"
expect "]"
send "hwtacacs enable\r"
expect "]"
send "hwtacacs-server template fb-tacacs-template\r"
expect "]"
send "hwtacacs-server authentication 10.198.2.195\r"
expect "]"
send "hwtacacs-server authentication 10.198.2.197 secondary\r"
expect "]"
send "hwtacacs-server authorization 10.198.2.195\r"
expect "]"
send "hwtacacs-server authorization 10.198.2.197 secondary\r"
expect "]"
send "hwtacacs-server accounting 10.198.2.195\r"
expect "]"
send "hwtacacs-server accounting 10.198.2.197 secondary\r"
expect "]"
send "hwtacacs-server shared-key cipher !1234qqqQ!\r"
expect "]"
send "aaa\r"
expect "]"
send "authentication-scheme fb-auth-sch\r"
expect "]"
send "authentication-mode hwtacacs local\r"
expect "]"
send "quit\r"
expect "]"
send "authorization-scheme fb-autho-sch\r"
expect "]"
send "authorization-mode hwtacacs local\r"
expect "]"
send "quit\r"
expect "]"
send "accounting-scheme fb-acco-sch\r"
expect "]"
send "accounting-mode hwtacacs\r"
expect "]"
send "accounting realtime 3\r"
expect "]"
send "accounting start-fail online\r"
expect "]"
send "quit\r"
expect "]"  
send "domain default_admin\r"
expect "]"
send "authentication-scheme fb-auth-sch\r"
expect "]"
send "accounting-scheme fb-acco-sch\r"
expect "]"
send "authorization-scheme fb-autho-sch\r"
expect "]"
send "hwtacacs-server fb-tacacs-template\r"
send "return\r"
expect ">"
send "save\r"
expect "[Y/N]"
send "Y\r"
expect ">"
sen