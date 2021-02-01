:local address { full="$1"; octet1=0; octet2=0; octet3=0; octet4=0 }
:local segment 1
:local match "$1"
:local length [:len $match]

:while ($segment < 5) do={
	:local part ""
	:local result [:find $match "."]

	:if ([:typeof $result] = "num") do={
		:set part [:pick $match 0 $result]
	} else={
		:set part [:pick $match 0 $length]
	}

	:set ($address->"octet$segment") [:tonum $part]

	:if ([:typeof $result] = "num") do={
		:set segment ($segment + 1)
		:set match [:pick $match ($result + 1) $length]
        :set length [:len $match]
	} else={
		:set segment 5
	}
}

:return $address