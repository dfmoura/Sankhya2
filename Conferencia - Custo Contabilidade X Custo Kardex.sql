--Conferencia - Custo Contabilidade X Custo Kardex

SELECT  'COMPRA' AS TIPO,
		IT.NUNICO,
		CAB.NUMNOTA,
		CAB.DTENTSAI,
		CAB.CODTIPOPER,
		(SELECT	DISTINCT OPE.DESCROPER FROM TGFTOP OPE WHERE OPE.CODTIPOPER = CAB.CODTIPOPER AND OPE.DHALTER = CAB.DHTIPOPER) AS DESCROPER,
		LAN.CODCTACTB,
		PLA.DESCRCTA,
        CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END AS DEBITO,
        CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END AS CREDITO,
        CASE WHEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
		CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END) > 0
		THEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)
		ELSE  (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)* -1
		END AS CUSTOCONTABIL,
		ROUND((SELECT SUM(CUS.QTDNEG * CUS.ENTRADASEMICMS) 
		 FROM	TGFCUSITE CUS, TGFPRO PRO
		 WHERE	CUS.CODPROD = PRO.CODPROD
		 AND	CUS.NUNOTA = IT.NUNICO), 2) AS CUSTOKARDEX,
		CASE WHEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
		CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END) > 0
		THEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)
		ELSE  (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)* -1
		END - 
		ROUND((SELECT SUM(CUS.QTDNEG * CUS.ENTRADASEMICMS) 
		 FROM	TGFCUSITE CUS, TGFPRO PRO
		 WHERE	CUS.CODPROD = PRO.CODPROD
		 AND	CUS.NUNOTA = IT.NUNICO), 2) + CASE WHEN CAB.TIPFRETE <> 'S' THEN CAB.VLRFRETE ELSE 0 END AS DIFERENCA


FROM    TCBLAN LAN, TCBINT IT, TGFCAB CAB, TCBPLA PLA, TGFTOP OPE

WHERE   LAN.CODEMP = IT.CODEMP
AND     LAN.REFERENCIA = IT.REFERENCIA
AND     LAN.NUMLANC = IT.NUMLANC
AND     LAN.TIPLANC = IT.TIPLANC
AND     LAN.NUMLOTE = IT.NUMLOTE
AND     LAN.VLRLANC = IT.VLRLANC
AND     LAN.SEQUENCIA = IT.SEQUENCIA
AND		IT.NUNICO = CAB.NUNOTA
AND		LAN.CODCTACTB = PLA.CODCTACTB
AND		CAB.CODTIPOPER = OPE.CODTIPOPER
AND		CAB.DHTIPOPER = OPE.DHALTER
AND		OPE.PRECIFICA IN ('C', 'S')
AND		IT.ORIGEM = 'E'
AND		CAB.TIPMOV = 'C'
AND		LAN.CODEMP = :CODEMP
AND		LAN.REFERENCIA = :DTREFERENCIA
AND     PLA.CODCTACTB IN :CODCTACTB

GROUP BY 	IT.NUNICO,
			CAB.NUMNOTA,
			CAB.DTENTSAI,
			CAB.CODTIPOPER,
			CAB.DHTIPOPER,
			LAN.CODCTACTB,
			PLA.DESCRCTA,
			CAB.TIPFRETE,
			CAB.VLRFRETE
			
UNION ALL

