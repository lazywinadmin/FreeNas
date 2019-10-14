﻿function Get-FreeNasIscsiTarget
{
    Param
    ( )


    Begin
    {
        Get-FreeNasStatus
        switch ( $Script:status)
        {
            $true { }
            $false { Break }
        }


    }
    Process
    {
        $Uri = "api/v1.0/services/iscsi/target/"

        try { $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get }

        Catch { throw }

        $FreenasIscsiTarget = New-Object System.Collections.ArrayList
        for ($i = 0; $i -lt $result.Count; $i++)
        {
            $temp = New-Object System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].Id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Target_Alias" -Value "$($result[$i].iscsi_target_alias)"
            $temp | Add-Member -MemberType NoteProperty -Name "Target_Name" -Value "$($result[$i].iscsi_target_name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Target_Mode" -Value "$($result[$i].iscsi_target_mode)"

            $FreenasIscsiTarget.Add($temp) | Out-Null
        }


        return $FreenasIscsiTarget
    }
    End
    { }
}
