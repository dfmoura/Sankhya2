SELECT
	DISTINCT
CAB.DTMOV,
	CAB.CODEMP,
	EMP.RAZAOSOCIAL,
	ENDI.NOMEEND,
	EMP.NUMEND,
	EMP.COMPLEMENTO,
	BAI.NOMEBAI,
	CID.NOMECID,
	UFS.UF,
	EMP.CEP,
	EMP.CGC,
	SUM(CASE WHEN CAB.CODTIPOPER IN (1100, 1112, 1152) THEN VLRNOTA ELSE 0 END) AS Saidas,
	SUM(CASE WHEN CAB.CODTIPOPER IN (1200, 1201, 1216, 1217) THEN VLRNOTA * -1 ELSE 0 END) AS Devolucoes,
	SUM(CASE WHEN CAB.CODTIPOPER IN (1105) THEN VLRNOTA ELSE 0 END) AS Servicos,
	SUM(CASE WHEN CAB.CODTIPOPER IN (1100, 1112, 1152) THEN VLRNOTA ELSE 0 END) +
SUM(CASE WHEN CAB.CODTIPOPER IN (1200, 1201, 1216, 1217) THEN VLRNOTA * -1 ELSE 0 END) +
SUM(CASE WHEN CAB.CODTIPOPER IN (1105) THEN VLRNOTA ELSE 0 END) AS Total
FROM
	TGFCAB CAB
INNER JOIN TSIEMP EMP ON
	CAB.CODEMP = EMP.CODEMP
INNER JOIN TSIEND ENDI ON
	EMP.CODEND = ENDI.CODEND
INNER JOIN TSIBAI BAI ON
	EMP.CODBAI = BAI.CODBAI
INNER JOIN TSICID CID ON
	EMP.CODCID = CID.CODCID
INNER JOIN TSIUFS UFS ON
	CID.UF = UFS.CODUF
WHERE
	(CAB.DTMOV >= TO_DATE('01-12-2022', 'DD-MM-YYYY')
		AND CAB.DTMOV <= TO_DATE('29-06-2023', 'DD-MM-YYYY'))
	AND CAB.CODTIPOPER IN (1100, 1112, 1152, 1200, 1201, 1216, 1217, 1105)
	AND CAB.CODEMP = 60
	AND CAB.STATUSNOTA = 'L'
GROUP BY
	CAB.DTMOV,
	CAB.CODEMP,
	EMP.RAZAOSOCIAL,
	ENDI.NOMEEND,
	EMP.NUMEND,
	EMP.COMPLEMENTO,
	BAI.NOMEBAI,
	CID.NOMECID,
	UFS.UF,
	EMP.CEP,
	EMP.CGC
ORDER BY
	1,
	2