SELECT  'COMPRA' AS TIPO,
		IT.NUNICO,
		CAB.NUMNOTA,
		CAB.DTENTSAI,
		CAB.CODTIPOPER,
		(SELECT	DISTINCT OPE.DESCROPER FROM TGFTOP OPE WHERE OPE.CODTIPOPER = CAB.CODTIPOPER AND OPE.DHALTER = CAB.DHTIPOPER) AS DESCROPER,
		LAN.CODCTACTB,
		PLA.DESCRCTA,
        CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END AS DEBITO,
        CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END AS CREDITO,
        CASE WHEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
		CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END) > 0
		THEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)
		ELSE  (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)* -1
		END AS CUSTOCONTABIL,
		ROUND((SELECT SUM(ITE.QTDNEG * CUS.CUSSEMICM) 
		 FROM	TGFCAB CAB1, TGFITE ITE, TGFCUS CUS
		 WHERE	CAB1.NUNOTA=ITE.NUNOTA
		 AND	ITE.CODPROD = CUS.CODPROD
		 AND	ITE.CONTROLE = CUS.CONTROLE
		 AND	CAB1.CODEMP = CUS.CODEMP
		 AND	CUS.DTATUAL = (SELECT MAX(CUS1.DTATUAL)
							  FROM TGFCUS CUS1
							  WHERE CUS1.CODPROD = CUS.CODPROD
							  AND	CUS1.CONTROLE = CUS.CONTROLE
							  AND	CUS1.CODEMP = CUS.CODEMP
							  AND   CUS1.DTATUAL <= CAB.DTENTSAI)
				AND CAB1.NUNOTA = IT.NUNICO), 2) AS CUSTOKARDEX,
		CASE WHEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
		CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END) > 0
		THEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)
		ELSE  (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)* -1
		END - 
		ROUND((SELECT SUM(ITE.QTDNEG * CUS.CUSSEMICM) 
		 FROM	TGFCAB CAB1, TGFITE ITE, TGFCUS CUS
		 WHERE	CAB1.NUNOTA=ITE.NUNOTA
		 AND	ITE.CODPROD = CUS.CODPROD
		 AND	ITE.CONTROLE = CUS.CONTROLE
		 AND	CAB1.CODEMP = CUS.CODEMP
		 AND	CUS.DTATUAL = (SELECT MAX(CUS1.DTATUAL)
							  FROM TGFCUS CUS1
							  WHERE CUS1.CODPROD = CUS.CODPROD
							  AND	CUS1.CONTROLE = CUS.CONTROLE
							  AND	CUS1.CODEMP = CUS.CODEMP
							  AND   CUS1.DTATUAL <= CAB.DTENTSAI)
				AND CAB1.NUNOTA = IT.NUNICO), 2) AS DIFERENCA


FROM    TCBLAN LAN, TCBINT IT, TGFCAB CAB, TCBPLA PLA, TGFTOP OPE

WHERE   LAN.CODEMP = IT.CODEMP
AND     LAN.REFERENCIA = IT.REFERENCIA
AND     LAN.NUMLANC = IT.NUMLANC
AND     LAN.TIPLANC = IT.TIPLANC
AND     LAN.NUMLOTE = IT.NUMLOTE
AND     LAN.VLRLANC = IT.VLRLANC
AND     LAN.SEQUENCIA = IT.SEQUENCIA
AND		IT.NUNICO = CAB.NUNOTA
AND		LAN.CODCTACTB = PLA.CODCTACTB
AND		CAB.CODTIPOPER = OPE.CODTIPOPER
AND		CAB.DHTIPOPER = OPE.DHALTER
AND		OPE.PRECIFICA = 'N'
AND		IT.ORIGEM = 'E'
AND		CAB.TIPMOV = 'C'
AND		LAN.CODEMP = :CODEMP
AND		LAN.REFERENCIA = :DTREFERENCIA
AND     PLA.CODCTACTB IN :CODCTACTB


GROUP BY 	IT.NUNICO,
			CAB.NUMNOTA,
			CAB.DTENTSAI,
			CAB.CODTIPOPER,
			CAB.DHTIPOPER,
			LAN.CODCTACTB,
			PLA.DESCRCTA

UNION ALL

