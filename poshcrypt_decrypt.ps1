param([string]$filename = $(Throw "Argument 'filename' required."), [string]$origsalt = $(Throw "Argument 'origsalt' required.  Obtain from line 7 of encryption script."))
[Reflection.Assembly]::LoadWithPartialName('System.Security')|Out-Null
$PASSWORD = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("R2hjalJzaG5jckhoamp2aHRoamh2UnNqanZSaHNqanZ2cmhqc2RqY2o="));
[byte[]]$var2=[system.Text.Encoding]::Unicode.GetBytes($PASSWORD)
$SALT = [Text.Encoding]::UTF8.GetBytes($origsalt)
$RijndaelManaged_Var = new-Object System.Security.Cryptography.RijndaelManaged
$RijndaelManaged_Var.Key = (new-Object Security.Cryptography.Rfc2898DeriveBytes $PASSWORD, $SALT, 5).GetBytes(32)
$RijndaelManaged_Var.IV = (new-Object Security.Cryptography.SHA1Managed).ComputeHash([Text.Encoding]::UTF8.GetBytes("XlowQsiRsKORgfRjBMPLmCamEMyFRlWfsgTgh") )[0..15]
$RijndaelManaged_Var.Padding="Zeros"
$RijndaelManaged_Var.Mode="CBC"
try{

  $binReader = New-Object System.IO.BinaryReader([System.IO.File]::Open($filename, [System.IO.FileMode]::Open, [System.IO.FileAccess]::ReadWrite, [System.IO.FileShare]::Read),[System.Text.Encoding]::ASCII)
  if ($binReader.BaseStream.Length -lt 42880){
    $binReader_flen = $binReader.BaseStream.Length
  }
  else
  {
    $binReader_flen = 42880
  }

  $varx = $binReader.ReadBytes($binReader_flen)
  
  $binReader.Close()
  $Rijn_Decryptor = $RijndaelManaged_Var.CreateDecryptor()
  $memStream = new-Object IO.MemoryStream
  $cryptoStream = new-Object Security.Cryptography.CryptoStream $memStream,$Rijn_Decryptor,"Write"
  $cryptoStream.Write($varx, 0,$varx.Length)
  $cryptoStream.Close()
  $memStream.Close()
  $Rijn_Decryptor.Clear()
  $memStream_Array = $memStream.ToArray()
  $binWriter = New-Object System.IO.BinaryWriter([System.IO.File]::Open($filename, [System.IO.FileMode]::Open, [System.IO.FileAccess]::ReadWrite, [System.IO.FileShare]::Read),[System.Text.Encoding]::ASCII)
  
  $binWriter.Write($memStream_Array,0,$memStream_Array.Length)
  
  $binWriter.Close()
}
catch
{

}
