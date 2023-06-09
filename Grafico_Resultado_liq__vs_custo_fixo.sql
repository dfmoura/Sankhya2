SELECT DISTINCT
LAN.DTMOV,
SUM(CASE WHEN LAN.TIPLANC='R' THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D' THEN -1*LAN.VLRLANC END) VLRLANC,

SUM(SUM(CASE WHEN LAN.TIPLANC='R' THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D' THEN -1*LAN.VLRLANC END)) OVER 
(ORDER BY 2,3 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS VARLANC_ACC,

(SUM(
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END)
) OVER 
(ORDER BY 2,3 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))*-1 CUSTO_FIXO_ACC

FROM TCBLAN LAN
INNER JOIN TCBPLA PLA ON LAN.CODCTACTB = PLA.CODCTACTB
WHERE (TO_CHAR(LAN.DTMOV,'MM-YYYY') = :P_EXERCICIO)
AND LPAD(PLA.CTACTB,1) IN (3,5)
AND PLA.ANALITICA = 'S'
AND LAN.CODEMP = :P_EMPRESA
GROUP BY
LAN.DTMOV
ORDER BY 1