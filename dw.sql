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


USE dw;

-- Criar a tabela dim_tempo
CREATE TABLE dim_tempo (
    ano INT NOT NULL,
    mes INT NOT NULL,
    trimestre INT NOT NULL,
    dia INT NOT NULL,
    data DATE PRIMARY KEY
);

-- Populando os valores dessa tabela dim_tempo
DECLARE @anoInicial INT = 2019;
DECLARE @anoFinal INT = 2022;

WHILE @anoInicial <= @anoFinal
BEGIN
    DECLARE @mes INT = 1;

    WHILE @mes <= 12
    BEGIN
        DECLARE @dia INT = 1;

        WHILE @dia <= DAY(EOMONTH(CAST(@anoInicial AS VARCHAR) + '-' + CAST(@mes AS VARCHAR) + '-01'))
        BEGIN
            DECLARE @data DATE = CAST(@anoInicial AS VARCHAR) + '-' + CAST(@mes AS VARCHAR) + '-' + CAST(@dia AS VARCHAR);
            DECLARE @trimestre INT = (MONTH(@data) - 1) / 3 + 1;

            INSERT INTO dim_tempo (ano, mes, trimestre, dia, data)
            VALUES (@anoInicial, @mes, @trimestre, @dia, @data);

            SET @dia = @dia + 1;
        END

        SET @mes = @mes + 1;
    END

    SET @anoInicial = @anoInicial + 1;
END

