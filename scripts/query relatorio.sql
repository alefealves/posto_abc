SELECT
LPAD(EXTRACT(DAY FROM A.DATA), 2, '0') || '/' ||
LPAD(EXTRACT(MONTH FROM A.DATA), 2, '0') || '/' ||
EXTRACT(YEAR FROM A.DATA) AS FormattedDate,
T.DESCRICAO TANQUE,
B.DESCRICAO BOMBA,
SUM(A.VALOR) VALOR
FROM ABASTECIMENTO A
INNER JOIN BOMBA B
ON A.ID_BOMBA = B.ID
INNER JOIN TANQUE T
ON B.ID_TANQUE = T.ID
INNER JOIN COMBUSTIVEL C
ON T.ID_COMBUSTIVEL = C.ID
WHERE ((A.DATA >= :DAT_INI) AND (A.DATA <= :DAT_FIM))
GROUP BY
LPAD(EXTRACT(DAY FROM A.DATA), 2, '0') || '/' ||
LPAD(EXTRACT(MONTH FROM A.DATA), 2, '0') || '/' ||
EXTRACT(YEAR FROM A.DATA),
T.DESCRICAO,
B.DESCRICAO
ORDER BY 1,2,3;

--REPLACE(CAST(A.DATA AS DATE),'.','/') DATA,

SELECT
SUM(A.VALOR) VALOR
FROM ABASTECIMENTO A
INNER JOIN BOMBA B
ON A.ID_BOMBA = B.ID
INNER JOIN TANQUE T
ON B.ID_TANQUE = T.ID
INNER JOIN COMBUSTIVEL C
ON T.ID_COMBUSTIVEL = C.ID
WHERE ((A.DATA >= :DAT_INI) AND (A.DATA <= :DAT_FIM));
