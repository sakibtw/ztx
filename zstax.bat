@echo off

:: Check if the directory C:\ProgramData\zStax exists, create if it doesn't
if not exist "C:\ProgramData\zStax" (
    mkdir "C:\ProgramData\zStax"
)

:: Check if the directory C:\ProgramData\zStax\Updates exists, create if it doesn't
if not exist "C:\ProgramData\zStax\Updates" (
    mkdir "C:\ProgramData\zStax\Updates"
)

:: Check if v1 file exists
if exist "C:\ProgramData\zStax\Updates\v1" (
    echo No update available.
) else (
    :: Create the v1 file to prevent future updates
    echo. > "C:\ProgramData\zStax\Updates\v1"

    :: Run registry tweaks
    Reg.exe Add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "RawMouseThrottleDuration" /t REG_DWORD /d "20" /f >Nul 2>&1
    Reg.exe Add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "RawMouseThrottleEnabled" /t REG_DWORD /d "1" /f >Nul 2>&1
    Reg.exe Add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "RawMouseThrottleForced" /t REG_DWORD /d "1" /f >Nul 2>&1
    Reg.exe Add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "RawMouseThrottleLeeway" /t REG_DWORD /d "0" /f >Nul 2>&1

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "PowerOffFrozenProcessors" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "EnableWerUserReporting" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "SerializeTimerExpiration" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DebugPollInterval" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "RebalanceMinPriority" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "ForceParkingRequested" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "SplitLargeCaches" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "DisableDiskCounters" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "RequireDeviceAccessCheck" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "IdleScanInterval" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "WatchdogSleepTimeout" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "WatchdogResumeTimeout" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "DisableDiskCounters" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "RequireDeviceAccessCheck" /t REG_DWORD /d 0 /f
)

:: End the script with a timeout and taskkill
echo Update Applied!
TIMEOUT /T 5
taskkill /IM powershell.exe /F
