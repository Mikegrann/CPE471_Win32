@echo off

if "%VS110COMNTOOLS%" NEQ "" (
   echo "Configuring Visual Studio 2012 Environment"
   CALL "%VS110COMNTOOLS%VsDevCmd.bat" 
   if %ERRORLEVEL% GEQ 1 GOTO error_failure
) else ( 
   if "%VS120COMNTOOLS%" NEQ "" ( 
      echo "Configuring Visual Studio 2012 Environment"
      CALL "%VS120COMNTOOLS%VsDevCmd.bat" 
      if %ERRORLEVEL% GEQ 1 GOTO error_failure
   ) 
)

MD Build
CD Build
cmake ../Src

goto end

:error_failure
echo "ERROR DETECTED: ABORTING"
goto end

:end
PAUSE