select a.codcli,d.cliente ,a.numnota, a.data, a.dtfat, b.codprod, 
c.descricao ,b.qt,c.embalagem ,c.UNIDADE
 from pcpedc a, pcpedi b, pcprodut c, pcclient d where 
a.codcli=d.codcli and
b.codprod=c.codprod and a.numped=b.numped and

 a.numnota in (:numnota);