
:: Dev tools 

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

::Timeout / t 30

choco install git -fy 

::Timeout / t 15

choco install nodejs.install -fy 

::Timeout / t 45


choco install yarn -fy 

::Timeout / t 45



::git from repos after changing to script directory

cd /D %~dp0


start /wait cmd.exe /c "git clone https://github.com/irontiga/qortal-ui" 

start /wait cmd.exe /c "git clone https://github.com/frag-crypto/frag-default-plugins" 

start /wait cmd.exe /c "git clone https://github.com/frag-crypto/frag-core" 

start /wait cmd.exe /c "git clone https://github.com/frag-crypto/frag-qortal-crypto" 

::yarn install and link files 
cd /D %~dp0
cd frag-core
::start /wait cmd.exe /c  "yarn install" 
::start /wait cmd.exe /c  "yarn link"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn install"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn unlink"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn link"

cd /D %~dp0
cd frag-default-plugins
::start /wait cmd.exe /c "yarn install" 
::start /wait cmd.exe /c "yarn link"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn install"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn unlink"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn link"
cd /D %~dp0
cd frag-qortal-crypto
::start /wait cmd.exe /c "yarn install" 
::start /wait cmd.exe /c "yarn link"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn install"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn unlink"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn link"
cd /D %~dp0
cd qortal-ui
::start /wait cmd.exe /c "yarn link @frag-crypto/frag-core" 
::start /wait cmd.exe /c "yarn link @frag-crypto/frag-default-plugins"
::start /wait cmd.exe /c "yarn link @frag-crypto/frag-qortal-crypto"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn link @frag-crypto/frag-core"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn link @frag-crypto/frag-default-plugins"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn link @frag-crypto/frag-qortal-crypto"
::start /wait cmd.exe /c "yarn run build" 
@powershell -NoProfile -ExecutionPolicy Bypass -Command "yarn run build"
sleep 10
start cmd.exe /k "yarn run server"
exit

