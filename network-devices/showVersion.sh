#!/usr/bin/expect

set ip [lindex $argv 0]

set resultFile [open "tmp/$ip.showVersion" w]
set username ateke
set password test23

set timeout 1000

set router $ip
set timeout 1000

#spawn ssh $username@$router
spawn telnet $router

expect "Username:"
send "$username\r"
expect "assword:"
send "$password\r"
expect "#"

send "show version\r"
while  1 {
       expect {
               "\n" { puts $resultFile "$expect_out(buffer)" }
               " --More--" {send " "; exp_continue }
               "#" { close $resultFile; exit 0 }
               eof {set running 1}
               timeout {set running 1}
      }
}