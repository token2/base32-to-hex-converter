# base32-to-hex-converter
A powershell script to convert files containing TOTP seeds(secrets) from base32 format to hex. The main use case is to convert Azure MFA CSV file to DUO-Compatible TOTP Import file
- The script works with Azure MFA compatible CSV files, example below:
<pre>
upn,serial number,secret key,timeinterval,manufacturer,model
upn,86546559623,JBSWY3DPEHPK3PXPJBSWY3DPEHPK3PXP,30,Token2,C301i
upn, 86546559624,NPKJBEN2OHMZEZK7YX6FP63E5UCUH6N5,30,Token2,C301i
</pre>

 - The output is the format that Duo accepts, similar to below:
<pre>86546559623 48656C6C6F21DEADBEEF48656C6C6F21DEADBEEF
86546559624 6BD49091BA71D992655FC5FC57FB64ED0543F9BD
</pre>

Usage:
In PowerShell console -
<code>.\Base32toHex-Convert.ps1 PATH_OF_CSV_FILE</code>


for example:
<code>.\Base32toHex-Convert.ps1 '.\MFA-tokens (1).csv'</code>


If you want to write results to a file, add "> Filename.txt" , like this:

<code>.\Base32toHex-Convert.ps1 '.\MFA-tokens (1).csv' > Filename.txt</code>
