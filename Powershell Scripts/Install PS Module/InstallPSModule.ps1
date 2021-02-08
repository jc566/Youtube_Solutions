function InstallPSModule
{
    param(
        [string]$moduleName,
        [string]$scope
    )
    try
    {
        if(Get-Module -ListAvailable -Name $moduleName)
        {
            Import-Module $moduleName
        }
        else
        {
            Install-Module $moduleName -Scope $scope -Force -AllowClobber

            Import-Module $moduleName
        }
    }
    catch [Exception]
    {
        write-host $_.Exception.Message
    }
    catch
    {
        write-host "$($moduleName) was not found and was unable to be installed"
    }
    finally
    {
        write-host "Completed $($moduleName) Check/Installation"
    }
}

InstallPSModule -moduleName "" -scope ""