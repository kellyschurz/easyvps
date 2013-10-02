easyvps
========

Easy to build vps.

Easy to make vps safly.

Content : 

1. baseenv :

   |--Build base environment.

   |--chmod 700 baseenv

   |--./baseenv

2. sshsafe (sshsafe + sshchport.sh) :

   |--Change the ssh port to 4399 and make it safly.

   |--You should record the contents of id_rsa.

   |--Check your local pc and add the id_rsa.

   |--Rename id_rsa to id_rsa_xxx.

   |--Change your ~/.ssh/config likes below about.

         Host xxx.com

         HostName xxx.com

         IdentityFile ~/.ssh/id_rsa_xxx

         User root

         Port xx

   |--chmod 700 sshsafe

   |--./sshsafe

3. autonoddos (setiptables.sh + autonoddos.sh + noddos.sh) :

   |--Be sure you are in the root's home.

   |--sh setiptables.sh

   |--sh autonoddos.sh

   |--The crond will run noddos.sh and setiptables.sh automatically.

4. selfiptables (selfiptables.sh) :

   |--Be sure you are in local environment.

   |--sh selfiptables.sh
