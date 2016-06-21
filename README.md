<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fwilbowaggins%2Fbi-experience-student-vm-deployment%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fwilbowaggins%2Fbi-experience-student-vm-deployment%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

To deploy DIAD, click the button above.  Make sure you deploy to Central US.  That's where all the other resources are.

There are 3 parameters.  The first asks how many student VMs you'd like.
The next is the username you'd like for the VMs.
The last is the Password.

The VMs each have a name that follows this convention:

biexpstudent[vmnumber].centralus.cloudapp.azure.com.

Open up RDS and remote the student VMs.
