To deploy DIAD, clone this repository to your desktop.  This will copy code to your machine.

Next, install Azure Powershell.

Then run "deploy template.ps1" in PowerShell.  It will ask you to log in to your azure account.

There are 2 parameters.  The first asks how many student VMs you'd like.
The second asks you for a short string that will make the DNS names of the student VMs unique.  The names will come out like:

student0[uniquestring].centralus.cloudapp.azure.com.

Open up RDS and remote the student VMs.
