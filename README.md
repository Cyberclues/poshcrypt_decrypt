# poshcrypt_decrypt
Decryption Script for Powershell Ransomware fed from 21e1a87bd0418381a1bc8df088ee5c91.

Modified to allow arbitrary salt via cmd line (ref change in 9fe45fc4c402932248cd2c26b65f883d)


Decrypt script for flawed encryptor 'ransomware' powershell script being delivered by the above CHM. For details (including how to identify salt value) see: http://blog.malwareclipboard.com/2015/09/how-to-fail-at-ransomware.html


Usage: Powershell.exe -ExecutionPolicy Bypass -file poshcrypt_decrypt.ps1 -filename \<encrypted_file\> -origsalt \<salt from encrypt/ransom script\>


