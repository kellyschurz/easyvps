easyvps
========

Easy to build vps.

Easy to make vps safly.

Content : 

1. baseenv : Build base environment.

2. sshsafe (+ sshchport.sh) : 

   |--Change the ssh port to 4399 and make it safly.

   |--You should record the contents of id_rsa.

   |--Check your local pc and add the id_rsa.

   |--Rename id_rsa to id_rsa_xxx.

   |--Change your .ssh/config likes below about.

         Host xxx.com

         IdentityFile ~/.ssh/id_rsa_xxx

         User root
