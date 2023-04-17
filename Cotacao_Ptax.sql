SELECT 
CODMOEDA,
DTMOV,
ROUND(COTACAO,4)COTACAO,
COALESCE(LAG(COTACAO) OVER (ORDER BY DTMOV),COTACAO) LAST_DAY,
COTACAO/((COALESCE(LAG(COTACAO) OVER (ORDER BY DTMOV),COTACAO))-1) VARIACAO

FROM TSICOT
WHERE CODMOEDA IN (1,5)
AND CODMOEDA =1
AND DTMOV '14/03/2023'
ORDER BY
DTMOV