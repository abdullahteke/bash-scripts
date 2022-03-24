#!/usr/bin/expect
 
set resultFile [open capture.txt w]
set username ateke
set password 1233
 
set timeout 1000
set ip [lindex $argv 0]
 
set router $ip
set timeout 1000
 
spawn ssh $username@$router
 
expect "assword:"
send "$password\r"
expect ">"
 
send "disp ap lldp ne br\r"
while  1 {
       expect {
               "\n" { puts $resultFile "$expect_out(buffer)" }
               " ---- More ----" {send " "; exp_continue }
               ">" { close $resultFile; exit 0 }
               eof {set running 1}
               timeout {set running 1}
      }
}