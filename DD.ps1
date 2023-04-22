
Push-Location

[string] $source = "$HOME\source\repos\inactive\fTetWild"
[string] $ip     = "$HOME\source\libraries\ftetwild\bin\"   | Resolve-Path

[string] $inc     = "$HOME\source\libraries\ftetwild\include\floattetwild\"   | Resolve-Path
Set-Location $source

MSBuild.exe ./build/FloatTetwild.vcxproj /p:Configuration=Debug
Copy-Item -Path build/Debug/FloatTetwild.dll -Destination "$ip" -Verbose
Copy-Item -Path build/Debug/FloatTetwild.lib -Destination "$ip" -Verbose
Copy-Item -Path build/Debug/FloatTetwild.pdb -Destination "$ip" -Verbose

Copy-Item -Path src/FloatTetwild.h -Destination "$inc" -Verbose
Pop-Location

