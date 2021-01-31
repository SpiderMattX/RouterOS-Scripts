:local getCurrentDateTime [:parse [/system script get func_getCurrentDateTime source]]
:local dateTime [$getCurrentDateTime]
:return (($dateTime->"hh") . ":" . ($dateTime->"minute") . ":" . ($dateTime->"second") . " " . ($dateTime->"meridiem"))
