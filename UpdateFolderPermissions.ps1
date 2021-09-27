function TarUpdate-Permissions
{
	[CmdletBinding()]
param (

    [Parameter(Mandatory = $false, HelpMessage = "Url of the site containing the pages to modernize")]
    [string]$SourceUrl,

    [Parameter(Mandatory = $false, HelpMessage = "full filename of the permissions matrix")]
    [string]$CSVFileName = "PermissionMatrix.csv"      
)
begin
{
    Connect-PnPOnline $SourceUrl -Interactive
    $allRows = Import-Csv $CSVFileName
    foreach($row in $allRows)
    {
     $libraryName = $row.LibraryName
     $folderName = $row.LibraryName+"/"+$row.RelativePath+ "/"+ $row.FolderName
     $groupName = $row.GroupName
     $roleName = $row.permissions
     if($roleName -ne "NA")
     {
      Set-PnPFolderPermission -List $libraryName -Identity $folderName -Group $groupName -AddRole $roleName -SystemUpdate
      
    }
    }
}
}