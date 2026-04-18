#!/usr/bin/env python
from odf.opendocument import OpenDocumentSpreadsheet
from odf.style import (ParagraphProperties, Style, TableColumnProperties,TextProperties)
from odf.table import Table, TableCell, TableColumn, TableRow
from odf.opendocument import load
from odf.text import P
import glob
import copy

files = glob.glob('./*History*', recursive=False)
filez = glob.glob('./*_PNL*', recursive=False)
cabecera = load("cabecera.ods")
f = open("bybit.key", "w")
f.write("")
f.close
f = open("binance.key", "w")
f.write("")
f.close
campos=[]
campnl=[]
for tabli in cabecera.spreadsheet.getElementsByType(Table):
    if tabli.getAttribute("name") == "datos":
        for fili in tabli.getElementsByType(TableRow):
            if(str(fili.getElementsByType(TableCell)[0]) == "Binance"):
                f = open("binance.key", "a")
                f.write(str(fili.getElementsByType(TableCell)[1])+";"+str(fili.getElementsByType(TableCell)[2])+";"+str(fili.getElementsByType(TableCell)[3])+";\n")
                f.close()
                print(str(fili.getElementsByType(TableCell)[1])+";"+str(fili.getElementsByType(TableCell)[2])+";"+str(fili.getElementsByType(TableCell)[3])+";")
            if(str(fili.getElementsByType(TableCell)[0]) == "Bybit"):
                f = open("bybit.key", "a")
                f.write(str(fili.getElementsByType(TableCell)[1])+";"+str(fili.getElementsByType(TableCell)[2])+";"+str(fili.getElementsByType(TableCell)[3])+";\n")
                f.close()
                print(str(fili.getElementsByType(TableCell)[1])+";"+str(fili.getElementsByType(TableCell)[2])+";"+str(fili.getElementsByType(TableCell)[3])+";")
    if tabli.getAttribute("name") == "FORMATO":
        tabla = copy.deepcopy(tabli)
    if tabli.getAttribute("name") == "PARES":
        for fili in tabli.getElementsByType(TableRow):
            nom=str(fili.getElementsByType(TableCell)[0]).lower()
            i=1
            f = open(nom+"_pares.key", "w")
            f.write("")
            f.close()
            while i < len(fili.getElementsByType(TableCell)):
                f = open(nom+"_pares.key", "a")
                f.write(str(fili.getElementsByType(TableCell)[i])+";")
                f.close()
                i=i+1
            f = open(nom+"_pares.key", "a")
            f.write("\n")
            f.close()
    if tabli.getAttribute("name") == "CAMPOS":
        for fili in tabli.getElementsByType(TableRow):
            campos.append(str(fili.getElementsByType(TableCell)[0]))
    if tabli.getAttribute("name") == "CAMPNL":
        for fili in tabli.getElementsByType(TableRow):
            campnl.append(str(fili.getElementsByType(TableCell)[0]))