SELECT  'DEVOLUCAO COMPRA' AS TIPO,
		IT.NUNICO,
		CAB.NUMNOTA,
		CAB.DTENTSAI,
		CAB.CODTIPOPER,
		(SELECT	DISTINCT OPE.DESCROPER FROM TGFTOP OPE WHERE OPE.CODTIPOPER = CAB.CODTIPOPER AND OPE.DHALTER = CAB.DHTIPOPER) AS DESCROPER,
		LAN.CODCTACTB,
		PLA.DESCRCTA,
        CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END AS DEBITO,
        CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END AS CREDITO,
        CASE WHEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
		CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END) > 0
		THEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)
		ELSE  (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)* -1
		END AS CUSTOCONTABIL,
		ROUND((SELECT SUM(ITE.QTDNEG * CUS.CUSSEMICM) 
		 FROM	TGFCAB CAB1, TGFITE ITE, TGFCUS CUS
		 WHERE	CAB1.NUNOTA=ITE.NUNOTA
		 AND	ITE.CODPROD = CUS.CODPROD
		 AND	ITE.CONTROLE = CUS.CONTROLE
		 AND	CAB1.CODEMP = CUS.CODEMP
		 AND	CUS.DTATUAL = (SELECT MAX(CUS1.DTATUAL)
							  FROM TGFCUS CUS1
							  WHERE CUS1.CODPROD = CUS.CODPROD
							  AND	CUS1.CONTROLE = CUS.CONTROLE
							  AND	CUS1.CODEMP = CUS.CODEMP
							  AND   CUS1.DTATUAL <= CAB.DTENTSAI)
				AND CAB1.NUNOTA = IT.NUNICO), 2) AS CUSTOKARDEX,
		CASE WHEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
		CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END) > 0
		THEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)
		ELSE  (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)* -1
		END - 
		ROUND((SELECT SUM(ITE.QTDNEG * CUS.CUSSEMICM) 
		 FROM	TGFCAB CAB1, TGFITE ITE, TGFCUS CUS
		 WHERE	CAB1.NUNOTA=ITE.NUNOTA
		 AND	ITE.CODPROD = CUS.CODPROD
		 AND	ITE.CONTROLE = CUS.CONTROLE
		 AND	CAB1.CODEMP = CUS.CODEMP
		 AND	CUS.DTATUAL = (SELECT MAX(CUS1.DTATUAL)
							  FROM TGFCUS CUS1
							  WHERE CUS1.CODPROD = CUS.CODPROD
							  AND	CUS1.CONTROLE = CUS.CONTROLE
							  AND	CUS1.CODEMP = CUS.CODEMP
							  AND   CUS1.DTATUAL <= CAB.DTENTSAI)
				AND CAB1.NUNOTA = IT.NUNICO), 2) AS DIFERENCA


FROM    TCBLAN LAN, TCBINT IT, TGFCAB CAB, TCBPLA PLA

WHERE   LAN.CODEMP = IT.CODEMP
AND     LAN.REFERENCIA = IT.REFERENCIA
AND     LAN.NUMLANC = IT.NUMLANC
AND     LAN.TIPLANC = IT.TIPLANC
AND     LAN.NUMLOTE = IT.NUMLOTE
AND     LAN.VLRLANC = IT.VLRLANC
AND     LAN.SEQUENCIA = IT.SEQUENCIA
AND		IT.NUNICO = CAB.NUNOTA
AND		LAN.CODCTACTB = PLA.CODCTACTB
AND		IT.ORIGEM = 'E'
AND		CAB.TIPMOV = 'E'
AND		LAN.CODEMP = :CODEMP
AND		LAN.REFERENCIA = :DTREFERENCIA
AND     PLA.CODCTACTB IN :CODCTACTB


GROUP BY 	IT.NUNICO,
			CAB.NUMNOTA,
			CAB.DTENTSAI,
			CAB.CODTIPOPER,
			CAB.DHTIPOPER,
			LAN.CODCTACTB,
			PLA.DESCRCTA
			
UNION ALL

