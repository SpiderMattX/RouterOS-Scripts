:local version { full="$1"; major=0; minor=0; patch=0 }
:local segment 1
:local match "$1"
:local length [:len $match]

:while ($segment < 4) do={
	:local part ""
	:local result [:find $match "."]

	:if ([:typeof $result] = "num") do={
		:set part [:pick $match 0 $result]
	} else={
		:set part [:pick $match 0 $length]
	}

	:if ($segment=1) do={
		:set ($version->"major") [:tonum $part]
	}

	:if ($segment=2) do={
		:set ($version->"minor") [:tonum $part]
	}

	:if ($segment=3) do={
		:set ($version->"patch") [:tonum $part]
	}

	:if ([:typeof $result] = "num") do={
		:set segment ($segment + 1)
		:set match [:pick $match ($result + 1) $length]
        :set length [:len $match]
	} else={
		:set segment 4
	}
}

:return $version