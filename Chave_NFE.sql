SELECT 
FIN.DTVENC,
CHAVENFE
FROM TGFCAB CAB
INNER JOIN TGFFIN FIN ON CAB.NUMNOTA = FIN.NUMNOTA
WHERE 
CHAVENFE <>0
AND DHBAIXA IS NULL
AND RECDESP = 1
AND (DTVENC >= '01/11/2023' AND DTVENC <= '30/04/2024')
ORDER BY 1