SELECT  'VENDA' AS TIPO,
		IT.NUNICO,
		CAB.NUMNOTA,
		CAB.DTNEG AS DTENTSAI,
		CAB.CODTIPOPER,
		(SELECT	DISTINCT OPE.DESCROPER FROM TGFTOP OPE WHERE OPE.CODTIPOPER = CAB.CODTIPOPER AND OPE.DHALTER = CAB.DHTIPOPER) AS DESCROPER,
		LAN.CODCTACTB,
		PLA.DESCRCTA,
        CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END AS DEBITO,
        CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END AS CREDITO,
        CASE WHEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
		CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END) > 0
		THEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)
		ELSE  (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)* -1
		END AS CUSTOCONTABIL,
		ROUND((SELECT SUM(ITE.QTDNEG * CUS.CUSSEMICM) 
		 FROM	TGFCAB CAB1, TGFITE ITE, TGFCUS CUS
		 WHERE	CAB1.NUNOTA=ITE.NUNOTA
		 AND	ITE.CODPROD = CUS.CODPROD
		 AND	ITE.CONTROLE = CUS.CONTROLE
		 AND	CAB1.CODEMP = CUS.CODEMP
		 AND	CUS.DTATUAL = (SELECT MAX(CUS1.DTATUAL)
							  FROM TGFCUS CUS1
							  WHERE CUS1.CODPROD = CUS.CODPROD
							  AND	CUS1.CONTROLE = CUS.CONTROLE
							  AND	CUS1.CODEMP = CUS.CODEMP
							  AND   CUS1.DTATUAL <= CAB.DTNEG)
				AND CAB1.NUNOTA = IT.NUNICO), 2) AS CUSTOKARDEX,
		CASE WHEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
		CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END) > 0
		THEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)
		ELSE  (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)* -1
		END - 
		ROUND((SELECT SUM(ITE.QTDNEG * CUS.CUSSEMICM) 
		 FROM	TGFCAB CAB1, TGFITE ITE, TGFCUS CUS
		 WHERE	CAB1.NUNOTA=ITE.NUNOTA
		 AND	ITE.CODPROD = CUS.CODPROD
		 AND	ITE.CONTROLE = CUS.CONTROLE
		 AND	CAB1.CODEMP = CUS.CODEMP
		 AND	CUS.DTATUAL = (SELECT MAX(CUS1.DTATUAL)
							  FROM TGFCUS CUS1
							  WHERE CUS1.CODPROD = CUS.CODPROD
							  AND 	CUS1.CONTROLE = CUS.CONTROLE
							  AND	CUS1.CODEMP = CUS.CODEMP
							  AND   CUS1.DTATUAL <= CAB.DTNEG)
				AND CAB1.NUNOTA = IT.NUNICO), 2) AS DIFERENCA


FROM    TCBLAN LAN, TCBINT IT, TGFCAB CAB, TCBPLA PLA

WHERE   LAN.CODEMP = IT.CODEMP
AND     LAN.REFERENCIA = IT.REFERENCIA
AND     LAN.NUMLANC = IT.NUMLANC
AND     LAN.TIPLANC = IT.TIPLANC
AND     LAN.NUMLOTE = IT.NUMLOTE
AND     LAN.VLRLANC = IT.VLRLANC
AND     LAN.SEQUENCIA = IT.SEQUENCIA
AND		IT.NUNICO = CAB.NUNOTA
AND		LAN.CODCTACTB = PLA.CODCTACTB
AND		IT.ORIGEM = 'E'
AND		CAB.TIPMOV = 'V'
AND		LAN.CODEMP = :CODEMP
AND		LAN.REFERENCIA = :DTREFERENCIA
AND     PLA.CODCTACTB IN :CODCTACTB
--AND     IT.NUNICO = 729299

GROUP BY 	IT.NUNICO,
			CAB.NUMNOTA,
			CAB.DTNEG,
			CAB.CODTIPOPER,
			CAB.DHTIPOPER,
			LAN.CODCTACTB,
			PLA.DESCRCTA

UNION ALL

