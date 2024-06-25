@setlocal
SET DOTNET_VERSION=8.0
SET SANDBOX_FILES=C:\sandbox

pushd "%TEMP%"

REM mkdir "%ProgramFiles%\dotnet"
REM @if exist %SANDBOX_FILES%\%PROCESSOR_ARCHITECTURE%\dotnet-runtime.zip (
REM 	tar -oxzf "%SANDBOX_FILES%\%PROCESSOR_ARCHITECTURE%\dotnet-runtime.zip" -C "%ProgramFiles%\dotnet"
REM ) else (
REM 	if %PROCESSOR_ARCHITECTURE%=="ARM64" (
REM 		curl -L https://aka.ms/dotnet/%DOTNET_VERSION%/dotnet-runtime-win-arm64.zip --output dotnet-runtime.zip
REM 	) else (
REM 		curl -L https://aka.ms/dotnet/%DOTNET_VERSION%/dotnet-runtime-win-x64.zip --output dotnet-runtime.zip
REM 	)
REM 	if %errorlevel% NEQ 0 (
REM 	echo No pre-provided dotnet runtime, and failed to download.  Confirm networking is available.
REM 	goto :ERROR
REM 	)
REM 	tar -oxzf dotnet-runtime.zip -C "%ProgramFiles%\dotnet"
REM 	del dotnet-runtime.zip
REM )

REM @if exist %SANDBOX_FILES%\%PROCESSOR_ARCHITECTURE%\dotnet-sdk.zip (
REM 	tar -oxzf "%SANDBOX_FILES%\%PROCESSOR_ARCHITECTURE%\dotnet-sdk.zip" -C "%ProgramFiles%\dotnet"
REM ) else (
REM 	if %PROCESSOR_ARCHITECTURE%=="ARM64" (
REM 		curl -L https://aka.ms/dotnet/%DOTNET_VERSION%/dotnet-sdk-win-arm64.zip --output dotnet-sdk.zip
REM 	) else (
REM 		curl -L https://aka.ms/dotnet/%DOTNET_VERSION%/dotnet-sdk-win-x64.zip --output dotnet-sdk.zip
REM 	)
REM 	if %errorlevel% NEQ 0 (
REM 		echo "No pre-provided dotnet sdk, and failed to download.  Confirm networking is available."
REM 		goto ERROR
REM 	)
REM 	tar -oxzf dotnet-sdk.zip -C "%ProgramFiles%\dotnet"
REM 	del dotnet-sdk.zip
REM )

@if exist %SANDBOX_FILES%\%PROCESSOR_ARCHITECTURE%\dotnet-sdk.exe (
	"%SANDBOX_FILES%\%PROCESSOR_ARCHITECTURE%\dotnet-sdk.exe" /install /quiet /norestart
) else (
	if %PROCESSOR_ARCHITECTURE%=="ARM64" (
		curl -L https://aka.ms/dotnet/%DOTNET_VERSION%/dotnet-sdk-win-arm64.exe --output dotnet-sdk.exe
	) else (
		curl -L https://aka.ms/dotnet/%DOTNET_VERSION%/dotnet-sdk-win-x64.exe --output dotnet-sdk.exe
	)
	if %errorlevel% NEQ 0 (
		echo "No pre-provided dotnet sdk, and failed to download.  Confirm networking is available."
		goto ERROR
	)
	dotnet-sdk.exe /install /quiet /norestart
)

@endlocal
REM SETX PATH "%PATH%;%ProgramFiles%\dotnet" /M
REM SET PATH=%PATH%;%ProgramFiles%\dotnet
dotnet nuget locals all --clear
dotnet help


:ERROR

@popd
cd c:\build
start cmd /c C:\sandbox\runtest_menu.bat
