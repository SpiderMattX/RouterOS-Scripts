/system script remove system-auto-update;
/system script add name="system-auto-update" policy=read,write,reboot,test,ftp,sensitive,policy comment="System/Auto-Update Package / Firmware Manager" source=":local config { \"targetVersion\"=\"6.46.8\"; architecture=[/system resource get architecture-name]; \"packageURL\"=\"\" };\n:local parseVersionString [:parse [/system script get func_parseVersionString source]];\n:local packageVersion \"\$[/system package get system version]\";\n:local routerBoardVersion \"\$[/system routerboard get current-firmware]\";\n:local packageMeta [\$parseVersionString \$packageVersion];\n:local routerBoardMeta [\$parseVersionString \$routerBoardVersion];\n:local targetMeta [\$parseVersionString (\$config->\"targetVersion\")];\n:set (\$config->\"packageURL\") (\"https://download.mikrotik.com/routeros/\" . (\$config->\"targetVersion\") . \"/routeros-\" . (\$config->\"architecture\") . \"-\" . (\$config->\"targetVersion\") . \".npk\");\nif ((\$packageMeta->\"full\") != (\$targetMeta->\"full\")) do={\n	:log info (\"System/Auto-Update: Package version (\" . (\$packageMeta->\"full\") . \") does not match target version (\" . (\$targetMeta->\"full\") . \"). Downloading package file from \" . (\$config->\"packageURL\") .\".\");\n	/tool fetch url=(\$config->\"packageURL\");\n	if ((\$packageMeta->\"major\") > (\$targetMeta->\"major\") || (\$packageMeta->\"minor\") > (\$targetMeta->\"minor\") || (\$packageMeta->\"patch\") > (\$targetMeta->\"patch\")) do={\n		:log info (\"System/Auto-Update: Target package version (\" . (\$targetMeta->\"full\") . \") is older than current package version (\" . (\$packageMeta->\"full\") . \"). Executing downgrade...\");\n		/system package downgrade;\n	} else={\n		:log info (\"System/Auto-Update: Target package version (\" . (\$targetMeta->\"full\") . \") is newer than current package version (\" . (\$packageMeta->\"full\") . \"). Executing upgrade...\");\n		/system reboot;\n	};\n} else={\n	if ((\$routerBoardMeta->\"full\") != (\$packageMeta->\"full\")) do={\n		:log info (\"System/Auto-Update: RouterBoard firmware (\" . (\$routerBoardMeta->\"full\") . \") does not match target version (\" . (\$targetMeta->\"full\") . \"). Executing update...\");\n		/system routerboard upgrade;\n		/system reboot;\n	} else={\n		:log info (\"System/Auto-Update: Software and firmware currently match target version (\" . (\$targetMeta->\"full\") . \"). No changes necessary.\");\n	};\n};\n"