SELECT  'DEVOLUCAO VENDA' AS TIPO,
		IT.NUNICO,
		CAB.NUMNOTA,
		CAB.DTENTSAI,
		CAB.CODTIPOPER,
		(SELECT	DISTINCT OPE.DESCROPER FROM TGFTOP OPE WHERE OPE.CODTIPOPER = CAB.CODTIPOPER AND OPE.DHALTER = CAB.DHTIPOPER) AS DESCROPER,
		LAN.CODCTACTB,
		PLA.DESCRCTA,
        CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END AS DEBITO,
        CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END AS CREDITO,
        CASE WHEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
		CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END) > 0
		THEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)
		ELSE  (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)* -1
		END AS CUSTOCONTABIL,
		ROUND((SELECT SUM(ITE.QTDNEG * CUS.CUSSEMICM) 
		 FROM	TGFCAB CAB1, TGFITE ITE, TGFCUS CUS
		 WHERE	CAB1.NUNOTA=ITE.NUNOTA
		 AND	ITE.CODPROD = CUS.CODPROD
		 AND	ITE.CONTROLE = CUS.CONTROLE
		 AND	CAB1.CODEMP = CUS.CODEMP
		 AND	CUS.DTATUAL = (SELECT MAX(CUS1.DTATUAL)
							  FROM TGFCUS CUS1
							  WHERE CUS1.CODPROD = CUS.CODPROD
							  AND	CUS1.CONTROLE = CUS.CONTROLE
							  AND	CUS1.CODEMP = CUS.CODEMP
							  AND   CUS1.DTATUAL <= CAB.DTENTSAI)
				AND CAB1.NUNOTA = IT.NUNICO), 2) AS CUSTOKARDEX,
		CASE WHEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
		CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END) > 0
		THEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)
		ELSE  (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)* -1
		END - 
		ROUND((SELECT SUM(ITE.QTDNEG * CUS.CUSSEMICM) 
		 FROM	TGFCAB CAB1, TGFITE ITE, TGFCUS CUS
		 WHERE	CAB1.NUNOTA=ITE.NUNOTA
		 AND	ITE.CODPROD = CUS.CODPROD
		 AND	ITE.CONTROLE = CUS.CONTROLE
		 AND	CAB1.CODEMP = CUS.CODEMP
		 AND	CUS.DTATUAL = (SELECT MAX(CUS1.DTATUAL)
							  FROM TGFCUS CUS1
							  WHERE CUS1.CODPROD = CUS.CODPROD
							  AND	CUS1.CONTROLE = CUS.CONTROLE
							  AND	CUS1.CODEMP = CUS.CODEMP
							  AND   CUS1.DTATUAL <= CAB.DTENTSAI)
				AND CAB1.NUNOTA = IT.NUNICO), 2) AS DIFERENCA


FROM    TCBLAN LAN, TCBINT IT, TGFCAB CAB, TCBPLA PLA

WHERE   LAN.CODEMP = IT.CODEMP
AND     LAN.REFERENCIA = IT.REFERENCIA
AND     LAN.NUMLANC = IT.NUMLANC
AND     LAN.TIPLANC = IT.TIPLANC
AND     LAN.NUMLOTE = IT.NUMLOTE
AND     LAN.VLRLANC = IT.VLRLANC
AND     LAN.SEQUENCIA = IT.SEQUENCIA
AND		IT.NUNICO = CAB.NUNOTA
AND		LAN.CODCTACTB = PLA.CODCTACTB
AND		IT.ORIGEM = 'E'
AND		CAB.TIPMOV = 'D'
AND		LAN.CODEMP = :CODEMP
AND		LAN.REFERENCIA = :DTREFERENCIA
AND     PLA.CODCTACTB IN :CODCTACTB
--AND     IT.NUNICO = 729299

GROUP BY 	IT.NUNICO,
			CAB.NUMNOTA,
			CAB.DTENTSAI,
			CAB.CODTIPOPER,
			CAB.DHTIPOPER,
			LAN.CODCTACTB,
			PLA.DESCRCTA

UNION ALL

