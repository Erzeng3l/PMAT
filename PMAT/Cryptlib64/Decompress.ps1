$base64data = "insert compressed and base64 data here"
$data = [System.Convert]::FromBase64String($base64data)
$ms = New-Object System.IO.MemoryStream
$ms.Write($data, 0, $data.Length)
$ms.Seek(0, [System.IO.SeekOrigin]::Begin) | Out-Null

$deflateStream = New-Object System.IO.Compression.DeflateStream($ms, [System.IO.Compression.CompressionMode]::Decompress)
$streamReader = New-Object System.IO.StreamReader($deflateStream, [System.Text.Encoding]::UTF8) # Use the appropriate encoding

$allText = $streamReader.ReadToEnd()

$streamReader.Close()
$deflateStream.Close()
$ms.Close()

# Remove null bytes (0x00) from the decoded text
$allText = $allText -replace "\x00", ""

$allText
