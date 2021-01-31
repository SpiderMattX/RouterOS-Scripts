:local months {"jan"="01";"feb"="02";"mar"="03";"apr"="04";"may"="05";"jun"="06";"jul"="07";"aug"="08";"sep"="09";"oct"=10;"nov"=11;"dec"=12}
:local fullDate [/system clock get date]
:local fullTime [/system clock get time]
:local dateTime { "fullDate"=$fullDate ; "fullTime"=$fullTime ; month=[ :pick $fullDate 0 3 ] ; mm=0 ; day=[ :pick $fullDate 4 6 ] ; year=[ :pick $fullDate 7 11 ] ; hour=[ :pick $fullTime 0 2 ] ; hh=[ :pick $fullTime 0 2 ] ; minute=[ :pick $fullTime 3 5 ] ; second=[ :pick $fullTime 6 8 ] ; meridiem="AM" }

:local month ($dateTime->"month")

:set ($dateTime->"mm") ($months->$month)

:if ($dateTime->"hour" > 12) do={
	:set ($dateTime->"meridiem") "PM"
	:set ($dateTime->"hh") (($dateTime->"hour") - 12)
}

:return ($dateTime)
