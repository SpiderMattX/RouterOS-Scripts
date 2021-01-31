{
	:local formatDateTime [:parse [/system script get func_formatDateTime source]]
	:local routeID [/ip route find dst-address=0.0.0.0/0]

	# BTest Server Settings
	:local btestServer { username="USERNAME HERE" ; password="PASSWORD HERE" ; hostname=[/ip route get $routeID value-name=gateway] }

	# TCP Test Settings
	:local tcpOptions { duration="2s" ; "updateInterval"="1s" }

	# UDP Test Settings
	:local udpOptions { duration="2s" ; "updateInterval"="1s" ; "rxSize"=1000 ; "txSize"=1000 }

	# Test Results
	:local tcpRxTest { start="" ; updated="" ; end="" ; peak=0 ; current=0 ; average=0 }
	:local tcpTxTest { start="" ; updated="" ; end="" ; peak=0 ; current=0 ; average=0 }
	:local udpRxTest { start="" ; updated="" ; end="" ; peak=0 ; current=0 ; average=0 ; size=0 ;  "lostPackets"=0 }
	:local udpTxTest { start="" ; updated="" ; end="" ; peak=0 ; current=0 ; average=0 ; size=0 }

	# TCP Downstream Test

	:set ($tcpRxTest->"start") [$formatDateTime]
	
	/tool bandwidth-test ($btestServer->"hostname") protocol=tcp random-data=no direction=receive duration=($tcpOptions->"duration") user=($btestServer->"username") password=($btestServer->"password") do={

		:set ($tcpRxTest->"updated") [$formatDateTime]
		:set ($tcpRxTest->"current") ($"rx-current" / 1000000)
		:set ($tcpRxTest->"average") ($"rx-total-average" / 1000000)

		:if ( ($tcpRxTest->"peak") < ($tcpRxTest->"current") ) do={
			:set ($tcpRxTest->"peak") ($tcpRxTest->"current")
		}
	}
	
	:set ($tcpRxTest->"end") [$formatDateTime]

	# Log Test Results
	:log info ("Tools/Automatic-BTest: TCP Downstream; Started: " . ($tcpRxTest->"start") . "; Completed: " . ($tcpRxTest->"end") . "; Server: " . ($btestServer->"hostname") . "; Peak: " . ($tcpRxTest->"peak") . " Mbps; Average: " . ($tcpRxTest->"average") . " Mbps; Duration: " . ($tcpOptions->"duration") . ";")
	
	# TCP Upstream Test

	:set ($tcpTxTest->"start") [$formatDateTime]
	
	/tool bandwidth-test ($btestServer->"hostname") protocol=tcp random-data=no direction=transmit duration=($tcpOptions->"duration") user=($btestServer->"username") password=($btestServer->"password") do={

		:set ($tcpTxTest->"updated") [$formatDateTime]
		:set ($tcpTxTest->"current") ($"tx-current" / 1000000)
		:set ($tcpTxTest->"average") ($"tx-total-average" / 1000000)

		:if ( ($tcpTxTest->"peak") < ($tcpTxTest->"current") ) do={
			:set ($tcpTxTest->"peak") ($tcpTxTest->"current")
		}
	}

	:set ($tcpTxTest->"end") [$formatDateTime]
	
	# Log Test Results
	:log info ("Tools/Automatic-BTest: TCP Upstream; Started: " . ($tcpTxTest->"start") . "; Completed: " . ($tcpTxTest->"end") . "; Server: " . ($btestServer->"hostname") . "; Peak: " . ($tcpTxTest->"peak") . " Mbps; Average: " . ($tcpTxTest->"average") . " Mbps; Duration: " . ($tcpOptions->"duration") . ";")
	
	# UDP Downstream Test

	:set ($udpRxTest->"start") [$formatDateTime]
	
	/tool bandwidth-test ($btestServer->"hostname") protocol=udp random-data=no direction=receive duration=($udpOptions->"duration") user=($btestServer->"username") password=($btestServer->"password") remote-udp-tx-size=($udpOptions->"rxSize") do={

		:set ($udpRxTest->"updated") [$formatDateTime]
		:set ($udpRxTest->"current") ($"rx-current" / 1000000)
		:set ($udpRxTest->"average") ($"rx-total-average" / 1000000)
		:set ($udpRxTest->"lostPackets") ($"lost-packets" / 1)
		:set ($udpRxTest->"size") ($"rx-size" / 1)

		:if ( ($udpRxTest->"peak") < ($udpRxTest->"current") ) do={
			:set ($udpRxTest->"peak") ($udpRxTest->"current")
		}
	}

	:set ($udpRxTest->"end") [$formatDateTime]
	
	# Log Test Results
	:log info ("Tools/Automatic-BTest: UDP Downstream; Started: " . ($udpRxTest->"start") . "; Completed: " . ($udpRxTest->"end") . "; Server: " . ($btestServer->"hostname") . "; Peak: " . ($udpRxTest->"peak") . " Mbps; Average: " . ($udpRxTest->"average") . " Mbps; Packet Size: " . ($udpRxTest->"size") . "; Duration: " . ($udpOptions->"duration") . "; Lost Packets: " . ($udpRxTest->"lostPackets") . ";")
	
	# UDP Upstream Test

	:set ($udpTxTest->"start") [$formatDateTime]
	
	/tool bandwidth-test ($btestServer->"hostname") protocol=udp random-data=no direction=transmit duration=($udpOptions->"duration") user=($btestServer->"username") password=($btestServer->"password") local-udp-tx-size=($udpOptions->"txSize") do={

		:set ($udpTxTest->"updated") [$formatDateTime]
		:set ($udpTxTest->"current") ($"tx-current" / 1000000)
		:set ($udpTxTest->"average") ($"tx-total-average" / 1000000)
		:set ($udpTxTest->"size") ($"tx-size" / 1)

		:if ( ($udpTxTest->"peak") < ($udpTxTest->"current") ) do={
			:set ($udpTxTest->"peak") ($udpTxTest->"current")
		}
	}

	:set ($udpTxTest->"end") [$formatDateTime]
	
	# Log Test Results
	:log info ("Tools/Automatic-BTest: UDP Upstream; Started: " . ($udpTxTest->"start") . "; Completed: " . ($udpTxTest->"end") . "; Server: " . ($btestServer->"hostname") . "; Peak: " . ($udpTxTest->"peak") . " Mbps; Average: " . ($udpTxTest->"average") . " Mbps; Packet Size: " . ($udpTxTest->"size") . "; Duration: " . ($udpOptions->"duration") . ";")
}
