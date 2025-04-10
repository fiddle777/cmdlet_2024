<#
.SYNOPSIS
    Displays main hardware component information.<br>
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
