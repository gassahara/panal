#!/bin/bash
mul2=$( echo "echo" | ./stdtohex | ./stddelcar " " | ./bn2mul 1)
mulo=$mul2
n="26CA002A487D38ED0F4774C5B66746B3F9E5A8288327BA75B6818D491EE88E80C031805A7078806B16CFD855F58FAE3966FE0B8DC2DDC74C4D443889F2F34C42722C18694FCFA9E2E734E3B999BAFD46FCD1EB40DDE01ECAFB809428CBADC39ED57F567390DD5F28FE2BB6769245EE392292180B951202F442AAE162939D9F657892047EFC2BDCCC3C8878618E8A27DB569BB4DE1CE6D9BD648C187655FD2B75BF4F11478D8F0BA07711F88D5648AAEA5590C6BDF850762D3EBA6EBF031C7B1DC25D3FFFE3AAC3E020960B7CBDD875C10AA2DE538490EDA8CF30692E1AE330F60DA196D6DADA9EF567A9BF22D98ACF803AA16A1F9DFFB75F2B2408AAE6DDA610EE86323119F9D0551D88B35D3FECFD2D2B9AB7756B8CE66DB08738E9AC8A859C72B5B13BBFF6156861AD69DE9135F6174EB2C31BF2BDA552983F26A4018907782E5FEDEA6D68B9B5262B635F2548A3BBF0BACEF3728E2269AE9D6D4D74E4A6AACAF1BB8B636E3F06D2577AC946AA8F6C3BA34E6025FDC5F9A7861EDFE5DAD9AA04424D9862CFA21700DA97E1E7C2A4F0AE4D8035A6DA4BBE6A0487A237E920ABD20DE42C061B1974156ABDBEDA6D1FE86E24545BCEFFD5F98EF32C86BECE770AEA7C2453C7119AEE6CCA166662DB30A3FC3C0F3EBF6C8EF2CBEAFAEBC86FDAD3C5643C3B748838EAFABB2BC483669A3F17BB06C5A11E6242DF38A2E9A82561"
echo "$mulo^$n"
echo "ibase=16;$mulo^$n" | bc 
#while [ -n "$n" ];do
#    mulo=$(echo "$mulo" | ./bn2mul "$mul2")
#    n=$(echo "ibase=16;obase=0A;$n-1" | bc)
#    echo "."
#done
echo "-----------------"
echo $mulo