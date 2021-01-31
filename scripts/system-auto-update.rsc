:local config { "targetVersion"="6.47.4"; architecture=[/system resource get architecture-name]; "packageURL"="" }

:local parseVersionString [:parse [/system script get func_parseVersionString source]]

:local packageVersion "$[/system package get system version]"
:local routerBoardVersion "$[/system routerboard get current-firmware]"

:local packageMeta [$parseVersionString $packageVersion]
:local routerBoardMeta [$parseVersionString $routerBoardVersion]
:local targetMeta [$parseVersionString ($config->"targetVersion")]

:set ($config->"packageURL") ("https://download.mikrotik.com/routeros/" . ($config->"targetVersion") . "/routeros-" . ($config->"architecture") . "-" . ($config->"targetVersion") . ".npk")

if (($packageMeta->"full") != ($targetMeta->"full")) do={
	:log info ("System/Auto-Update: Package version (" . ($packageMeta->"full") . ") does not match target version (" . ($targetMeta->"full") . "). Downloading package file from " . ($config->"packageURL") .".")
	/tool fetch url=($config->"packageURL");

	if (($packageMeta->"major") > ($targetMeta->"major") || ($packageMeta->"minor") > ($targetMeta->"minor") || ($packageMeta->"patch") > ($targetMeta->"patch")) do={
		:log info ("System/Auto-Update: Target package version (" . ($targetMeta->"full") . ") is older than current package version (" . ($packageMeta->"full") . "). Executing downgrade...");
		/system package downgrade;
	} else={
		:log info ("System/Auto-Update: Target package version (" . ($targetMeta->"full") . ") is newer than current package version (" . ($packageMeta->"full") . "). Executing upgrade...");
		/system reboot;
	}
} else={
	if (($routerBoardMeta->"full") != ($packageMeta->"full")) do={
		:log info ("System/Auto-Update: RouterBoard firmware (" . ($routerBoardMeta->"full") . ") does not match target version (" . ($targetMeta->"full") . "). Executing update...");
		/system routerboard upgrade;
		/system reboot;
	} else={
		:log info ("System/Auto-Update: Software and firmware currently match target version (" . ($targetMeta->"full") . "). No changes necessary.");
	}
}

