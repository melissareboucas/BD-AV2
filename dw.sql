--Criar banco de datawarehouse
create database dw

--fato
--empenho (id, cod_ne, codigo_orgao, cod_credor, cod_fonte, vlr_empenho, valor_pago, vlr_resto_pagar, dth_empenho, dth_pagamento, dth_processamento)
use ods
SELECT DISTINCT
    id AS idFato,
    cod_ne AS codigoNumeroEmpenho,
    codigo_orgao AS codigoOrgao,
    cod_credor AS codigoCredor,
    cod_fonte AS codigoFonte,
    vlr_empenho AS valorEmpenho,
    valor_pago AS valorPago,
    vlr_resto_pagar AS valorRestantePagar,
    dth_empenho AS dataEmpenho,
    dth_pagamento AS dataPagamento,
    dth_processamento AS dataProcessamento,
    CASE
        WHEN valor_pago = 0 THEN vlr_empenho - vlr_resto_pagar
        ELSE valor_pago
    END AS novoValorPago,
    CASE
        WHEN vlr_resto_pagar = 0 THEN vlr_empenho - valor_pago
        ELSE vlr_resto_pagar
    END AS novoValorRestantePagar
INTO dw..fato_empenho
FROM tabelaODS

--ajustando o campo para que ele possa ser uma primary key
use dw
ALTER TABLE fato_empenho
ALTER COLUMN idFato int not null;

--criando a chave primária
ALTER TABLE fato_empenho
  ADD PRIMARY KEY (idFato);


--orgao (codigo_orgao, dsc_orgao) 
use ods
select distinct
	codigo_orgao as codigoOrgao,
	dsc_orgao as descricaoOrgao
	into dw..dim_orgao
from tabelaODS

--ajustando o campo para que ele possa ser uma primary key
use dw
ALTER TABLE dim_orgao
ALTER COLUMN codigoOrgao varchar(255) not null;

--criando a chave primária
ALTER TABLE dim_orgao
  ADD PRIMARY KEY (codigoOrgao);

--fonte (cod_fonte, dsc_fonte)
use ods
select distinct
	cod_fonte as codigoFonte,
	dsc_fonte as descricaoFonte
	into dw..dim_fonte
from tabelaODS

--ajustando o campo para que ele possa ser uma primary key
use dw
ALTER TABLE dim_fonte
ALTER COLUMN codigoFonte varchar(255) not null;


--criando a chave primária
ALTER TABLE dim_fonte
  ADD PRIMARY KEY (codigoFonte);

--credor (cod_credor, dsc_nome_credor)
use ods
select distinct
	cod_credor as codigoCredor,
	dsc_nome_credor as descricaoNomeCredor
	into dw..dim_credor
from tabelaODS 

--ajustando o campo para que ele possa ser uma primary key
use dw
ALTER TABLE dim_credor
ALTER COLUMN codigoCredor varchar(255) not null;

--criando a chave primária
ALTER TABLE dim_credor
  ADD PRIMARY KEY (codigoCredor);


--criando chaves estrangeiras
ALTER TABLE fato_empenho
ALTER COLUMN codigoOrgao varchar(255);

ALTER TABLE fato_empenho
  ADD FOREIGN KEY (codigoOrgao) REFERENCES dim_orgao (codigoOrgao);

ALTER TABLE fato_empenho
ALTER COLUMN codigoCredor varchar(255);

ALTER TABLE fato_empenho
  ADD FOREIGN KEY (codigoCredor) REFERENCES dim_credor (codigoCredor);


ALTER TABLE fato_empenho
ALTER COLUMN codigoFonte varchar(255);

ALTER TABLE fato_empenho
  ADD FOREIGN KEY (codigoFonte) REFERENCES dim_fonte (codigoFonte);
--dimensões

-- Criando tabela dimensão calendário
CREATE TABLE dim_calendario
(
	
    Dia int,
    Mês int,
    MêsNome varchar(255),
    trimestre int,
    Ano int,
);


-- Populando tabela dim_calendário
INSERT INTO dim_calendario (Dia, Mês, MêsNome, trimestre, Ano)
SELECT DISTINCT
			   DAY(dataPagamento)                                 AS Dia
			 , MONTH(dataPagamento)                               AS Mês
			 , DATENAME(MONTH, dataPagamento)                     AS MêsNome
			 , CEILING(CAST(MONTH(dataPagamento) AS decimal) / 3.0) AS trimestre
			 , YEAR(dataPagamento)                                AS Ano
FROM fato_empenho
WHERE dataPagamento IS NOT NULL;  -- Adicione este filtro se necessário













