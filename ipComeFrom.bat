@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

type templateA.txt > ./country.html
set n=

set tr=^<tr^>
set tre=^</tr^>
set td=^<td^>
set tde=^</td^>

for /f %%p in (ip.txt) do (
	cd html
	curl -A "Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko" -o %%p https://rdpguard.com/free-whois.aspx?ip=%%p#
	
	rem new table
	echo !tr! >> ../country.html
	
	rem type ip to table
	echo !td! >> ../country.html
	echo %%p >> ../country.html
	echo !tde! >> ../country.html
	
	rem type country to table
	echo !td! >> ../country.html
	type %%p | find "img class=""flag""" > ./temp_c.txt
	set /p s=<temp_c.txt
	
	IF !s!==!n! (
		echo xxNofind >> ../country.html
	) ELSE (
		echo !s:~19! >> ../country.html
	)
	echo !tde! >> ../country.html
	
	rem type isp to table
	echo !td! >> ../country.html
	rem type %%p | find "Abuse Email:       " > ./temp_i.txt
	type %%p | find "Abuse Email:       <a" > ./temp_i.txt
	
	set /p i=<temp_i.txt
	
	IF !i!==!n! (
		echo. >> ../country.html
	) ELSE (
		echo !i:~19! >> ../country.html
	)
	echo !tde! >> ../country.html
	
	rem end file
	echo !tre! >> ../country.html
	del %%p
	del temp_c.txt
	del temp_i.txt
	set s=
	set i=
	cd ..
)

type templateB.txt >> ./country.html

pause