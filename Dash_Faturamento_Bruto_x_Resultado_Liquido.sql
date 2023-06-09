SELECT DISTINCT
TO_CHAR(LAN.DTMOV,'YYYY') ANO,
TO_CHAR(LAN.DTMOV,'MM') MES,
TO_CHAR(LAN.DTMOV,'MM-YYYY') EXERCICIO,



SUM(CASE WHEN LAN.TIPLANC='R' THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D' THEN -1*LAN.VLRLANC END) RESULTADO_LIQUIDO,
SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (508,714) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (508,714) THEN -1*LAN.VLRLANC END) RECEITA_BRUTO,
SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (534,535,536,537,538,539,540,541,544,547) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (534,535,536,537,538,539,540,541,544,547) THEN -1*LAN.VLRLANC END) DEDUCOES,



((SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (508,714) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (508,714) THEN -1*LAN.VLRLANC END))+
(SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (534,535,536,537,538,539,540,541,544,547) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (534,535,536,537,538,539,540,541,544,547) THEN -1*LAN.VLRLANC END))) REC_OPER_LIQ,

SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (551) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (551) THEN -1*LAN.VLRLANC END) CPV,

(((SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (508,714) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (508,714) THEN -1*LAN.VLRLANC END))+ --RECEITA BRUTA
(SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (534,535,536,537,538,539,540,541,544,547) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (534,535,536,537,538,539,540,541,544,547) THEN -1*LAN.VLRLANC END)))+ --DEDUCOES
(SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (551) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (551) THEN -1*LAN.VLRLANC END)))  RESULTADO_BRUTO, --CPV 

(((


(CASE WHEN TO_CHAR(LAN.DTMOV,'MM-YYYY') = TO_CHAR(SYSDATE,'MM-YYYY') 
THEN 
--CUSTO FIXO PARCIAL
(((LAG(
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END),1) OVER (ORDER BY TO_CHAR(LAN.DTMOV,'YYYY') ASC, TO_CHAR(LAN.DTMOV,'MM') ASC)*-1)+
(LAG(
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END),2) OVER (ORDER BY TO_CHAR(LAN.DTMOV,'YYYY') ASC, TO_CHAR(LAN.DTMOV,'MM') ASC)*-1)+
(LAG(
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END),3) OVER (ORDER BY TO_CHAR(LAN.DTMOV,'YYYY') ASC, TO_CHAR(LAN.DTMOV,'MM') ASC)*-1))/3*-1) 


ELSE
--CUSTO FIXO FECHADO
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END)


END)



/
(SUM((CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (508,714) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (508,714) THEN -1*LAN.VLRLANC END))))*-1)*100) CUSTO_PART_PERC,



(CASE WHEN TO_CHAR(LAN.DTMOV,'MM-YYYY') = TO_CHAR(SYSDATE,'MM-YYYY') 
THEN 'PARCIAL' ELSE 'FECHADO' END) T,

(CASE WHEN TO_CHAR(LAN.DTMOV,'MM-YYYY') = TO_CHAR(SYSDATE,'MM-YYYY') 
THEN 
--CUSTO FIXO PARCIAL
(((LAG(
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END),1) OVER (ORDER BY TO_CHAR(LAN.DTMOV,'YYYY') ASC, TO_CHAR(LAN.DTMOV,'MM') ASC)*-1)+
(LAG(
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END),2) OVER (ORDER BY TO_CHAR(LAN.DTMOV,'YYYY') ASC, TO_CHAR(LAN.DTMOV,'MM') ASC)*-1)+
(LAG(
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END),3) OVER (ORDER BY TO_CHAR(LAN.DTMOV,'YYYY') ASC, TO_CHAR(LAN.DTMOV,'MM') ASC)*-1))/3*-1) 
ELSE
--CUSTO FIXO FECHADO
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END)
END) CUSTO_FIXO,




(((((SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (508,714) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (508,714) THEN -1*LAN.VLRLANC END))+
(SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (534,535,536,537,538,539,540,541,544,547) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (534,535,536,537,538,539,540,541,544,547) THEN -1*LAN.VLRLANC END)))+
(SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (551) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (551) THEN -1*LAN.VLRLANC END)))) /
(SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (508,714) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (508,714) THEN -1*LAN.VLRLANC END)))*100 MARGEM_BRUTA,


((SUM(CASE WHEN LAN.TIPLANC='R' THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D' THEN -1*LAN.VLRLANC END))/
(SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (508,714) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (508,714) THEN -1*LAN.VLRLANC END)))*100 MARGEM_LIQ




FROM TCBLAN LAN
INNER JOIN TCBPLA PLA ON LAN.CODCTACTB = PLA.CODCTACTB
WHERE 
LAN.CODEMP = :P_EMPRESA
AND LPAD(PLA.CTACTB,1) IN (3,5)
AND PLA.ANALITICA = 'S'

GROUP BY
TO_CHAR(LAN.DTMOV,'YYYY'),
TO_CHAR(LAN.DTMOV,'MM'),
TO_CHAR(LAN.DTMOV,'MM-YYYY')

ORDER BY
1,2
