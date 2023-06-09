SELECT OPC.* FROM TDDCAM CAM JOIN TDDOPC OPC ON OPC.NUCAMPO = CAM.NUCAMPO 
WHERE CAM.NOMETAB='TGFITE' 
AND CAM.NOMECAMPO='ATUALESTTERC' 
ORDER BY OPC.ORDEM


SELECT DISTINCT
CAB.DTENTSAI,CAB.NUMNOTA,CAB,CAB.STATUSNOTA,CAB.PENDENTE,CAB.APROVADO,ITE.CODPROD,TOP.ATUALEST,ITE.QTDNEG*ITE.ATUALESTOQUE
FROM TGFITE ITE
INNER JOIN TGFCAB CAB ON ITE.NUNOTA = CAB.NUNOTA
INNER JOIN TGFTOP TOP ON CAB.CODTIPOPER = TOP.CODTIPOPER
WHERE ITE.CODPROD = 74 AND TOP.ATUALEST IN ('E','B') AND CAB.STATUSNOTA='L' AND ITE.ATUALESTOQUE IN (1,-1)
--GROUP BY CAB.NUMNOTA,CAB.STATUSNOTA,CAB.APROVADO,ITE.CODPROD,TOP.ATUALEST,ITE.QTDNEG
ORDER BY 1,2

SELECT DISTINCT
SUM(ITE.QTDNEG*ITE.ATUALESTOQUE) AS A
FROM TGFITE ITE
INNER JOIN TGFCAB CAB ON ITE.NUNOTA = CAB.NUNOTA
INNER JOIN TGFTOP TOP ON CAB.CODTIPOPER = TOP.CODTIPOPER
WHERE ITE.CODPROD = 74 AND TOP.ATUALEST IN ('E','B') AND CAB.STATUSNOTA='L' AND ITE.ATUALESTOQUE IN (1,-1)
--GROUP BY CAB.NUMNOTA,CAB.STATUSNOTA,CAB.APROVADO,ITE.CODPROD,TOP.ATUALEST,ITE.QTDNEG
--ORDER BY 1,2

