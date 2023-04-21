
Push-Location


[string] $invaliddir = "$home\source\repos\isInvalid" | Resolve-Path
[string] $source = "$HOME\source\repos\inactive\fTetWild" | Resolve-Path
[string] $ip =  "$HOME\source\libraries\ftetwild\bin\"   | Resolve-Path
[string] $inc     = "$HOME\source\libraries\ftetwild\include\floattetwild\"   | Resolve-Path

Set-Location $source

. "$invaliddir\makePowershell64DevPowershell.ps1"
MSBuild.exe ./build/FloatTetwild.vcxproj /p:Configuration=RelWithDebInfo
Copy-Item -Path build/RelWithDebInfo/FloatTetwild.dll -Destination "$ip" -Verbose
Copy-Item -Path build/RelWithDebInfo/FloatTetwild.lib -Destination "$ip" -Verbose
Copy-Item -Path build/RelWithDebInfo/FloatTetwild.pdb -Destination "$ip" -Verbose

Copy-Item -Path src/FloatTetwild.h -Destination "$inc" -Verbose
Pop-Location