SELECT  'REQUISICAO' AS TIPO,
		IT.NUNICO,
		CAB.NUMNOTA,
		CAB.DTENTSAI,
		CAB.CODTIPOPER,
		(SELECT	DISTINCT OPE.DESCROPER FROM TGFTOP OPE WHERE OPE.CODTIPOPER = CAB.CODTIPOPER AND OPE.DHALTER = CAB.DHTIPOPER) AS DESCROPER,
		LAN.CODCTACTB,
		PLA.DESCRCTA,
        CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END AS DEBITO,
        CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END AS CREDITO,
        CASE WHEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
		CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END) > 0
		THEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)
		ELSE  (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)* -1
		END AS CUSTOCONTABIL,
		ROUND((SELECT SUM(ITE.QTDNEG * CUS.CUSSEMICM) 
		 FROM	TGFCAB CAB1, TGFITE ITE, TGFCUS CUS, TGFPRO PRO
		 WHERE	CAB1.NUNOTA=ITE.NUNOTA
		 AND	ITE.CODPROD = CUS.CODPROD
		 AND	ITE.CONTROLE = CUS.CONTROLE
		 AND	CAB1.CODEMP = CUS.CODEMP
		 AND	ITE.CODPROD = PRO.CODPROD
		 AND	CUS.DTATUAL = (SELECT MAX(CUS1.DTATUAL)
							  FROM TGFCUS CUS1
							  WHERE CUS1.CODPROD = CUS.CODPROD
							  AND 	CUS1.CONTROLE = CUS.CONTROLE
							  AND	CUS1.CODEMP = CUS.CODEMP
							  AND   CUS1.DTATUAL <= CAB.DTENTSAI)
		AND CAB1.NUNOTA = IT.NUNICO
		AND PRO.CODCTACTB = LAN.CODCTACTB
		GROUP BY PRO.CODCTACTB), 2) AS CUSTOKARDEX,
		CASE WHEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
		CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END) > 0
		THEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)
		ELSE  (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)* -1
		END - 
		ROUND((SELECT SUM(ITE.QTDNEG * CUS.CUSSEMICM) 
		 FROM	TGFCAB CAB1, TGFITE ITE, TGFCUS CUS, TGFPRO PRO
		 WHERE	CAB1.NUNOTA=ITE.NUNOTA
		 AND	ITE.CODPROD = CUS.CODPROD
		 AND	ITE.CONTROLE = CUS.CONTROLE
		 AND	CAB1.CODEMP = CUS.CODEMP
		 AND	ITE.CODPROD = PRO.CODPROD
		 AND	CUS.DTATUAL = (SELECT MAX(CUS1.DTATUAL)
							  FROM TGFCUS CUS1
							  WHERE CUS1.CODPROD = CUS.CODPROD
							  AND	CUS1.CONTROLE = CUS.CONTROLE
							  AND	CUS1.CODEMP = CUS.CODEMP
							  AND   CUS1.DTATUAL <= CAB.DTENTSAI)
		AND CAB1.NUNOTA = IT.NUNICO
		AND PRO.CODCTACTB = LAN.CODCTACTB
		GROUP BY PRO.CODCTACTB), 2) AS DIFERENCA


FROM    TCBLAN LAN, TCBINT IT, TGFCAB CAB, TCBPLA PLA

WHERE   LAN.CODEMP = IT.CODEMP
AND     LAN.REFERENCIA = IT.REFERENCIA
AND     LAN.NUMLANC = IT.NUMLANC
AND     LAN.TIPLANC = IT.TIPLANC
AND     LAN.NUMLOTE = IT.NUMLOTE
AND     LAN.VLRLANC = IT.VLRLANC
AND     LAN.SEQUENCIA = IT.SEQUENCIA
AND		IT.NUNICO = CAB.NUNOTA
AND		LAN.CODCTACTB = PLA.CODCTACTB
AND		IT.ORIGEM = 'E'
AND		CAB.TIPMOV = 'Q'
AND		LAN.CODEMP = :CODEMP
AND		LAN.REFERENCIA = :DTREFERENCIA
AND     PLA.CODCTACTB IN :CODCTACTB
--AND     IT.NUNICO = 729299

GROUP BY 	IT.NUNICO,
			CAB.NUMNOTA,
			CAB.DTENTSAI,
			CAB.CODTIPOPER,
			CAB.DHTIPOPER,
			LAN.CODCTACTB,
			PLA.DESCRCTA

UNION ALL

SELECT  'PRODUTO PRODUZIDO' AS TIPO,
		IT.NUNICO,
		CAB.NUNOTA AS NUMNOTA,
		CAB.DTNEG AS DTENTSAI,
		CAB.CODTIPOPER,
		(SELECT	DISTINCT OPE.DESCROPER FROM TGFTOP OPE WHERE OPE.CODTIPOPER = CAB.CODTIPOPER AND OPE.DHALTER = CAB.DHTIPOPER) AS DESCROPER,
		LAN.CODCTACTB,
		PLA.DESCRCTA,
        SUM(CASE WHEN IT.TIPLANC = 'D' THEN IT.VLRLANC END) AS DEBITO,
		0 AS CREDITO,
        SUM(CASE WHEN IT.TIPLANC = 'D' THEN IT.VLRLANC END) AS CUSTOCONTABIL,
				ROUND((SELECT	SUM(CUS.QTDNEG * CUS.ENTRADASEMICMS) 
		       FROM		TGFCUSITE CUS
		       WHERE	CUS.NUNOTA = IT.NUNICO), 2) AS CUSTOKARDEX,
				SUM(CASE WHEN IT.TIPLANC = 'D' THEN IT.VLRLANC END) -
		ROUND((SELECT	SUM(CUS.QTDNEG * CUS.ENTRADASEMICMS) 
		       FROM		TGFCUSITE CUS
		       WHERE	CUS.NUNOTA = IT.NUNICO), 2) AS DIFERENCA


