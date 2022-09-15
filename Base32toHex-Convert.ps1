#requires -version 2

#Copyright TOKEN2 Sarl
# Author EH

function Convert-HexToByteArray($hexString) {
    $byteArray = $hexString -replace '^0x', '' -split "(?<=\G\w{2})(?=\w{2})" | %{ [Convert]::ToByte( $_, 16 ) }
    return $byteArray
}

function Convert-Base32ToHex($base32) {
    $base32chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
    $bits = "";
    $hex = "";
    for ($i = 0; $i -lt $base32.Length; $i++) {
        $val = $base32chars.IndexOf($base32.Chars($i));
        $binary = [Convert]::ToString($val, 2)
        $staticLen = 5
        $padder = '0'
            # Write-Host $binary
        $bits += Add-LeftPad $binary.ToString()  $staticLen  $padder
    }

    for ($i = 0; $i+4 -le $bits.Length; $i+=4) {
        $chunk = $bits.Substring($i, 4)
        # Write-Host $chunk
        $intChunk = [Convert]::ToInt32($chunk, 2)
        $hexChunk = Convert-IntToHex($intChunk)
        # Write-Host $hexChunk
        $hex = $hex + $hexChunk
    }
    return $hex;
}

function Convert-IntToHex([int]$num) {
    return ('{0:x}' -f $num)
}

function Add-LeftPad($str, $len, $pad) {
    if(($len + 1) -ge $str.Length) {
        while (($len - 1) -ge $str.Length) {
            $str = ($pad + $str)
        }
    }
    return $str;
}


$param1=$args[0]

#Read CSV
$strings = Import-Csv $param1

$strings | ForEach-object {
$SEED = $_."secret key"
$SN = $_."serial number"
$HEX=(Convert-Base32ToHex($SEED)).ToUpper()

Write-Output "$SN $HEX"

}

