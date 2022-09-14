SELECT DISTINCT
  b.CODPRACA,
  c.PRACA,
  b.CODSUPERVISOR,
  d.NOME,
  b.CODUSUR,
  e.NOME,
  :dtnicio1 ,:dtfim1,
  :dtnicio2 , :dtfim2,
  (SELECT
    Sum(Nvl(pcpedc.VLATEND, 0)) FROM
    pcpedc WHERE
    pcpedc.DATA BETWEEN :dtnicio1 AND :dtfim1 AND pcpedc.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
  AND pcpedc.DTCANCEL IS NULL AND pcpedc.CODPRACA = b.CODPRACA AND pcpedc.CODSUPERVISOR = b.CODSUPERVISOR
  AND pcpedc.CODUSUR = b.CODUSUR) AS PER1,
  (SELECT
    Sum(Nvl(pcpedc.VLATEND, 0)) FROM
    pcpedc WHERE
    pcpedc.DATA BETWEEN :dtnicio2 AND :dtfim2 AND pcpedc.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
  AND pcpedc.DTCANCEL IS NULL AND pcpedc.CODPRACA = b.CODPRACA AND pcpedc.CODSUPERVISOR = b.CODSUPERVISOR
  AND pcpedc.CODUSUR = b.CODUSUR) AS PER2,
  (SELECT
    Sum(Nvl(pcpedc.VLATEND, 0)) FROM
    pcpedc WHERE
    pcpedc.DATA BETWEEN :dtnicio1 AND :dtfim1 AND pcpedc.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
  AND pcpedc.DTCANCEL IS NULL AND pcpedc.CODPRACA = b.CODPRACA AND pcpedc.CODSUPERVISOR = b.CODSUPERVISOR
  AND pcpedc.CODUSUR = b.CODUSUR) -   (SELECT
    Sum(Nvl(pcpedc.VLATEND, 0)) FROM
    pcpedc WHERE
    pcpedc.DATA BETWEEN :dtnicio2 AND :dtfim2 AND pcpedc.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
  AND pcpedc.DTCANCEL IS NULL AND pcpedc.CODPRACA = b.CODPRACA AND pcpedc.CODSUPERVISOR = b.CODSUPERVISOR
  AND pcpedc.CODUSUR = b.CODUSUR) AS RESULTADO
FROM
  pcclient a, pcpedc b, pcpraca c, pcsuperv d, pcusuari e
WHERE
  b.CODPRACA = c.CODPRACA
  AND b.CODSUPERVISOR = d.CODSUPERVISOR
  and b.codusur = e.codusur
  AND a.CODCLI = b.CODCLI
  --AND b.DATA BETWEEN :dtnicio1 AND :dtfim2
  AND b.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
  AND b.DTCANCEL IS NULL
  AND b.CODPRACA IN (:codpraca)
  AND b.CODUSUR IN (:codusur)
  and   (SELECT
    Sum(Nvl(pcpedc.VLATEND, 0)) FROM
    pcpedc WHERE
    pcpedc.DATA BETWEEN :dtnicio2 AND :dtfim2 AND pcpedc.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
  AND pcpedc.DTCANCEL IS NULL AND pcpedc.CODPRACA = b.CODPRACA AND pcpedc.CODSUPERVISOR = b.CODSUPERVISOR
  AND pcpedc.CODUSUR = b.CODUSUR) >0
  --AND b.CODSUPERVISOR IN (:codsupervisor)
GROUP BY
  b.CODPRACA, c.PRACA, b.CODSUPERVISOR, d.NOME, b.CODUSUR, e.NOME
ORDER BY
  resultado

