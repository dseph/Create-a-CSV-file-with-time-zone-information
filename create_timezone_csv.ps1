
# create_timezone_csv.ps1
# Generated with Copilot.

param(
	[string]$OutputPath = (Join-Path -Path $PSScriptRoot -ChildPath "WindowsTimeZones.csv")
)

try {
	$timeZones = Get-TimeZone -ListAvailable | Sort-Object -Property Id | ForEach-Object {
		[PSCustomObject]@{
			Id                          = $_.Id
			DisplayName                 = $_.DisplayName
			StandardName                = $_.StandardName
			DaylightName                = $_.DaylightName
			BaseUtcOffset               = $_.BaseUtcOffset
			SupportsDaylightSavingTime  = $_.SupportsDaylightSavingTime 
		}
	}

	$timeZones | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
	Write-Host "Timezone CSV created: $OutputPath"
}
catch {
	Write-Error "Failed to generate timezone CSV. $($_.Exception.Message)"
	exit 1
}
    