FROM    TCBLAN LAN, TCBINT IT, TGFCAB CAB, TCBPLA PLA

WHERE   LAN.CODEMP = IT.CODEMP
AND     LAN.REFERENCIA = IT.REFERENCIA
AND     LAN.NUMLANC = IT.NUMLANC
AND     LAN.TIPLANC = IT.TIPLANC
AND     LAN.NUMLOTE = IT.NUMLOTE
--AND     LAN.VLRLANC = IT.VLRLANC
AND     LAN.SEQUENCIA = IT.SEQUENCIA
AND		IT.NUNICO = CAB.NUNOTA
AND		LAN.CODCTACTB = PLA.CODCTACTB
AND		IT.ORIGEM = 'E'
AND		CAB.TIPMOV = 'F'
AND		LAN.TIPLANC = 'D'
AND		LAN.CODEMP = :CODEMP
AND		LAN.REFERENCIA = :DTREFERENCIA
AND     PLA.CODCTACTB IN :CODCTACTB
--AND     IT.NUNICO = 735972


GROUP BY 	IT.NUNICO,
			CAB.NUNOTA,
			CAB.DTNEG,
			CAB.CODTIPOPER,
			CAB.DHTIPOPER,
			LAN.CODCTACTB,
			PLA.DESCRCTA
			
UNION ALL

SELECT  'PRODUTO CONSUMIDO' AS TIPO,
		IT.NUNICO,
		CAB.NUNOTA AS NUMNOTA,
		CAB.DTNEG AS DTENTSAI,
		CAB.CODTIPOPER,
		(SELECT	DISTINCT OPE.DESCROPER FROM TGFTOP OPE WHERE OPE.CODTIPOPER = CAB.CODTIPOPER AND OPE.DHALTER = CAB.DHTIPOPER) AS DESCROPER,
		LAN.CODCTACTB,
		PLA.DESCRCTA,
        0 AS DEBITO,
		SUM(CASE WHEN IT.TIPLANC = 'R' THEN IT.VLRLANC END) AS CREDITO,
        SUM(CASE WHEN IT.TIPLANC = 'R' THEN IT.VLRLANC END) AS CUSTOCONTABIL,
		SUM(ROUND((SELECT SUM(ITE.QTDNEG * CUS.CUSSEMICM) 
		 FROM	TGFCAB CAB1, VW_CUSTO_MP_JC ITE, TGFCUS CUS
		 WHERE	CAB1.NUNOTA = ITE.NUNOTA
		 AND	ITE.CODPROD = CUS.CODPROD
		 AND	ITE.CONTROLE = CUS.CONTROLE
		 AND	CAB1.CODEMP = CUS.CODEMP
		 AND	ITE.USOPROD = 'M'
		 AND	CUS.DTATUAL = (SELECT MAX(CUS1.DTATUAL)
							  FROM TGFCUS CUS1
							  WHERE CUS1.CODPROD = CUS.CODPROD
							  AND	CUS1.CONTROLE = CUS.CONTROLE
							  AND	CUS1.CODEMP = CUS.CODEMP
							  AND   CUS1.DTATUAL <= NVL(CAB.DTENTSAI, CAB.DTNEG))
				AND CAB1.NUNOTA = IT.NUNICO), 2)) AS CUSTOKARDEX,
		SUM(CASE WHEN IT.TIPLANC = 'R' THEN IT.VLRLANC END) -
		SUM(ROUND((SELECT SUM(ITE.QTDNEG * CUS.CUSSEMICM) 
		 FROM	TGFCAB CAB1, VW_CUSTO_MP_JC ITE, TGFCUS CUS
		 WHERE	CAB1.NUNOTA = ITE.NUNOTA
		 AND	ITE.CODPROD = CUS.CODPROD
		 AND	ITE.CONTROLE = CUS.CONTROLE
		 AND	CAB1.CODEMP = CUS.CODEMP
		 AND	ITE.USOPROD = 'M'
		 AND	CUS.DTATUAL = (SELECT MAX(CUS1.DTATUAL)
							  FROM TGFCUS CUS1
							  WHERE CUS1.CODPROD = CUS.CODPROD
							  AND	CUS1.CONTROLE = CUS.CONTROLE
							  AND	CUS1.CODEMP = CUS.CODEMP
							  AND   CUS1.DTATUAL <= NVL(CAB.DTENTSAI, CAB.DTNEG))
				AND CAB1.NUNOTA = IT.NUNICO), 2)) AS DIFERENCA


