/*
RELACAO DE INFORMACOES PARA PREENCHIMENTO DO SPED

Valores recebido em determinada compotencia de acordo com a data de baixa,
que se enquadram como receita e real. Desconsiderando adiantamento a fornecedores
e Receita de serviços, etc.
*/

--O objetivo deste Dash é demonstrar as informações consolidadas para a tela "Resumo de operações com Cartão". Informações para Sped.
--CABEÇALHO DASH

WITH AGR AS (
SELECT DISTINCT 
FIN.NUFIN,
MBC.NUBCO,
TO_CHAR(FIN.DHBAIXA,'YYYY') ANO,
TO_CHAR(FIN.DHBAIXA,'MM') MES,
TO_CHAR(FIN.DHBAIXA,'MM-YYYY') EXERCICIO,
MBC.CODCTABCOINT,
CTA.DESCRICAO,
MBC.NUMDOC,
FIN.CODPARC,
PAR.RAZAOSOCIAL,
FIN.CODNAT,
NAT.DESCRNAT,
FIN.CODTIPOPER,
TOP.DESCROPER,
FIN.VLRBAIXA,
MBC.VLRLANC
FROM TGFMBC MBC
INNER JOIN TGFFIN FIN ON MBC.NUBCO = FIN.NUBCO 
INNER JOIN TGFTOP TOP ON FIN.CODTIPOPER = TOP.CODTIPOPER
INNER JOIN TGFNAT NAT ON FIN.CODNAT = NAT.CODNAT
INNER JOIN TSICTA CTA ON MBC.CODCTABCOINT = CTA.CODCTABCOINT
INNER JOIN TGFPAR PAR ON FIN.CODPARC = PAR.CODPARC
WHERE MBC.RECDESP = 1
AND TO_CHAR(FIN.DHBAIXA,'MM-YYYY') IN :P_EXERCICIO
AND MBC.CODCTABCOINT NOT IN (999,9999)
AND FIN.CODTIPOPER NOT IN (1213,1105,305)
AND FIN.CODNAT NOT IN (3070100,3040700,9020000)
)
SELECT DISTINCT 
AGR.ANO,
AGR.MES,
AGR.EXERCICIO,
AGR.CODCTABCOINT CONTA_BAIXA1,
AGR.CODCTABCOINT || ' - ' || AGR.DESCRICAO AS CONTA_BAIXA,
SUM(AGR.VLRBAIXA)VLRBAIXA,
SUM(AGR.VLRLANC)VLRLANC
FROM AGR
GROUP BY
AGR.CODCTABCOINT,
AGR.DESCRICAO,
AGR.ANO,
AGR.MES,
AGR.EXERCICIO
ORDER BY AGR.ANO, AGR.MES


---------------------------------
---------------------------------
--Detalhe Dash

SELECT DISTINCT 
FIN.NUFIN,
MBC.NUBCO,
TO_CHAR(FIN.DHBAIXA,'YYYY') ANO,
TO_CHAR(FIN.DHBAIXA,'MM') MES,
TO_CHAR(FIN.DHBAIXA,'MM-YYYY') EXERCICIO,
MBC.CODCTABCOINT CONTA_BAIXA1,
MBC.CODCTABCOINT || ' - ' || CTA.DESCRICAO AS CONTA_BAIXA,
MBC.NUMDOC,
FIN.CODPARC,
PAR.RAZAOSOCIAL,
FIN.CODNAT,
NAT.DESCRNAT,
FIN.CODTIPOPER,
TOP.DESCROPER,
FIN.VLRBAIXA,
MBC.VLRLANC
FROM TGFMBC MBC
INNER JOIN TGFFIN FIN ON MBC.NUBCO = FIN.NUBCO 
INNER JOIN TGFTOP TOP ON FIN.CODTIPOPER = TOP.CODTIPOPER
INNER JOIN TGFNAT NAT ON FIN.CODNAT = NAT.CODNAT
INNER JOIN TSICTA CTA ON FIN.CODCTABCOINT = CTA.CODCTABCOINT
INNER JOIN TGFPAR PAR ON FIN.CODPARC = PAR.CODPARC
WHERE MBC.RECDESP = 1
AND TO_CHAR(FIN.DHBAIXA,'MM-YYYY') IN :P_EXERCICIO
AND MBC.CODCTABCOINT = :A_CONTA_BAIXA
AND (TO_CHAR(FIN.DHBAIXA,'YYYY') = :A_ANO)
AND (TO_CHAR(FIN.DHBAIXA,'MM') = :A_MES)
AND MBC.CODCTABCOINT NOT IN (999,9999)
AND FIN.CODTIPOPER NOT IN (1213,1105,305)
AND FIN.CODNAT NOT IN (3070100,3040700,9020000)
ORDER BY 3,4