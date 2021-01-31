:local routeID [/ip route find dst-address=0.0.0.0/0]
:local gateway [:tostr ([/ip route get $routeID value-name=gateway])]

:local lookup { "firstDivider"=[:find $gateway "."] ; "secondOctet"="" ; "octetLength"=0 ; "nextDivider"=0 ; "findResult"="" }

:set ($lookup->"secondOctet") [:pick $gateway (($lookup->"firstDivider") + 1) (($lookup->"firstDivider") + 4)]
:set ($lookup->"findResult") [:find ($lookup->"secondOctet") "."]

:while ([:typeof ($lookup->"findResult")] = "num") do={
	:set ($lookup->"octetLength") [:len ($lookup->"secondOctet")]
	:set ($lookup->"nextDivider") [:find ($lookup->"secondOctet") "."]
	:set ($lookup->"secondOctet") [:pick ($lookup->"secondOctet") 0 ($lookup->"nextDivider")]
	:set ($lookup->"findResult") [:find ($lookup->"secondOctet") "."]
}

return ($lookup->"secondOctet")
