<#  
.SYNOPSIS  
    Displays main hardware component information.  
.DESCRIPTION  
    Get-HardwareCustom gathers and displays information about the CPU, GPU, RAM and Disk drives in the system.<br>
    Output can be customized based on the specified detail level: Basic, Detailed, NameOnly.   <br>
    Optional switch parameter allows to retrieve a more accurate VRAM number, collected using seperate functions, the default option may display an inaccurate VRAM number due to how the CimInstance command works  <br>
.PARAMETER DetailLevel<br>
    Specifies the level of detail for the output. Options are:<br>
    - Basic: Displays essential information.<br>
    - Detailed: Displays all available properties of the hardware components.<br>
    - NameOnly: Displays only the names of the hardware components.<br>
.PARAMETER RealVRAM<br>
    A switch parameter that, when specified, retrieves more accurate VRAM information from the <br>
    system registry instead of using the default AdapterRAM value.<br>
.EXAMPLE<br>
    Get-HardwareCustom -DetailLevel Basic<br>
    Retrieves basic information about the hardware components.<br>
.EXAMPLE<br>
    Get-HardwareCustom -DetailLevel Detailed<br>
    Retrieves detailed information about the hardware components.<br>
.EXAMPLE<br>
    Get-HardwareCustom -DetailLevel NameOnly<br>
    Displays only the names of the CPU, GPU, RAM, and Disk drives.<br>
.EXAMPLE<br>
    Get-HardwareCustom -DetailLevel Basic -RealVRAM<br>
    Retrieves basic hardware information and accurate VRAM for the GPU.<br>
.NOTES<br>
    Author: [Deividas Narbutas PRIF 23/4]<br>
    Date: [2024-10-29]<br>
    Version: [0.0.1]<br>
#>
