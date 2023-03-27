# Script to Create DC VM

#Params
$MachineName = 'DCTest'
$VHDLocation = 'C:\ProgramData\Microsoft\Windows\Virtual Hard Disks\'
$OSDiskSize = 120gb
$StartupMemory = 4096MB
$NetworkSwitch = 'External'
$ISODiskPath = 'C:\Users\Ampic\OneDrive\Documents\ISO Images\Windows Server 2022 EVAL.iso'

#Generat VHDX Path
$Disk1Path = $VHDLocation+$MachineName+'.vhdx'

#Create VHDX
New-VHD -Dynamic -SizeBytes $OSDiskSize -Path $Disk1Path

#Create VM
$DCVM = New-VM -Name $MachineName -SwitchName $NetworkSwitch -MemoryStartupBytes $StartupMemory -Generation 2 -VHDPath $Disk1Path

#Update Processor Count to 2 cores 
Set-VMProcessor -VMName $DCVM.Name -count 2

#Connect DVD for ISO Boot
Add-VMDvdDrive -VMName $DCVM.Name -Path $ISODiskPath

#SetDVD Boot
Set-VMFirmware -VMName $DCVM.Name -FirstBootDevice (Get-VMDvdDrive -VMName $DCVM.name)

