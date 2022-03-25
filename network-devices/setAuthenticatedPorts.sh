#!/usr/bin/expect

set username ateke
set password 1q2w3e4R

set ip [lindex $argv 0]
spawn ssh $username@$ip

expect {
        "*refuse*" {
                log_file /root/HW_Refused.log
                send_log "$router ## connection refused \n"
                exit 0
 
        }
        "*route*" {
                log_file /root/HW_NoRoute.log
                send_log "$router ## connection time out\n"
                exit 0
 
        }
        "Connection timed out" { 
                log_file /root/HW_Timeout.log
                send_log "$router ## connection time out\n"
                exit 0
        }

        "(yes/no)?" {
                send "yes\r";
        }
} 

expect "assword:"
send "$password\r"

expect ">"
send "sys\r"

set fd [open authenticatedPorts.txt r]
set fd2 [open configuredVlan.csv a]

while {[gets $fd line] != -1} {
	if { [ regexp {.* (.*)/- .* GE(.*) authen.*} $line match vlan interface ] == 0 } {
        	continue
    } else {
		if { $vlan != "3613" && $vlan != "1"} {
			puts $fd2 "$ip,$interface,$vlan" 

                       	send "interface G $interface\r"
                       	expect "]"
                       	send "shutdown\r"
                       	expect "]"
                       	send "undo port link-type\r"
                       	expect "]"
                       	send "undo authentication dot1x\r"
                       	expect "]"
                       	send "undo authentication mode\r"
                       	expect "]"
                       	send "undo dot1x authentication-method\r"
                       	expect "]"
                       	send "port link-type access\r"
                       	expect "]"
                       	send "port def vlan $vlan\r"
                       	expect "]"
                       	send "undo shutdown\r"
                       	expect "]"
                       	send "quit\r"
                       	expect "]" 
		} fi
    }
    fi
}

close $fd
close $fd2

expect "]"
send "quit\r"
expect ">"
send "save\r"
expect "Y/N]"
send "Y\r"

exit 0
