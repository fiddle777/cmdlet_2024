<#
.SYNOPSIS
    Displays main hardware component information.
.DESCRIPTION
    Get-HardwareCustom gathers and displays information about the CPU, GPU, RAM and Disk drives in the system.
    Output can be customized based on the specified detail level: Basic, Detailed, NameOnly. 
    Optional switch parameter allows to retrieve a more accurate VRAM number, collected using seperate functions, the default option may display an inaccurate VRAM number due to how the CimInstance command works
.PARAMETER DetailLevel
    Specifies the level of detail for the output. Options are:
    - Basic: Displays essential information.
    - Detailed: Displays all available properties of the hardware components.
    - NameOnly: Displays only the names of the hardware components.
.PARAMETER RealVRAM
    A switch parameter that, when specified, retrieves more accurate VRAM information from the 
    system registry instead of using the default AdapterRAM value.
.EXAMPLE
    Get-HardwareCustom -DetailLevel Basic
    Retrieves basic information about the hardware components.

.EXAMPLE
    Get-HardwareCustom -DetailLevel Detailed
    Retrieves detailed information about the hardware components.

.EXAMPLE
    Get-HardwareCustom -DetailLevel NameOnly
    Displays only the names of the CPU, GPU, RAM, and Disk drives.

.EXAMPLE
    Get-HardwareCustom -DetailLevel Basic -RealVRAM
    Retrieves basic hardware information and accurate VRAM for the GPU.
.NOTES
    Author: [Deividas Narbutas PRIF 23/4]
    Date: [2024-10-29]
    Version: [0.69.420]
#>
function Get-HardwareCustom{
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateSet("Basic", "Detailed", "NameOnly")][string]$DetailLevel = "Basic",
        [switch]$RealVRAM
    )
    #Helper function
    function NameLine($name){
        write-host "$name" -ForegroundColor Cyan
    }
    #Variables
        $cpu = Get-CimInstance -classname win32_processor
        $gpu = Get-CimInstance -ClassName Win32_VideoController
        $ram = Get-CimInstance -ClassName Win32_PhysicalMemory
        $disk = Get-CimInstance -ClassName Win32_DiskDrive
    write-host "----HARDWARE----" -ForegroundColor red
    #CPU data
    if ($PSCmdlet.ShouldProcess("$cpu", "Display formatted data")){
        NameLine("CPU")
        if($DetailLevel -eq "Detailed"){$cpu | Format-List -Property *}
        elseif($DetailLevel -eq "NameOnly"){write-host "$($cpu.Name)"}
        else{write-host "$($cpu.Name)`n$($cpu.numberofcores) Cores`nClock Speed: $($cpu.MaxClockSpeed) MHz"}
    }
    #GPU data
    if ($PSCmdlet.ShouldProcess("$gpu", "Display formatted data")){
        NameLine("GPU")
        if ($PSCmdlet.ShouldProcess("$VRAM", "Find Accurate VRAM")){
            $VRAM = $VRAM | foreach{ (Get-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0*" -Name HardwareInformation.qwMemorySize -ErrorAction SilentlyContinue)."HardwareInformation.qwMemorySize"}
        }
        if($DetailLevel -eq "Detailed"){$gpu | Format-List -Property *}
        elseif($DetailLevel -eq "NameOnly"){$gpu | foreach {write-host "$($gpu.Name)"}}   
        else{
            for ($i = 0; $i -lt $vram.count; $i++){ 
                write-host "$($gpu[$i].Name)"
                if($RealVRAM){write-host "VRAM: $([math]::Round($VRAM[$i] / 1MB)) MB" -ForegroundColor Green}
                else{write-host "VRAM: $([math]::Round($gpu[$i].AdapterRAM / 1MB)) MB" -ForegroundColor Red}
            }
        }
    }
    #RAM data
    if ($PSCmdlet.ShouldProcess("$ram", "Display formatted data")){
        NameLine("RAM")
        if($DetailLevel -eq "Detailed"){$ram | Format-List -Property *}
        elseif($DetailLevel -eq "NameOnly"){$ram | foreach {write-host "$($_.manufacturer)"}} 
        else{
            $ram | foreach{write-host "$($_.manufacturer) $([math]::Round($_.capacity / 1GB)) GB"}
            $totalram = ($ram | Measure-Object -Property capacity -sum).sum
            write-host "Total Capacity: $([math]::Round($totalram / 1MB)) MB"
        }
    }
    #Disk data
    if ($PSCmdlet.ShouldProcess("$disk", "Display formatted data")){
        NameLine("Disk")
        if($DetailLevel -eq "Detailed"){$disk | Format-List -Property *}
        elseif($DetailLevel -eq "NameOnly"){$disk | foreach {write-host "$($_.model)"}} 
        else{
            $disk | foreach{write-host "$($_.model) | $([math]::Round($_.size / 1GB)) GB"}
            $totaldisk = ($disk | Measure-Object -Property size -sum).sum
            write-host "Total Capacity: $([math]::Round($totaldisk / 1GB)) GB"
        }
    }
}