for fileA in filez:
    textdoc = OpenDocumentSpreadsheet() 
    table = Table(name="Futuros")
    for estilos in cabecera.styles.childNodes[:]:
        try :
            textdoc.styles.addElement(copy.deepcopy(estilos))
        except Exception as e:
            print(e)
    for tablas in cabecera.getElementsByType(Table):
        for estilo in tablas.getElementsByType(Style):
            try:
                table.addElement(copy.deepcopy(estilo))
                print(estilo)
            except Exception as e:
                print (e)
    filas=[]
    celdas=[]
    i=0
    for fila in tabla.getElementsByType(TableRow):
        print("*")
        celdas.append(fila.getElementsByType(TableCell))
        filas.append(fila)
        print(i)
        if i > 3: break
        i=i+1
            
    for columna in tabla.getElementsByType(TableColumn):
        table.addElement(copy.deepcopy(columna))
    print(fileA)
    with open(fileA) as f:
        prev=""
        fn1=0
        campnl_csv=[]
        for line in f:
            rec = line.strip().split(';')
            if fn1 == 0:
                i=0
                while i < len(campnl):
                    j=0
                    while j < len(rec):
                        print(str(campnl[i])+"=="+rec[j])
                        if(str(campnl[i])==rec[j]):
                            campnl_csv.append(j)
                            break
                        j+=1
                    i+=1
                fn1+=1
                continue
            if rec[0]!=prev:
                print("R"+rec[0]+"!="+prev)
                i=0
                while i < len(filas):
                    tr = copy.deepcopy(filas[i])
                    cols_en_blanco=0
                    for celda in tr.getElementsByType(TableCell):
                        try:
                            if(len(str(celda))<1):
                                cols_en_blanco+=1
                            else:
                                print(str(celda))
                                break
                        except Exception as e:
                            print (e)
                    print("cols en blanco: "+str( cols_en_blanco))
                    table.addElement(tr)
                    i=i+1            
                prev=rec[0]
            tr = TableRow()
            table.addElement(tr)
            tc=TableCell(value="")
            tc.addElement(P(text=""))
            j=cols_en_blanco
            while j > 0:
                tr.addElement(copy.deepcopy(tc))
                j-=1;
            j=0
            print("L"+str(len(campnl_csv)))
            while j < len(campnl_csv) and j < len(rec) :
                if(campnl_csv[j] < len(rec)) :
                    print(rec[campnl_csv[j]]+">")
                    tc = TableCell(value=rec[campnl_csv[j]])
                    tc.addElement(P(text=rec[campnl_csv[j]]))
                    tr.addElement(tc)
                j+=1
    textdoc.spreadsheet.addElement(table)
    textdoc.save(fileA.replace('PNL', '') + '.ods')

for fileA in files:
    textdoc = OpenDocumentSpreadsheet()
    table = Table(name="A1")
    for estilos in cabecera.styles.childNodes[:]:
        try :
            textdoc.styles.addElement(copy.deepcopy(estilos))
        except Exception as e:
            print(e)
    for tablas in cabecera.getElementsByType(Table):
        for estilo in tablas.getElementsByType(Style):
            try:
                table.addElement(copy.deepcopy(estilo))
                print(estilo)
            except Exception as e:
                print (e)
    filas=[]
    celdas=[]
    i=0
    for fila in tabla.getElementsByType(TableRow):
        print("*")
        celdas.append(fila.getElementsByType(TableCell))
        filas.append(fila)
        print(i)
        if i > 3: break
        i=i+1
            
    for columna in tabla.getElementsByType(TableColumn):
        table.addElement(copy.deepcopy(columna))
    print(fileA)
    with open(fileA) as f:
        prev=""
        fn1=0
        campos_csv=[]
        for line in f:
            rec = line.strip().split(';')
            if fn1 == 0:
                i=0
                while i < len(campos):
                    j=0
                    while j < len(rec):
                        print(str(campos[i])+"=="+rec[j])
                        if(str(campos[i])==rec[j]):
                            campos_csv.append(j)
                            break
                        j+=1
                    i+=1
                fn1+=1
                continue
            if rec[0]!=prev:
                print("R"+rec[0]+"!="+prev)
                i=0
                while i < len(filas):
                    tr = copy.deepcopy(filas[i])
                    cols_en_blanco=0
                    for celda in tr.getElementsByType(TableCell):
                        try:
                            if(len(str(celda))<1):
                                cols_en_blanco+=1
                            else:
                                print(str(celda))
                                break
                        except Exception as e:
                            print (e)
                    print("cols en blanco: "+str( cols_en_blanco))
                    table.addElement(tr)
                    i=i+1            
                prev=rec[0]
            tr = TableRow()
            table.addElement(tr)
            tc=TableCell(value="")
            tc.addElement(P(text=""))
            j=cols_en_blanco
            while j > 0:
                tr.addElement(copy.deepcopy(tc))
                j-=1;
            j=0
            print("L"+str(len(campos_csv)))
            while j < len(campos_csv) and j < len(rec) :
                if(campos_csv[j] < len(rec)) :
                    print(rec[campos_csv[j]]+">")
                    tc = TableCell(value=rec[campos_csv[j]])
                    tc.addElement(P(text=rec[campos_csv[j]]))
                    tr.addElement(tc)
                j+=1
    textdoc.spreadsheet.addElement(table)
    textdoc.save(fileA.replace('History', '') + '.ods')
