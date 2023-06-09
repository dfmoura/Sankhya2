SELECT DISTINCT
LAN.DTMOV,
--TO_CHAR(LAN.DTMOV,'MM-YYYY')EXERCICIO,
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