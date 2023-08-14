#!/bin/bash
while read uno;do
	pdftotext "$uno" 2>/dev/null | grep -H --color --label="{}" -inwe "$1" 
done
