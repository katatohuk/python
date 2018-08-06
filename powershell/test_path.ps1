# User defined variables.
$PSScriptRoot
$out8 = $PSScriptRoot + '\out8.txt'
echo $out8

#$out12 = 'T:\temp\ADPK\out12.txt'
#$out16 = 'T:\temp\ADPK\out16.txt'

if(!(Test-Path $out8))
{'doesnt exist'}
    else{'exists'}

# Lets clear out.txt file before start
#Clear-Content $out8
#Clear-Content $out12
#Clear-Content $out16