FROM    TCBLAN LAN, TCBINT IT, TGFCAB CAB, TCBPLA PLA

WHERE   LAN.CODEMP = IT.CODEMP
AND     LAN.REFERENCIA = IT.REFERENCIA
AND     LAN.NUMLANC = IT.NUMLANC
AND     LAN.TIPLANC = IT.TIPLANC
AND     LAN.NUMLOTE = IT.NUMLOTE
--AND     LAN.VLRLANC = IT.VLRLANC
AND     LAN.SEQUENCIA = IT.SEQUENCIA
AND		IT.NUNICO = CAB.NUNOTA
AND		LAN.CODCTACTB = PLA.CODCTACTB
AND		IT.ORIGEM = 'E'
AND		CAB.TIPMOV = 'F'
AND		LAN.TIPLANC = 'R'
AND		LAN.CODEMP = :CODEMP
AND		LAN.REFERENCIA = :DTREFERENCIA
AND     PLA.CODCTACTB IN :CODCTACTB
--AND     IT.NUNICO = 735972


GROUP BY 	IT.NUNICO,
			CAB.NUNOTA,
			CAB.DTNEG,
			CAB.CODTIPOPER,
			CAB.DHTIPOPER,
			LAN.CODCTACTB,
			PLA.DESCRCTA
			
UNION ALL			

SELECT	'LANCAMENTO MANUAL',
		0 AS NUNICO,
		0 AS NUMNOTA,
		NULL AS DTENTSAI,
		0 AS CODTIPOPER,
		'LANCAMENTO MANUAL' AS DESCROPER,
		LAN.CODCTACTB,
		PLA.DESCRCTA,
		CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END AS DEBITO,
        CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END AS CREDITO,
        CASE WHEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
		CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
		THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
		ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END) > 0
		THEN (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)
		ELSE  (CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END) 
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'D' THEN LAN.VLRLANC ELSE 0 END)*-1 END - 
			  CASE WHEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END) > 0
			  THEN SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)
			  ELSE SUM(CASE WHEN LAN.TIPLANC = 'R' THEN LAN.VLRLANC ELSE 0 END)*-1 END)* -1
		END AS CUSTOCONTABIL,
		0 AS CUSTOKARDEX,
		0 AS DIFERENCA
		
FROM	TCBLAN LAN, TCBPLA PLA

WHERE 	LAN.CODCTACTB = PLA.CODCTACTB
AND		LAN.CODEMP = :CODEMP
AND		LAN.REFERENCIA = :DTREFERENCIA
AND     PLA.CODCTACTB IN :CODCTACTB
AND		NOT EXISTS (SELECT 1 FROM TCBINT IT			
					WHERE   LAN.CODEMP = IT.CODEMP
					AND     LAN.REFERENCIA = IT.REFERENCIA
					AND     LAN.NUMLANC = IT.NUMLANC
					AND     LAN.TIPLANC = IT.TIPLANC
					AND     LAN.NUMLOTE = IT.NUMLOTE
					AND     LAN.VLRLANC = IT.VLRLANC
					AND     LAN.SEQUENCIA = IT.SEQUENCIA)

GROUP BY	LAN.CODCTACTB,
			PLA.DESCRCTA
					
ORDER BY 1, 5, 2

