:local getCurrentDateTime [:parse [/system script get func_getCurrentDateTime source]]
:local dateTime [$getCurrentDateTime]
:return (($dateTime->"year") . "-" . ($dateTime->"mm") . "-" . ($dateTime->"day") . " @ " . ($dateTime->"hh") . ":" . ($dateTime->"minute") . ":" . ($dateTime->"second") . " " . ($dateTime->"meridiem"))
