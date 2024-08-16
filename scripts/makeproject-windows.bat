@echo off
cd..

echo Checking scons installation.
py -m pip install scons

echo Generating Godot Project Files and Building
scons platform=windows module_mono_enabled=yes vsproj=yes vsproj_gen_only=no dev_build=yes

echo Generating Mono Glue
.\bin\godot.windows.editor.dev.x86_64.mono.exe --headless --generate-mono-glue .\modules\mono\glue\

echo Building mono assemblies
py .\modules\mono\build_scripts\build_assemblies.py --godot-platform windows --godot-output-dir .\bin

set currentDir=%cd%
echo Adding nuget package source
dotnet nuget add source %currentDir%\bin\GodotSharp\Tools\nupkgs\ --name godot-4.3

echo Success!
