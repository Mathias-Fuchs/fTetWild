
$ErrorActionPreference = "Stop"
[string] $sourcedir = "$HOME\source\repos\inactive\fTetWild" | Resolve-Path
[string] $invaliddir = "$HOME\source\repos\isInvalid" | Resolve-Path
[string] $ip = "$HOME\source\libraries\ftetwild\bin\" | Resolve-Path
[string] $inc = "$HOME\source\libraries\ftetwild\include\floattetwild\" | Resolve-Path

. "$invaliddir\makePowershell64DevPowershell.ps1"
Set-Location $sourcedir
MSBuild.exe ./build/FloatTetwild.vcxproj /p:Configuration=RelWithDebInfo /p:Platform=x64

Copy-Item -Path "$sourcedir\build\RelWithDebInfo\FloatTetwild.dll" -Destination "$ip" -Verbose
Copy-Item -Path "$sourcedir\build\RelWithDebInfo\FloatTetwild.lib" -Destination "$ip" -Verbose
Copy-Item -Path "$sourcedir\build\RelWithDebInfo\FloatTetwild.pdb" -Destination "$ip" -Verbose

Copy-Item -Path src/FloatTetwild.h -Destination "$inc" -Verbose
Copy-Item -Path src/Types.hpp -Destination "$inc" -Verbose
Copy-Item -Path src/Parameters.h -Destination "$inc" -Verbose



Pop-Location

