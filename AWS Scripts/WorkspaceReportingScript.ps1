$workspaces = Get-WKSWorkspace
$bundles = Get-WKSWorkspaceBundle
$directories = Get-WKSWorkspaceDirectories
$table = @()
$timeTable = @()

foreach($workspace in $workspaces)
{

    $table += [pscustomobject]@{
       
        "Bundle" = foreach($bundle in $bundles){ if($bundle.BundleID -eq $workspace.BundleID){ $bundle.Name } }
        "Username" = $Workspace.UserName
        "Directory" = foreach($directory in $directories){ if($directory.DirectoryID -eq $workspace.DirectoryId){ $directory.DirectoryName } }


    }
}





foreach($workspace in $workspaces)

{

    if($workspace.BundleId -like "wsb-c1pmc8106")
    {
  $timeTable += (Get-WKSWorkspacesConnectionStatus -WorkspaceId $workspace.WorkspaceId )
    

    }


}
