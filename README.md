# setup-workstation
Sets the workstation for the trainee up.

## run
Running as Admin will skip UAC confirmation.

### cloning the repository
```cmd
git clone https://github.com/trainee-tasks/setup-workstation.git
.\setup-workstation\setup.ps1
```

### running directly the script without cloning repository
```
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/trainee-tasks/setup-workstation/main/setup.ps1" -UseBasicParsing).Content
```