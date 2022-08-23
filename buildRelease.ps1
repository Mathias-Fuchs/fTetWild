
Push-Location

[string] $source = "$HOME\source\repos\inactive\fTetWild3"
[string] $ip =  "$HOME\source\libraries\ftetwild\bin\"   | Resolve-Path

Set-Location $source

MSBuild.exe ./build/FloatTetwild.vcxproj /p:Configuration=RelWithDebInfo
Copy-Item -Path build/RelWithDebInfo/FloatTetwild.dll -Destination "$ip" -Verbose
Copy-Item -Path build/RelWithDebInfo/FloatTetwild.lib -Destination "$ip" -Verbose
Copy-Item -Path build/RelWithDebInfo/FloatTetwild.pdb -Destination "$ip" -Verbose

Pop-Location

