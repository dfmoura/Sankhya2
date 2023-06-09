SELECT DISTINCT
LPAD(PLA.CTACTB,10)E,
CASE WHEN LPAD(PLA.CTACTB,1) = 3 THEN '5.03.01.01.0003' ELSE PLA.CTACTB END AS N,
PLA.CODCTACTB,
PLA.CTACTB,
PLA.DESCRCTA,
SUM(CASE WHEN LAN.TIPLANC='R' THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D' THEN -1*LAN.VLRLANC END) VLRLANC,
SUM(SUM(CASE WHEN LAN.TIPLANC='R' THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D' THEN -1*LAN.VLRLANC END)) OVER 
(ORDER BY 2,3 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS VARLANC_ACC,


SUM(CASE WHEN LAN.TIPLANC='R' THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D' THEN -1*LAN.VLRLANC END)/
(SELECT DISTINCT
SUM(SUM(CASE WHEN LAN.TIPLANC='R' THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D' THEN -1*LAN.VLRLANC END)) OVER 
(ORDER BY 2,3 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
FROM TCBLAN LAN INNER JOIN TCBPLA PLA ON LAN.CODCTACTB = PLA.CODCTACTB
WHERE (LAN.DTMOV >= :P_PERIODO.INI AND LAN.DTMOV <= :P_PERIODO.FIN)
AND LPAD(PLA.CTACTB,1) IN (3,5) AND PLA.ANALITICA = 'S' AND PLA.CODCTACTB IN (508,714)) AV_PERC,

(SELECT DISTINCT
SUM(SUM(CASE WHEN LAN.TIPLANC='R' THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D' THEN -1*LAN.VLRLANC END)) OVER 
(ORDER BY 2,3 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
FROM TCBLAN LAN INNER JOIN TCBPLA PLA ON LAN.CODCTACTB = PLA.CODCTACTB
WHERE (LAN.DTMOV >= :P_PERIODO.INI AND LAN.DTMOV <= :P_PERIODO.FIN)
AND LPAD(PLA.CTACTB,1) IN (3,5) AND PLA.ANALITICA = 'S' AND PLA.CODCTACTB IN (508,714))aaa



FROM TCBLAN LAN
INNER JOIN TCBPLA PLA ON LAN.CODCTACTB = PLA.CODCTACTB
WHERE (LAN.DTMOV >= :P_PERIODO.INI AND LAN.DTMOV <= :P_PERIODO.INI)
AND LPAD(PLA.CTACTB,1) IN (3,5)
AND PLA.ANALITICA = 'S'
GROUP BY
PLA.CODCTACTB,
PLA.CTACTB,
PLA.DESCRCTA,
LPAD(PLA.CTACTB,10),
CASE WHEN LPAD(PLA.CTACTB,1) = 3 THEN '5.03.01.01.0003' ELSE PLA.CTACTB END
ORDER BY 2,3