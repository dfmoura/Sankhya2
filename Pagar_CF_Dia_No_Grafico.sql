WITH CUSTO_FIXO AS (

SELECT DISTINCT
TO_CHAR(LAN.DTMOV,'YYYY') ANO,
TO_CHAR(LAN.DTMOV,'MM') MES,
TO_CHAR(LAN.DTMOV,'MM-YYYY') EXERCICIO,

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
END) CUSTO_FIXO

FROM TCBLAN LAN
INNER JOIN TCBPLA PLA ON LAN.CODCTACTB = PLA.CODCTACTB
WHERE 
LAN.CODEMP = 60
AND LPAD(PLA.CTACTB,1) IN (3,5)
AND PLA.ANALITICA = 'S'

GROUP BY
TO_CHAR(LAN.DTMOV,'YYYY'),
TO_CHAR(LAN.DTMOV,'MM'),
TO_CHAR(LAN.DTMOV,'MM-YYYY')

ORDER BY
1,2)






SELECT DISTINCT
LAN.DTMOV,
TO_CHAR(LAN.DTMOV,'MM-YYYY')EXERCICIO,
--LPAD(PLA.CTACTB,10)E,
--CASE WHEN LPAD(PLA.CTACTB,1) = 3 THEN '5.03.01.01.0003' ELSE PLA.CTACTB END AS N,
--PLA.CODCTACTB,
--PLA.CTACTB,
--PLA.DESCRCTA,
SUM(CASE WHEN LAN.TIPLANC='R' THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D' THEN -1*LAN.VLRLANC END) VLRLANC,

SUM(SUM(CASE WHEN LAN.TIPLANC='R' THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D' THEN -1*LAN.VLRLANC END)) OVER 
(ORDER BY 2,3 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS VARLANC_ACC


FROM TCBLAN LAN
INNER JOIN TCBPLA PLA ON LAN.CODCTACTB = PLA.CODCTACTB
WHERE (TO_CHAR(LAN.DTMOV,'MM-YYYY') = '04-2023')
AND LPAD(PLA.CTACTB,1) IN (3,5)
AND PLA.ANALITICA = 'S'
AND LAN.CODEMP = 60
GROUP BY
LAN.DTMOV
ORDER BY 1