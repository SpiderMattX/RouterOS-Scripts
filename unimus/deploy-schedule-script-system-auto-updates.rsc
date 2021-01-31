/system scheduler remove update-software1;
/system scheduler remove update-software2;
/system scheduler remove update-software3;
/system scheduler remove update-software4;
/system scheduler add name="update-software1" comment="Executes update-software script." start-date="feb/01/2021" start-time="03:00:00" policy="read,write,reboot,test,ftp,sensitive,policy" on-event=update-software
/system scheduler add name="update-software2" comment="Executes update-software script." start-date="feb/01/2021" start-time="03:03:00" policy="read,write,reboot,test,ftp,sensitive,policy" on-event=update-software
/system scheduler add name="update-software3" comment="Executes update-software script." start-date="feb/01/2021" start-time="03:06:00" policy="read,write,reboot,test,ftp,sensitive,policy" on-event=update-software
/system scheduler add name="update-software4" comment="Executes update-software script." start-date="feb/01/2021" start-time="03:09:00" policy="read,write,reboot,test,ftp,sensitive,policy" on-event=update-software
