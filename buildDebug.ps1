
Push-Location

[string] $source = "$HOME\source\repos\inactive\fTetWild3"
[string] $ip =  "$HOME\source\libraries\ftetwild\bin\"   | Resolve-Path

Set-Location $source

MSBuild.exe ./build/FloatTetwild.vcxproj /p:Configuration=Debug
Copy-Item -Path build/Debug/FloatTetwild.dll -Destination "$ip" -Verbose
Copy-Item -Path build/Debug/FloatTetwild.lib -Destination "$ip" -Verbose
Copy-Item -Path build/Debug/FloatTetwild.pdb -Destination "$ip" -Verbose

Pop-Location

