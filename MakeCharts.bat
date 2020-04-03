@echo off
setlocal enableextensions enabledelayedexpansion

echo %~n0 processing XML files.
set /a count=0
for %%I IN (XMLCharts\*.xml) DO (
  msxsl "%%~fI" jambrl.xsl -o "HTMCharts\\%%~nI.htm"
  set /a count +=1
  echo !count! %%~nI
)
echo %count% files processed
endlocal