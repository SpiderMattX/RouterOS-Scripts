# RouterOS-Scripts
This repository is a library of sorts for a number of RouterOS scripting functions and automation scripts.

## Shared Functions
There are a number of shared functions available to be imported into other scripts. The following are the currently available functions;

### func_formatDate
This function returns a formatted date string (YYYY-MM-DD) using func_getCurrentDateTime for a time source.

### func_formatDateTime
This function returns a formatted date and time string (YYYY-MM-DD @ HH:MM:SS M) func_getCurrentDateTime for a time source.

### func_formatTime
This function returns a formatted time string (HH:MM:SS M) using func_getCurrentDateTime for a time source.

### func_getCurrentDateTime
This function returns an array containing named elements holding the various date and time components of the current time.

### func_parseVersionString
This function returns an array containing named elements holding the various components of the given software version string.

## Automation Scripts

### System / Auto-Update
This script handles the two-step process of updating a RouterOS device to a different software version. This script accounts for the differing process of upgrading vs downgrading. All you have to do is set the desired version in the script. Then schedule this script to run at least two times, with a 2 - 3 minute buffer depending on it's Internet connection speed.

### Tools / Automatic-BTest
This script executes 4 sequential BTests to the default gateway. It tests TCP downstream, TCP upstream, UDP downstream, and UDP upstream. It logs the results for each test execution to the system log immediately following test completion. This can be useful for automatic link testing by using the scheduler to execute this test.
