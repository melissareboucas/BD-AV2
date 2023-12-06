# Análise de dados de Empenhos

## Objetivos

Este projeto tem como objetivo realizar uma análise de dados com base na execução financeira, utilizando a base de dados "Execução Financeira V4". A análise abrange desde a extração dos dados até a apresentação visual das informações relevantes no power BI.

## Extração dos dados

* Fonte dos dados: Base: [Execução Financeira V4](https://drive.google.com/file/d/1h-6UtjhyjqG1TqWoiwOzZPCb_qS1n0Bp/view?usp=sharing)
* Processos realizados:
    * Exportação do banco
    * Criação do banco ODS e ajuste dos dados

### Exportação do banco
Nesse projeto utilizamos o `SQL Server Management Studio`.

Primeiro, fizemos a restauração do banco: clicar com o botão direito no banco e selecionar Restaurar Banco de Dados:
![Untitled](https://github.com/melissareboucas/BD-AV2/assets/86539553/aaa5dcb4-0569-4783-9fdf-fb17e7ccd6e9)

![Untitled (1)](https://github.com/melissareboucas/BD-AV2/assets/86539553/0cfc6e72-9239-474c-ac6d-b63c5519c219)

![Untitled (2)](https://github.com/melissareboucas/BD-AV2/assets/86539553/1c0d099b-1117-4744-bb4e-85bbcc5d1df5)

![Untitled (3)](https://github.com/melissareboucas/BD-AV2/assets/86539553/85bbb591-c2b0-4a6b-b509-affe70e0a306)

![Untitled (4)](https://github.com/melissareboucas/BD-AV2/assets/86539553/1e6e62c2-2b7f-40b3-a277-208333e8b15a)

![Untitled (5)](https://github.com/melissareboucas/BD-AV2/assets/86539553/8244c3f7-f909-478d-bec6-453d10dc5355)

![Untitled (6)](https://github.com/melissareboucas/BD-AV2/assets/86539553/45ebdabc-2104-452e-a2bf-f51c691f333c)

### Criação do banco ODS
```
-- Criação do banco ODS
create database ods

--Extração dos dados em produção para o banco ods
SELECT *
INTO ods.dbo.tabelaODS
FROM Financeiro.dbo.tb_execucao_financeira;
```

### Tratamento banco ODS
#### Identificação dos dados ausentes
Análise de cada coluna para identificar valores nulos ou ausentes. Após essa análise, optamos por excluir duas colunas da base por terem seus valores 100% nulos.

Análise em python:
```
import pandas as pd

# Configura o Pandas para mostrar 
#todas as linhas e colunas

pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)

# Exporta a base a ser analisada
dados = pd.read_csv('financeiro.csv', delimiter=';')

valores_nulos = dados.isnull().sum()

colunas_com_nulos = valores_nulos[valores_nulos > 0]
print("Colunas com valores nulos:")
print(colunas_com_nulos)
```
![Untitled (7)](https://github.com/melissareboucas/BD-AV2/assets/86539553/522cf449-81ad-469b-9aa6-d2b52adfb05a)

Análise em sql:
```
--Validação e limpeza dos campos

SELECT 
    SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_id,
    SUM(CASE WHEN num_ano IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_num_ano,
    SUM(CASE WHEN cod_ne IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_cod_ne,
    SUM(CASE WHEN codigo_orgao IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_codigo_orgao,
    SUM(CASE WHEN dsc_orgao IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dsc_orgao,
    SUM(CASE WHEN cod_credor IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_cod_credor,
    SUM(CASE WHEN dsc_nome_credor IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dsc_nome_credor,
    SUM(CASE WHEN cod_fonte IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_cod_fonte,
    SUM(CASE WHEN dsc_fonte IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dsc_fonte,
    SUM(CASE WHEN cod_funcao IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_cod_funcao,
    SUM(CASE WHEN cod_item IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_cod_item,
    SUM(CASE WHEN dsc_item IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dsc_item,
    SUM(CASE WHEN cod_item_elemento IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_cod_item_elemento,
    SUM(CASE WHEN dsc_item_elemento IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dsc_item_elemento,
    SUM(CASE WHEN cod_item_categoria IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_cod_item_categoria,
    SUM(CASE WHEN dsc_item_categoria IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dsc_item_categoria,
    SUM(CASE WHEN cod_item_grupo IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_cod_item_grupo,
    SUM(CASE WHEN dsc_item_grupo IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dsc_item_grupo,
    SUM(CASE WHEN dsc_modalidade_licitacao IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dsc_modalidade_licitacao,
    SUM(CASE WHEN cod_item_modalidade IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_cod_item_modalidade,
    SUM(CASE WHEN dsc_item_modalidade IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dsc_item_modalidade,
    SUM(CASE WHEN cod_programa IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_cod_programa,
    SUM(CASE WHEN dsc_programa IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dsc_programa,
    SUM(CASE WHEN cod_subfuncao IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_cod_subfuncao,
    SUM(CASE WHEN dsc_subfuncao IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dsc_subfuncao,
    SUM(CASE WHEN num_sic IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_num_sic,
    SUM(CASE WHEN cod_np IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_cod_np,
    SUM(CASE WHEN vlr_empenho IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_vlr_empenho,
    SUM(CASE WHEN valor_pago IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_valor_pago,
    SUM(CASE WHEN vlr_resto_pagar IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_vlr_resto_pagar,
    SUM(CASE WHEN dth_empenho IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dth_empenho,
    SUM(CASE WHEN dth_pagamento IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dth_pagamento,
    SUM(CASE WHEN dth_processamento IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dth_processamento,
    SUM(CASE WHEN num_ano_np IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_num_ano_np
    SUM(CASE WHEN dth_liquidacao IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_dth_liquidacao,
    SUM(CASE WHEN vlr_liquidado IS NULL THEN 1 ELSE 0 END) AS quantidade_de_nulos_vlr_liquidado

FROM dbo.tabelaODS;
```
Resultados obtidos:
| Nome da coluna              | Quantidade de nulos | Percentual de nulos aproximado |
|-----------------------------|----------------------|--------------------------------|
| id                          | 0                    | 0%                             |
| num_ano                     | 0                    | 0%                             |
| cod_ne                      | 0                    | 0%                             |
| codigo_orgao                | 0                    | 0%                             |
| dsc_orgao                   | 116                  | 0,05%                          |
| cod_credor                  | 0                    | 0%                             |
| dsc_nome_credor             | 0                    | 0%                             |
| cod_fonte                   | 2775                 | 0,0136%                        |
| dsc_fonte                   | 2775                 | 0,0136%                        |
| cod_funcao                  | 0                    | 0%                             |
| cod_item                    | 287982               | 14,21%                         |
| dsc_item                    | 287982               | 14,21%                         |
| cod_item_elemento           | 1366                 | 0,0673%                        |
| dsc_item_elemento           | 1366                 | 0,0673%                        |
| cod_item_categoria          | 0                    | 0%                             |
| dsc_item_categoria          | 0                    | 0%                             |
| cod_item_grupo              | 1134605              | 55,99%                         |
| dsc_item_grupo              | 1134605              | 55,99%                         |
| dsc_modalidade_licitacao    | 401656               | 19,82%                         |
| cod_item_modalidade         | 0                    | 0%                             |
| dsc_item_modalidade         | 0                    | 0%                             |
| cod_programa                | 0                    | 0%                             |
| dsc_programa                | 0                    | 0%                             |
| cod_subfuncao               | 0                    | 0%                             |
| dsc_subfuncao               | 0                    | 0%                             |
| num_sic                     | 855132               | 42,21%                         |
| cod_np                      | 109765               | 5,42%                          |
| vlr_empenho                 | 0                    | 0%                             |
| valor_pago                  | 109765               | 5,42%                          |
| vlr_resto_pagar             | 0                    | 0%                             |
| dth_empenho                 | 0                    | 0%                             |
| dth_pagamento               | 109765               | 5,42%                          |
| dth_processamento           | 0                    | 0%                             |
| num_ano_np                  | 109765               | 5,42%                          |
| dth_liquidacao              | 2025116              | 100%                           |
| vlr_liquidado               | 2025116              | 100%  

Chegamos a conclusão que há duas colunas com todos os valores nulos, a coluna dth_liquidacao e vlr_liquidado, vamos então excluir ela com os comandos abaixo:
```

--deletando a coluna
ALTER TABLE dbo.tabelaODS
DROP COLUMN dth_liquidacao;

--deletando a coluna
ALTER TABLE dbo.tabelaODS
DROP COLUMN vlr_liquidado;
```

#### Identificação das duplicatas
Antes de iniciarmos a identifiação de duplicatas foi necessário transformar os campos que estavam com o tipo `text` para `varchar(max)`. 

Utilizamos o seguinte código para essa manipulação:
```
--alterando os tipos de campos text das colunas
ALTER TABLE dbo.tabelaODS
ALTER COLUMN num_ano varchar(max)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN cod_ne VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN codigo_orgao VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN dsc_orgao VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN cod_credor VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN dsc_nome_credor VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN cod_fonte VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN dsc_fonte VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN cod_funcao VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN dsc_funcao VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN cod_item VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN dsc_item VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN cod_item_elemento VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN dsc_item_elemento VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN cod_item_categoria VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN dsc_item_categoria VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN cod_item_grupo VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN dsc_item_grupo VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN dsc_modalidade_licitacao VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN cod_item_modalidade VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN dsc_item_modalidade VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN cod_programa VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN dsc_programa VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN cod_subfuncao VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN dsc_subfuncao VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN num_sic VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN cod_np VARCHAR(MAX)

ALTER TABLE dbo.tabelaODS
ALTER COLUMN num_ano_np VARCHAR(MAX)
```

Análise das duplicatas em python:
```
import pandas as pd

# Carregar o arquivo CSV para um DataFrame do Pandas
caminho_arquivo = 'seu_arquivo.csv, '
dados = pd.read_csv('financeiro.csv', delimiter=';')

# Verificar duplicados em todo o DataFrame
duplicados = dados[dados.duplicated()]

# Contar o número de linhas duplicadas
num_duplicados = len(duplicados)
print(f"Número de linhas duplicadas: {num_duplicados}")

# Exibir as linhas duplicadas
if num_duplicados > 0:
    print("Linhas duplicadas:")
    print(duplicados)
```
![Untitled (8)](https://github.com/melissareboucas/BD-AV2/assets/86539553/88243507-c738-45f9-aeb7-da2f61c7ef59)

Análise das duplicatas em sql:
```
--validando duplicatas
select id,num_ano, cod_ne, codigo_orgao, dsc_orgao, cod_credor, dsc_nome_credor,
cod_fonte, dsc_fonte, cod_funcao, dsc_funcao, cod_item, dsc_item, cod_item_elemento,
dsc_item_elemento, cod_item_categoria, dsc_item_categoria, cod_item_grupo,
dsc_item_grupo, dsc_modalidade_licitacao, cod_item_modalidade, dsc_item_modalidade,
cod_programa, dsc_programa, cod_subfuncao, dsc_subfuncao, num_sic, cod_np,
vlr_empenho, valor_pago, vlr_resto_pagar, dth_empenho, dth_pagamento, dth_processamento, num_ano_np, count(*) 
from dbo.tabelaODS
group by id, num_ano, cod_ne, codigo_orgao, dsc_orgao, cod_credor, dsc_nome_credor,
cod_fonte, dsc_fonte, cod_funcao, dsc_funcao, cod_item, dsc_item, cod_item_elemento,
dsc_item_elemento, cod_item_categoria, dsc_item_categoria, cod_item_grupo,
dsc_item_grupo, dsc_modalidade_licitacao, cod_item_modalidade, dsc_item_modalidade,
cod_programa, dsc_programa, cod_subfuncao, dsc_subfuncao, num_sic, cod_np,
vlr_empenho, valor_pago, vlr_resto_pagar, dth_empenho, dth_pagamento, dth_processamento, num_ano_np
having COUNT(*) > 1;
```
Como não foram encontrados registros duplicados, nada foi deletado.

#### Padronização dos dados
Para os campos de data, os valores não precisavam estar em `datetime` pois a hora não estava sendo utilizada, por isso convertemos para `date`:
SQL:
```
--Padronização de dados:
--datas

	SELECT DISTINCT dth_empenho
	FROM dbo.tabelaODS;
	--não há uma hora de fato sendo registrada, podemos alterar par date no formato 'YYYY-MM-DD'
	ALTER TABLE dbo.tabelaODS
	ALTER COLUMN dth_empenho DATE;

	SELECT DISTINCT dth_pagamento
	FROM dbo.tabelaODS;
	--não há uma hora de fato sendo registrada, podemos alterar par date no formato 'YYYY-MM-DD'
	ALTER TABLE dbo.tabelaODS
	ALTER COLUMN dth_pagamento DATE;

	SELECT DISTINCT dth_processamento
	FROM dbo.tabelaODS;
	--não há uma hora de fato sendo registrada, podemos alterar par date no formato 'YYYY-MM-DD'
	ALTER TABLE dbo.tabelaODS
	ALTER COLUMN dth_processamento DATE;
```
Para os campos de descrição, mantemos o ajuste para o tipo `varchar` feito anteriormente.

Para verificarmos se existe um código com mais de uma descrição usamos o seguinte comando:
SQL
```
-- Verificar a duplicidade de descrição para um código

	SELECT
		tipo_entidade,
		codigo,
		STRING_AGG(descricao, ' | ') AS descricoes_duplicadas
	FROM (
		SELECT DISTINCT
			tipo_entidade,
			codigo,
			descricao
		FROM (
			SELECT 'fonte' AS tipo_entidade, cod_fonte AS codigo, dsc_fonte AS descricao FROM dbo.tabelaODS WHERE cod_fonte IS NOT NULL AND dsc_fonte IS NOT NULL
			UNION ALL
			SELECT 'orgao' AS tipo_entidade, codigo_orgao AS codigo, dsc_orgao AS descricao FROM dbo.tabelaODS WHERE codigo_orgao IS NOT NULL AND dsc_orgao IS NOT NULL
			UNION ALL
			SELECT 'credor' AS tipo_entidade, cod_credor AS codigo, dsc_nome_credor AS descricao FROM dbo.tabelaODS WHERE cod_credor IS NOT NULL AND dsc_nome_credor IS NOT NULL
	 ) AS entidades
	) AS sub
	GROUP BY
		tipo_entidade,
		codigo
	HAVING
		COUNT(*) > 1;
```

1. Fonte
Em fonte, Como se tratam de coisas distintas decidimos por criar novos códigos para cada, aqueles que fazem parte da mesma premissa colocamos o B, e os que são diferentes criamos um codigo numerico que ainda não foi utilizado.

| Código     | Descrições duplicadas                                                                                           |
|------------|------------------------------------------------------------------------------------------------------------------|
| 00         | RECURSOS ORDINÁRIOS - CESSÃO ONEROSA - BÔNUS DE ASSINATURA DO PRÉ-SAL                                            |
| 00B        | RECURSOS ORDINÁRIOS                                                                                             |
| 46         | OPERAÇÕES DE CRÉDITO INTERNAS                                                                                  |
| 46B        | OPERAÇÕES DE CRÉDITO INTERNAS - TESOURO                                                                        |
| 48         | OPERAÇÕES DE CRÉDITO EXTERNAS                                                                                 |
| 48B        | OPERAÇÕES DE CRÉDITO EXTERNAS - TESOURO                                                                       |
| 50         | RECURSOS PROVENIENTES DO FUNDEB                                                                               |
| 02         | ARRECADAÇÃO AUTOMÁTICA                                                                                        |
| 70         | RECURSOS DIRETAMENTE ARRECADADOS                                                                              |
| 70B        | OUT. FONTES, RECURSOS DIRETAMENTE ARRECADADOS                                                                 |
| 73         | TRANSFERÊNCIAS DIRETAS - OUTRAS                                                                               |
| 73B        | TRANSFERÊNCIAS DIRETAS DO FNDE                                                                                |
| 80         | CONVÊNIOS COM ÓRGÃOS INTERNACIONAIS - ADMINISTRAÇÃO DIRETA                                                   |
| 80B        | CONVÊNIOS COM ÓRGÃOS INTERNACIONAIS - ADMINISTRAÇÃO INDIRETA                                                 |
| 88         | CONVÊNIOS COM ÓRGÃOS PRIVADOS - ADMINISTRAÇÃO DIRETA                                                          |
| 88B        | CONVÊNIOS COM ÓRGÃOS PRIVADOS                                                                                 |
| 92         | REPASSE FUNDO A FUNDO                                                                                         |
| 92B        | REPASSE FUNDO A FUNDO - FNAS   

SQL
```
-- -- Podemos usar o seguinte comando para ajustá-los:
	UPDATE tabelaODS
	SET cod_fonte =
		CASE
			WHEN dsc_fonte = 'RECURSOS ORDINÁRIOS - CESSÃO ONEROSA - BÔNUS DE ASSINATURA DO PRÉ-SAL' THEN '00B'
			WHEN dsc_fonte = 'OPERAÇÕES DE CRÉDITO INTERNAS - TESOURO' THEN '46B'
			WHEN dsc_fonte = 'OPERAÇÕES DE CRÉDITO EXTERNAS - TESOURO' THEN '48B'
			WHEN dsc_fonte = 'OUT. FONTES, RECURSOS DIRETAMENTE ARRECADADOS' THEN '70B'
			WHEN dsc_fonte = 'TRANSFERÊNCIAS DIRETAS - OUTRAS' THEN '73B'
			WHEN dsc_fonte = 'CONVÊNIOS COM ÓRGÃOS INTERNACIONAIS - ADMINISTRAÇÃO INDIRETA' THEN '80B'
			WHEN dsc_fonte = 'CONVÊNIOS COM ÓRGÃOS PRIVADOS - ADMINISTRAÇÃO DIRETA' THEN '88B'
			WHEN dsc_fonte = 'REPASSE FUNDO A FUNDO - FNAS' THEN '92B'
			WHEN dsc_fonte = 'ARRECADAÇÃO AUTOMÁTICA' THEN '02'
			ELSE cod_fonte
		END;
```
2. Órgão
Em orgão, como se trata de descrição diferente mas querem dizer a mesma coisa, padronizamos um unico nome para os codigos.

| Código     | Descrições duplicadas                                                                                           |
|------------|------------------------------------------------------------------------------------------------------------------|
| 10101  | FUNDO DE PREVIDENCIA PARLAMENTAR DA ASSEMBLEIA LEGISLATIVA DO CE |
| 310601 | FUNDACAO NUCLEO DE TECNOLOGIA INDUSTRIAL DO CEARA          |
| 560001 | SECRETARIA DO DESENVOLVIMENTO ECONÔMICO E TRABALHO         |

SQL
```
UPDATE tabelaODS
	SET dsc_orgao = 
	  CASE 
		WHEN codigo_orgao = 010101 THEN 'FUNDO DE PREVIDENCIA PARLAMENTAR DA ASSEMBLEIA LEGISLATIVA DO CE'
		WHEN codigo_orgao = 310601 THEN 'NUCLEO DE TECNOLOGIA E QUALIDADE INDUSTRIAL DO CEARA'
		WHEN codigo_orgao = 560001 THEN 'SECRETARIA DO DESENVOLVIMENTO ECONÔMICO E TRABALHO'
		ELSE dsc_orgao -- mantém o valor existente 
	  END
	WHERE codigo_orgao in (010101,310601, 560001)


```

3. Credor
Em credor, seguimos escolhendp o que houvesse mais linhas preenchidas ou fosse cnpj:

`exemplo somente com algumas linhas da tabela, no código abaixo temos de fato todas as modificações`
| Código   | Descrição                                        |
|----------|---------------------------------------------------|
| 00001779 | FARMACE INDUSTRIA QUIMICO FARMACEUTICA CEARENSE LTDA   |
| 00002252 | COMPANHIA DE AGUA E ESGOTO DO CEARA - CAGECE     |
| 00002286 | COMPANHIA ENERGÉTICA DO CEARÁ                     |
| 00002863 | CASA DE SAUDE E MATERNIDADE SAO RAIMUNDO S A      |
| 00003108 | HOSPITAL DE OLHOS LEIRIA DE ANDRADE LTDA.        |


SQL
```
UPDATE tabelaODS
	SET dsc_nome_credor = 
	CASE 
		WHEN cod_credor = '00001779' THEN 'FARMACE INDUSTRIA QUIMICO FARMACEUTICA CEARENSE LTDA'
		WHEN cod_credor = '00002252' THEN 'COMPANHIA DE AGUA E ESGOTO DO CEARA - CAGECE'
		WHEN cod_credor = '00002286' THEN 'COMPANHIA ENERGÉTICA DO CEARÁ'
		WHEN cod_credor = '00002863' THEN 'CASA DE SAUDE E MATERNIDADE SAO RAIMUNDO S A'
		WHEN cod_credor = '00003108' THEN 'HOSPITAL DE OLHOS LEIRIA DE ANDRADE LTDA.'
		WHEN cod_credor = '00003268' THEN 'SERVAL E SERVICOS E LIMPEZA LTDA'
		WHEN cod_credor = '00004145' THEN 'SERVI PECAS LTDA'
		WHEN cod_credor = '00004428' THEN 'CLINICA RADIOLOGICA MARIO DE ASSIS LTDA'
		WHEN cod_credor = '00004435' THEN 'CAUBI INDUSTRIA E COMERCIO DE PLACAS LTDA'
		WHEN cod_credor = '00004926' THEN 'EMILIO RIBAS MEDICINA DIAGNOSTICA LTDA.'
		WHEN cod_credor = '00005273' THEN 'FREITAS & ALENCAR LTDA'
		WHEN cod_credor = '00006383' THEN 'GELAR REFRIGERACAO COMERCIAL LTDA - ME'
		WHEN cod_credor = '00006648' THEN 'INSTITUTO NACIONAL DE DESENVOLVIMENTO SOCIAL E QUALIFICAÇÃO PROFISSIONAL'
		WHEN cod_credor = '00008655' THEN 'BANCO DO BRASIL SA'
		WHEN cod_credor = '00009041' THEN 'SERVIÇO AUTONOMO DE AGUA E ESGOTO DE SOBRAL'
		WHEN cod_credor = '00009392' THEN 'LABORATORIO DE PATOLOGIA CLINICA DR GASPAR VIANA LTDA'
		WHEN cod_credor = '00011639' THEN 'M F A AGUIAR'
		WHEN cod_credor = '00011737' THEN 'EXPRESSAO GRAFICA E EDITORA  LTDA'
		WHEN cod_credor = '00012714' THEN 'SERVICO AUTONOMO DE AGUA E ESGOTO DE BOA VIAGEM'
		WHEN cod_credor = '00012749' THEN 'PIRAMIDE INFORMATICA E EQUIPAMENTOS LTDA'
		WHEN cod_credor = '00013854' THEN 'SERVICO AUTONOMO DE AGUA E ESGOTO DE IGUATU'
		WHEN cod_credor = '00014361' THEN 'CAFAZ CAIXA DE ASS DOS SERV FAZENDARIOS'
		WHEN cod_credor = '00015927' THEN 'FANAMED COMERCIO E SERVICOS DE MANUTENCAO EM EQUIPAMENTOS MEDICO-HOSPITALARES LTDA'
		WHEN cod_credor = '00016972' THEN 'SERH SERVIÇOS ESPECIALIZADOS EM REC HUMANOS S/C LTDA'
		WHEN cod_credor = '00017032' THEN 'CLINICA DE RADIODIAGNOSTICO DR. MARIO MARCIO LTDA'
		WHEN cod_credor = '00018369' THEN 'TK ELEVADORES BRASIL LTDA'
		WHEN cod_credor = '00019704' THEN 'F P FACANHA COMERCIO DE ALIMENTOS LTDA'
		WHEN cod_credor = '00027457' THEN 'TELECOM TELEFONIA COMÉRCIO E REPRESENTAÇÕES LTDA -EPP'
		WHEN cod_credor = '00028832' THEN 'ASSOCIACAO BRAS DE RECURSOS HUMANOS'
		WHEN cod_credor = '00029870' THEN 'ARILUB DISTRIBUIDOR DE ÓLEOS E ADITIVOS LTDA - EPP'
		WHEN cod_credor = '00031824' THEN 'FRANCISCA VALDA FACO LEITAO'
		WHEN cod_credor = '00032660' THEN 'FRANCISCO PINTO DE ARAUJO E OUTROS'
		WHEN cod_credor = '00037598' THEN 'OMEGA DISTRIBUIDORA DE PRODUTOS ALIMENTICIOS EIRELI'
		WHEN cod_credor = '00038787' THEN 'MIGUEL ALEXANDRE AMORIM NASCIMENTO'
		WHEN cod_credor = '00038808' THEN 'R FURLANI ENGENHARIA LTDA'
		WHEN cod_credor = '00039903' THEN 'INSTITUTO DE CLINICA E CIRURGIA S/S LTDA'
		WHEN cod_credor = '00040134' THEN 'EEFM RAIMUNDO MOACIR ALENCAR MOTA'
		WHEN cod_credor = '00040148' THEN 'EEFM ESTADO DA BAHIA'
		WHEN cod_credor = '00041487' THEN 'INSTITUTO DE ANÁLISES CLÍNICAS E PESQUISAS DO CEARÁ LTDA - EPP'
		WHEN cod_credor = '00043126' THEN 'ECO +  SERVICOS AMBIENTAIS E IMOBILIARIA LTDA'
		WHEN cod_credor = '00047688' THEN 'FRANCISCO PAULO LIMA VERDE PEREIRA'
		WHEN cod_credor = '00055383' THEN 'ANTO HUMBERTO SOARES DE FREITAS E OUTROS'
		WHEN cod_credor = '00056243' THEN 'FRANCISCO ZELIO MARTINS DE MENEZES JUNIOR'
		WHEN cod_credor = '00060871' THEN 'AMBROSINA MARIA DE ARAUJO'
		WHEN cod_credor = '00063429' THEN 'ANTONIO RODRIGUES CARNEIRO'
		WHEN cod_credor = '00065167' THEN 'POLITEC IMPORTACAO E COMERCIO LTDA'
		WHEN cod_credor = '00068856' THEN 'ASSOCIAÇAO NACIONAL DE ENTIDADES PROMOTORAS DE EMPREENDIMENTOS INOVADORES -ANPROTEC'
		WHEN cod_credor = '00070541' THEN 'ANTONIO IVANILDO CAETANO COSTA E OUTROS'
		WHEN cod_credor = '00072322' THEN 'PROLIMP  PRODUTOS E SERVIÇOS EIRELI EPP'
		WHEN cod_credor = '00075353' THEN 'SUPRIMAX COMERCIAL LTDA'
		WHEN cod_credor = '00079473' THEN 'HEXIS CIENTIFICA LTDA'
		WHEN cod_credor = '00080700' THEN 'BLAU FARMACEUTICA S.A.'
		WHEN cod_credor = '00087436' THEN 'A.L. TEIXEIRA PINHEIRO'
		WHEN cod_credor = '00096758' THEN 'WIPRO DO BRASIL SERVICOS LTDA.'
		WHEN cod_credor = '00106896' THEN 'AFRANIO ABREL PATRICIO'
		WHEN cod_credor = '00114000' THEN 'K. L. SERVICOS E SERIGRAFIA LTDA'
		WHEN cod_credor = '00117261' THEN 'COOPEND - COOPERATIVA DE ENDOSCOPIA DO  CEARA LTDA'
		WHEN cod_credor = '00117455' THEN 'HELIO ALVES DA SILVA'
		WHEN cod_credor = '00125976' THEN 'ACECO TI LTDA.'
		WHEN cod_credor = '00126835' THEN 'ART MEDICA COMERCIO E REPRESENTACOES DE PRODUTOS HOSPITALARES LTDA'
		WHEN cod_credor = '00131690' THEN 'CONECTA EQUIPAMENTOS E SERVICOS LTDA'
		WHEN cod_credor = '00132037' THEN 'SARA - SERVICO DE APOIO AO RENAL AGUDO LTDA'
		WHEN cod_credor = '00134311' THEN 'FUNDO NACIONAL DE SAUDE'
		WHEN cod_credor = '00139048' THEN 'ELIZABETH SILVA LOPES'
		WHEN cod_credor = '00139070' THEN 'VALDEMAR ARAUJO DOS SANTOS'
		WHEN cod_credor = '00142782' THEN 'STEFANINI CONSULTORIA E ASSESSORIA EM INFORMATICA S.A.'
		WHEN cod_credor = '00143218' THEN 'FRANCISCA DE FATIMA DIVINO DE ARAUJO'
		WHEN cod_credor = '00143494' THEN 'CEMERGE COOPERATIVA DE TRABALHO DOS MEDICOS EMERGENCISTAS DO CEARA LTDA'
		WHEN cod_credor = '00147194' THEN 'HOSPFAR INDUSTRIA E COMERCIO DE PRODUTOS   HOSPITALARES S/A'
		WHEN cod_credor = '00151024' THEN 'EMPRESA DE TECNOLOGIA DA INFORMAÇÃO DO CEARA - ETICE'
		WHEN cod_credor = '00153395' THEN 'GESTOR SERVIÇOS EMPRESARIAIS LTDA'
		WHEN cod_credor = '00158648' THEN 'ENFERMED COMERCIO DE MATERIAIS MEDICO- HOSPITALARES LTDA - EPP'
		WHEN cod_credor = '00161382' THEN 'LIMP TUDO SERVICOS DE LIMPEZA E CONSERVACAO LTDA'
		WHEN cod_credor = '00162880' THEN 'GIOVANI SERVICOS ARCONDICIONADO LTDA'
		WHEN cod_credor = '00165261' THEN 'PRONTO CIRÚRGICO S/S LTDA'
		WHEN cod_credor = '00167313' THEN 'MYRTON CABRAL NETO'
		WHEN cod_credor = '00169927' THEN 'COOCIRURGE - COOPERATIVA DOS CIRURGIOES GERAIS DO CEARA LTDA'
		WHEN cod_credor = '00170761' THEN 'SERILOS COMERCIO E SERVIÇOS DE PLACAS LTDA - ME'
		WHEN cod_credor = '00174589' THEN 'CLINICA BEROALDO JUREMA LTDA'
		WHEN cod_credor = '00175395' THEN 'LOCAWEB SERVICOS DE INTERNET S/A'
		WHEN cod_credor = '00176493' THEN 'CTIS TECNOLOGIA S.A'
		WHEN cod_credor = '00180888' THEN 'CICERA ROMANA DE SOUZA CARVALHO ME'
		WHEN cod_credor = '00183420' THEN 'MAPFRE SEGUROS GERAIS S.A'
		WHEN cod_credor = '00192510' THEN 'CLÍNICA LÚCIA TAVARES LTDA'
		WHEN cod_credor = '00192691' THEN 'RICOPIA COMERCIO E SERVICOS LTDA - ME'
		WHEN cod_credor = '00193161' THEN 'REGIFARMA COMERCIO DE PRODUTOS HOSPITALARES LTDA'
		WHEN cod_credor = '00193294' THEN 'FUNDO DE PREVIDENCIA PARLAMENTAR DA ASSEMB LEGISL DO CE'
		WHEN cod_credor = '00193750' THEN 'CTI CENTRO DE TERAPIA INTEGRADA LTDA - ME'
		WHEN cod_credor = '00196087' THEN 'HELENO CARNEIRO ROLIM DE MORAIS & CIA LTDA'
		WHEN cod_credor = '00196423' THEN 'ALUMIPLACAS SHQ NOGUEIRA INDUSTRIA DE PLACAS LTDA'
		WHEN cod_credor = '00198594' THEN 'LOC SERVICE LTDA.'
		WHEN cod_credor = '00201927' THEN 'SOLUCAO SERVICOS COMERCIO E CONSTRUCAO EIRELI'
		WHEN cod_credor = '00205130' THEN 'DECIO SIMOES PEREIRA'
		WHEN cod_credor = '00208464' THEN 'TOP COMERCIO E INDUSTRIA DE CONFECCOES E SERVICOS EIRELI'
		WHEN cod_credor = '00208731' THEN 'CENTROS DE NEGOCIOS E INVESTIMENTOS LTDA'
		WHEN cod_credor = '00213739' THEN 'RISO COMERCIAL IMPRESSORAS DIGITAIS LTDA'
		WHEN cod_credor = '00216009' THEN 'MSB COMERCIO E REPRESENTACOES LTDA'
		WHEN cod_credor = '00219414' THEN 'INTERATIVA EMPREENDIMENTOS E SERVICOS DE LIMPEZA E CONSTRUCOES LTDA'
		WHEN cod_credor = '00219593' THEN 'PRISMA DISTRIBUIDORA DE PAPEIS LTDA'
		WHEN cod_credor = '00220800' THEN 'GEFERSON SOUSA DE FIGUEIREDO'
		WHEN cod_credor = '00223843' THEN 'WJ SERVICOS DE  INFORMATICA LTDA'
		WHEN cod_credor = '00225196' THEN 'ELLO SERVICOS DE MAO DE OBRA LTDA'
		WHEN cod_credor = '00226604' THEN 'ARV COMERCIO E SERVIÇOS  ELETRICOS E DE REFRIGERAÇÃO LTDA'
		WHEN cod_credor = '00227309' THEN 'A IGOR FURTADO LIMA' 
		WHEN cod_credor = '00230767' THEN 'IMPACTO COMÉRCIO, SERVIÇOS DE EQUIPAMENTOS HOSPITALAR E LABORATORIAIS LTDA'
		WHEN cod_credor = '00233053' THEN 'DJACIRA GOMES MENDONCA MARQUES'
		WHEN cod_credor = '00233800' THEN 'ANDREZA ALVES EVANGELISTA'
		WHEN cod_credor = '00236516' THEN 'DATAINFO PESQUISA E CONSULTORIA S/S LTDA'
		WHEN cod_credor = '00236601' THEN 'PRIME FRESH SERVIÇOS E COMERCIO LTDA'
		WHEN cod_credor = '00236704' THEN 'ANTONIA RODRIGUES COUTINHO LIMA'
		WHEN cod_credor = '00238656' THEN 'CYBELLY MARQUES SILVANO'
		WHEN cod_credor = '00238705' THEN 'MINISTERIO DA INTEGRACAO NACIONAL E DO DESENVOLVIMENTO REGIONAL'
		WHEN cod_credor = '00241016' THEN 'HERSON ENGENHARIA CONSTRUCAO INCORPORACAO E AVALIACOES LTDA'
		WHEN cod_credor = '00241999' THEN 'MARIA DE FATIMA BENICIO SANTOS'
		WHEN cod_credor = '00245663' THEN 'ROBERTO CESAR  LIMA SALOMAO'
		WHEN cod_credor = '00249151' THEN 'MAXIM QUALITTA COMERCIO LTDA'
		WHEN cod_credor = '00250814' THEN 'FLAUDENIA DE ASSIS MENDONÇA E OUTROS'
		WHEN cod_credor = '00252965' THEN 'ORTOGENESE COMÉRCIO E IMPORTAÇÃO DE MATERIAIS MÉDICOS E CIRÚRGICOS LTDA'
		WHEN cod_credor = '00254074' THEN 'CRIART SERVICOS DE TERCEIRIZACAO DE MAO DE OBRA LTDA'
		WHEN cod_credor = '00255162' THEN 'AUDIPLAC AUDITORIA E ASSESSORIA CONTABIL S/S'
		WHEN cod_credor = '00262614' THEN 'TOTAL CLIPPING DE NOTICIA LTDA'
		WHEN cod_credor = '00264504' THEN 'FRED CARVALHO LOPES'
		WHEN cod_credor = '00264791' THEN 'MAKE LINE COMERCIAL LTDA'
		WHEN cod_credor = '00265238' THEN 'ARCOVERDE ASSISTÊNCIA MÉDICA LTDA'
		WHEN cod_credor = '00266377' THEN 'SOLUTIONS LOCACAO DE EQUIPAMENTOS DE INFORMATICA LTDA'
		WHEN cod_credor = '00268005' THEN 'AGRADA CONSTRUCOES E SERVICOS LTDA'
		WHEN cod_credor = '00268298' THEN 'NP CAPACITACAO E SOLUCOES TECNOLOGICAS LTDA'
		WHEN cod_credor = '00271793' THEN 'DISTRIBUIDORA FACANHA COMERCIO DE ALIMENTOS LTDA'
		WHEN cod_credor = '00272496' THEN 'FERNANDES CONSTRUCOES EIRELI'
		WHEN cod_credor = '00273137' THEN 'ANTONIO SEVERINO DE PINHO'
		WHEN cod_credor = '00273902' THEN 'IRANEIDE PEREIRA DE ARAUJO'
		WHEN cod_credor = '00274565' THEN 'EDILSON LOPES DE MOURA'
		WHEN cod_credor = '00275681' THEN 'JULIANA GOMES FROTA'
		WHEN cod_credor = '00279409' THEN 'NSCONTROL SERVICOS DE INFORMATICA LTDA'
		WHEN cod_credor = '00280741' THEN 'BANCO SANTANDER (BRASIL) S.A.'
		WHEN cod_credor = '00280888' THEN 'R & R DEDETIZAÇÕES E SERVIÇOS LTDA'
		WHEN cod_credor = '00281595' THEN 'F W C CONSTRUCOES EIRELI'
		WHEN cod_credor = '00282827' THEN 'VOLT  LOCAÇÃO  DE EQUIPAMENTOS  EIRELI –EP'
		WHEN cod_credor = '00282903' THEN 'HOSTWEB DATA CENTER E SERVICOS EIRELI'
		WHEN cod_credor = '00283243' THEN 'RUBLENIO BERGSON GOMES'
		WHEN cod_credor = '00283411' THEN 'BMK-AP EMPREENDIMENTOS EIRELI'
		WHEN cod_credor = '00283646' THEN 'VERA LUCIA AMERICO FARIAS'
		WHEN cod_credor = '00285692' THEN 'BHIO SUPPLY INDUSTRIA E COMERCIO DE EQUIPAMENTOS MEDICOS LTDA'
		WHEN cod_credor = '00286566' THEN 'TCI BPO - TECNOLOGIA CONHECIMENTO E INFORMAÇÃO S/A'
		WHEN cod_credor = '00287518' THEN 'ACCORD FARMACEUTICA LTDA'
		WHEN cod_credor = '00290004' THEN 'AGENCIA DE MIDIA JCR7 COMUNICACAO EIRELI'
		WHEN cod_credor = '00291086' THEN 'DANIEL LIMA DIOGENES'
		WHEN cod_credor = '00291092' THEN 'JOAO PAULO DOS SANTOS C VERAS E OUTROS'
		WHEN cod_credor = '00292914' THEN 'ELFA MEDICAMENTOS S.A'
		WHEN cod_credor = '00293073' THEN 'V DE PAULO MAGALHAES FILHO COMERCIO DE GAS LTDA'
		WHEN cod_credor = '00293473' THEN 'CONS DA EEF HORIZONTE DA CIDADANIA'
		WHEN cod_credor = '00295396' THEN 'LUPE INDUSTRIA TECNOLOGICA DE EQUIPAMENTOS PARA LABORATORIO LTDA'
		WHEN cod_credor = '00298351' THEN 'MDF DISTRIBUIDORA DE PRODUTOS FARMACEUTICOS E HOSPITALARES EIRELI'
		WHEN cod_credor = '00299844' THEN 'ADAMO VASCONCELOS DE OLIVEIRA EIRELI'
		WHEN cod_credor = '00303646' THEN 'CALL MED COMERCIO DE MEDICAMENTOS E REPRESENTACAO LTDA'
		WHEN cod_credor = '00307186' THEN 'HERCILIO GOMES DA SILVA FILHO'
		WHEN cod_credor = '00307421' THEN 'FRANCISCO KEINIS MOREIRA MAIA'
		WHEN cod_credor = '00315402' THEN 'BANCO DO BRASIL S/A'
		WHEN cod_credor = '00315735' THEN 'MARIA ALICE PEREIRA DA SILVA'
		WHEN cod_credor = '00322735' THEN 'SISTEMA INTEGRADO DE SANEAMENTO RURAL DA BACIA BANABUIU'
		WHEN cod_credor = '00328141' THEN 'INSTITUTO BRASILEIRO DE GOVERNANCA CORPORATIVA'
		WHEN cod_credor = '00328755' THEN 'ELOGROUP DESENVOLVIMENTO E CONSULTORIA LTDA'
		WHEN cod_credor = '00330252' THEN 'NDS DISTRIBUIDORA DE MEDICAMENTOS LTDA'
		WHEN cod_credor = '00334337' THEN 'CONSTRUTORA SOUZA REIS LTDA'
		WHEN cod_credor = '00336069' THEN 'CEMOF - CENTRO MEDICO OFTALMOLOGICO LTDA'
		WHEN cod_credor = '00336215' THEN 'ROSINEIDE DE SOUSA SILVA'
		WHEN cod_credor = '00337392' THEN 'COOPERATIVA DE TRABALHO DOS PSICOLOGOS DO CEARA LTDA COOPSIC'
		WHEN cod_credor = '00338020' THEN 'STELIO R DA SILVA ARTIGOS DENTARIOS LTDA'
		WHEN cod_credor = '00340144' THEN 'NOVEX CONSTRUCOES LTDA'
		WHEN cod_credor = '00340179' THEN 'SISTEMA INTEGRADO DE SANEAMENTO RURAL DA BACIA HID.CURU E LITORAL'
		WHEN cod_credor = '00341781' THEN 'CACAUGAS LTDA'
		WHEN cod_credor = '00344520' THEN 'ANTONIO LEONARDO FERREIRA SANTOS'
		WHEN cod_credor = '00347923' THEN 'REAL SERVICOS DE LOCACAO DE MAO DE OBRA LTDA'
		WHEN cod_credor = '00348772' THEN 'CLINICA DO CORAÇAO DR. CARLOS EFREM LUSTOSA EIRELI'
		WHEN cod_credor = '00349596' THEN 'T S COMERCIAL DE MEDICAMENTOS E REPRESENTACAO LTDA'
		WHEN cod_credor = '00350804' THEN 'PL SERVICOS MEDICOS LTDA'
		WHEN cod_credor = '00352571' THEN 'IMPRINT GRÁFICA RÁPIDA EIRELI'
		WHEN cod_credor = '00353781' THEN 'K M MOREIRA LUZ'
		WHEN cod_credor = '00354109' THEN 'FRANCISCO KLEBER DE ARAÚJO'
		WHEN cod_credor = '00355174' THEN 'CLINICA DE ORTOPEDIA DO CARIRI LTDA. - ME'
		WHEN cod_credor = '00355236' THEN 'MULTIFARMA COMERCIAL LTDA'
		WHEN cod_credor = '00356195' THEN 'DIAGLAB COMERCIO DE PRODUTOS LABORATORIAIS LTDA'
		WHEN cod_credor = '00358423' THEN 'CONFISIO - CONSULTÓRIO DE FISIOTERAPIA S/S LTDA - ME'
		WHEN cod_credor = '00358581' THEN 'ERISLANE SILVA DE PAULA'
		WHEN cod_credor = '00359614' THEN 'GAMACORP HOSPITALAR- COMERCIO DE MEDICAMENTOS LTDA'
		WHEN cod_credor = '00359827' THEN 'SHARLON FRANKLIN NUNES DE ALBURQUERQUE'
		WHEN cod_credor = '00362005' THEN 'CLINICA DE ATENCAO MEDICA BENFICA LTDA'
		WHEN cod_credor = '00362839' THEN 'DURASOL COMERCIO E REPRESENTAÇOES LTDA'
		WHEN cod_credor = '00362925' THEN 'A.P.F.P. DE ALUN. DA ESC MARTINIANO F MAGALHAES'
		WHEN cod_credor = '00363031' THEN 'MISSÃO SERVIÇOS TÉCNICOS  EIRELI'
		WHEN cod_credor = '00363146' THEN 'TARGET BONES E SERIGRAFIA EIRELI'
		WHEN cod_credor = '00364344' THEN 'ONLINE SEGURANÇA PATRIMONIAL LTDA'
		WHEN cod_credor = '00364681' THEN 'CENTRO DE APOIO AO DESENVOLVIMENTO SUSTENTAVEL DO SEMIARIDO'
		WHEN cod_credor = '00774519' THEN 'SOLUTI - SOLUÇÕES EM NEGÓCIOS INTELIGENTES S/A'
		WHEN cod_credor = '00774606' THEN 'RS TURISMO E EVENTOS LTDA'
		WHEN cod_credor = '00774689' THEN 'EDMIL CONSTRUCOES S/A'
		WHEN cod_credor = '00775518' THEN 'FORTAL TERCEIRIZACAO DE MAO DE OBRA LTDA'
		WHEN cod_credor = '00775925' THEN 'PRINT MAILING  COMERCIO SERVIÇOSE ASSISTÊNCIA TÉCNICA LTDA - EPP'
		WHEN cod_credor = '00777759' THEN 'FRANCISCO DE A S LEITE'
		WHEN cod_credor = '00778294' THEN 'ELAINE CRISTINA FERREIRA DE SOUSA'
		WHEN cod_credor = '00779361' THEN 'ATITUDE TERCEIRIZACAO DE MAO DE OBRA EIRELI'
		WHEN cod_credor = '00780037' THEN 'D V PINHEIRO - ME'
		WHEN cod_credor = '00781505' THEN 'EXCIMER TECNOLOGIA COMERCIO E ASSISTENCIA DE EQUIPAMENTOS MEDICOS E HOSPITALARES LTDA'
		WHEN cod_credor = '00782754' THEN 'LABORATORIO DE ANALISES CLINICAS MOREIRA DANTAS LTDA'
		WHEN cod_credor = '00783537' THEN 'TA2 CONSTRUCOES E EVENTOS LTDA'
		WHEN cod_credor = '00783776' THEN 'MESSEJANA SERVICOS MEDICOS LTDA'
		WHEN cod_credor = '00784519' THEN 'E  DE BRITO COMERCIO E SERVICOS LTDA'
		WHEN cod_credor = '00785172' THEN 'AGROMACE COMERCIO AGROPECUARIA LTDA'
		WHEN cod_credor = '00785326' THEN 'T. LEITE VIANA'
		WHEN cod_credor = '00785451' THEN 'ARFRIO COMÉRCIO E SERVIÇOS DE ARCONDICIONADOS LTDA - ME'
		WHEN cod_credor = '00786006' THEN 'EVANDRO SIEBRA DA SILVA'
		WHEN cod_credor = '00788774' THEN 'MEDEIROS TECNOLOGIA DA INFORMACAO LTDA'
		WHEN cod_credor = '00788836' THEN 'NORDESTE COMERCIO E SERVIÇOS ELETROMECANICOS LTDA ME'
		WHEN cod_credor = '00789342' THEN 'PREMIUM SERVIÇOS E LOCAÇÕES DE VEICULOS LTDA ME'
		WHEN cod_credor = '00789711' THEN 'ANDREZA DE A  PINTO COSTA'
		WHEN cod_credor = '00789746' THEN 'FUNDACAO DE APOIO A SERVICOS TECNICOS, ENSINO E FOMENTO A PESQUISAS - FUNDACAO ASTEF'
		WHEN cod_credor = '00793002' THEN 'PH&B COMERIO & SERVICOS LTDA'
		WHEN cod_credor = '00793049' THEN 'ALFA LOCAÇÃO DE EQUIPAMENTOS LTDA'
		WHEN cod_credor = '00795831' THEN 'COITE COMÉRCIO CONSTRUÇÕES E SERVIÇOS LTDA - ME'
		WHEN cod_credor = '00795945' THEN 'ALSERVICE SERVICOS ESPECIALIZADOS EIRELI'
		WHEN cod_credor = '00796119' THEN 'BORGES - CONSTRUÇÕES SERVIÇOS E COMÉRCIO EIRELI - ME'
		WHEN cod_credor = '00796124' THEN 'ELETROLIMA CONSTRUCOES E SERVICOS EIRELI'
		WHEN cod_credor = '00796472' THEN 'MEDEIROS CONSTRUCOES E SERVICOS EIRELI'
		WHEN cod_credor = '00798256' THEN 'A R COMERCIO E SERVIÇOS  LTDA - EPP'
		WHEN cod_credor = '00798758' THEN 'SAMIR CAVALCANTE AUR'
		WHEN cod_credor = '00798914' THEN 'PROFISSA DISTRIBUIDORA EIRELI'
		WHEN cod_credor = '00799032' THEN 'SOMOS CAPITAL HUMANA -SERVIÇOS DE LOCAÇÃO DE MÃO DE OBRALTDA'
		WHEN cod_credor = '00799264' THEN 'FRICARNES COMERCIO E SERVICOS EIRELI'
		WHEN cod_credor = '00799330' THEN 'APC MARIA PIRES LUSTOSA'
		WHEN cod_credor = '00799666' THEN 'COMERCIAL SOARES NS LTDA'
		WHEN cod_credor = '00799894' THEN 'J V W CONSTRUCOES LTDA'
		WHEN cod_credor = '00800003' THEN 'F H S FREITAS MERCEARIA ME'
		WHEN cod_credor = '00800517' THEN 'PAULO TERCIO FERNANDES DOS SANTOS'
		WHEN cod_credor = '00800576' THEN 'CLEIDE GOMES MARTINS'
		WHEN cod_credor = '00800872' THEN 'PHASE TECH COMERCIO E SERVICOS LTDA'
		WHEN cod_credor = '00801074' THEN 'CERTIFIQUE SOLUCOES INTEGRADAS EIRELI'
		WHEN cod_credor = '00801099' THEN 'FRANCISCO ROBERTO PAULA DE SOUSA'
		WHEN cod_credor = '00801213' THEN 'TERRAGUA SISTEMAS DE IRRIGAÇÃO EIRELI'
		WHEN cod_credor = '00801344' THEN 'LOCABOX- LOCAÇÃO DE MAQUINAS E EQUIPAMENTOS EIRELI'
		WHEN cod_credor = '00801511' THEN 'DISTRIBUIDORA MILENIO LTDA'
		WHEN cod_credor = '00801718' THEN 'ANTONIO ROBERTO UCHOA DE ALMEIDA'
		WHEN cod_credor = '00801721' THEN 'JOAO FILHO PEREIRA DA SILVA'
		WHEN cod_credor = '00801905' THEN 'FRANCISCA DAS CHAGAS DE BRITO'
		WHEN cod_credor = '00802773' THEN 'LUIZ CARLOS SALDANHA FERREIRA - ME'
		WHEN cod_credor = '00803285' THEN 'CREMER S.A.'
		WHEN cod_credor = '00803507' THEN 'LIMA E SILVA  AGENCIA DE NOTICIAS LTDA'
		WHEN cod_credor = '00803539' THEN 'INTERDONTO - COOPERATIVA DE INTERCAMBIO DOS ODONTOLOGOS DO ESTADO DO CEARA'
		WHEN cod_credor = '00804337' THEN 'SERIPLACAS COMERCIO E SERVIÇO LTDA'
		WHEN cod_credor = '00804850' THEN 'MERCADINHO VITORIA ALIMENTOS LTDA'
		WHEN cod_credor = '00805230' THEN 'SAO MATHEUS COMERCIAL DE GAS LTDA'
		WHEN cod_credor = '00805262' THEN 'ANA ALZIRA NASCIMENTO RIBEIRO'
		WHEN cod_credor = '00805471' THEN 'EVICASSIA BATISTA MOURAO'
		WHEN cod_credor = '00807411' THEN 'LAILA SUANE DA SILVA ANDRADE'
		WHEN cod_credor = '00807949' THEN 'F T S SERVICOS DE CONSTRUCOES E COMERCIO LTDA'
		WHEN cod_credor = '00808249' THEN 'BH COMERCIO E DISTRIBUICAO EIRELI'
		WHEN cod_credor = '00808510' THEN 'VIP7IT COMERCIO E SERVICOS EM INFORMATICA LTDA'
		WHEN cod_credor = '00808659' THEN 'DEMITRI NOBREGA CRUZ'
		WHEN cod_credor = '00809447' THEN 'RE COMERCIO E SERVICOS EIRELI'
		WHEN cod_credor = '00810759' THEN 'CANON MEDICAL SYSTEMS DO BRASIL'
		WHEN cod_credor = '00811096' THEN 'CIRURGICA SAO FELIPE PRODUTOS PARA SAUDE EIRELI'
		WHEN cod_credor = '00811148' THEN 'COOMTOCE - COOPERATIVA DE TRABALHO DOS MEDICOS TRAUMATOLOGISTAS E ORTOPEDISTAS DO ESTADO DO CEARA LTDA'
		WHEN cod_credor = '00812551' THEN 'GIKA COMÉRCIO & SERVICOS DE FERRAGENS E FERRAMENTADAS LTDA-ME'
		WHEN cod_credor = '00812905' THEN 'OTIMA DISTRIBUIDORA E SERVICOS EIRELI'
		WHEN cod_credor = '00813372' THEN 'F F MORAIS AZEVEDO'
		WHEN cod_credor = '00813374' THEN 'ANTONIO SENA DA SILVA'
		WHEN cod_credor = '00813376' THEN 'ROBERIO MATEUS DE ARAUJO'
		WHEN cod_credor = '00814195' THEN 'COMERCIAL MODELO DE MAQUINAS E PAPEIS LTDA'
		WHEN cod_credor = '00814703' THEN 'FSN COMERCIO ARTIGOS DE ARMARINHOS E MATERIAIS DE CONSTRUÇOES EIRELI'
		WHEN cod_credor = '00817678' THEN 'W & A SOLUCOES TECNOLOGICAS EIRELI'
		WHEN cod_credor = '00819143' THEN 'K M COMERCIO DE ALIMENTOS LTDA'
		WHEN cod_credor = '00820656' THEN 'JOANA MARIA DE FREITAS FERREIRA'
		WHEN cod_credor = '00821548' THEN 'CONSTRUTORA MOREIRA & MELO LTDA'
		WHEN cod_credor = '00821617' THEN 'LANLINK SOLUÇÕES E COMERCIALIZAÇÃO EM INFORMÁTICA S.A.'
		WHEN cod_credor = '00822031' THEN 'CL3 EMPREENDIMENTOS LTDA'
		WHEN cod_credor = '00822049' THEN 'M R G ARAUJO ME'
		WHEN cod_credor = '00822133' THEN 'JAVÉ - YIRÊ CONSULTORIA, EVENTOS, SERVIÇOS E COMÉRCIO LTDA'
		WHEN cod_credor = '00822736' THEN 'A K CONSTRUCOES EIRELI'
		WHEN cod_credor = '00822974' THEN 'BANCO DE OLHOS DO CEARA - B.O.C LTDA'
		WHEN cod_credor = '00823258' THEN 'CONSTRUTORA EVOLUTIA LTDA'
		WHEN cod_credor = '00823430' THEN 'H.P.DE VASCONCELOS'
		WHEN cod_credor = '00824117' THEN 'M & M ANDRADE COMERCIO VAREJISTA DE PRODUTOS DE PAPELARIA EIRELI'
		WHEN cod_credor = '00824641' THEN 'COOPERATIVA AGROINDUSTRIAL DO ESTADO DO CEARA - COOPAECE'
		WHEN cod_credor = '00824866' THEN 'JULIANNE BEZERRA BARROS'
		WHEN cod_credor = '00825837' THEN 'DKM SOLUCOES EMPRESARIAIS EIRELI'
		WHEN cod_credor = '00825854' THEN 'CONSTRUTORA CONCRETIZA LTDA'
		WHEN cod_credor = '00826182' THEN 'WORLD SOLUCOES TECNOLOGICAS E SERVICOS EIRELI'
		WHEN cod_credor = '00826878' THEN 'ROMY COMERCIAL E SERVICOS EIRELI'
		WHEN cod_credor = '00827237' THEN 'ASSOCIACAO ASSISTENCIAL VANIA QUEIROZ'
		WHEN cod_credor = '00829391' THEN 'J R ALACRINO ROCHA MENEZES'
		WHEN cod_credor = '00829524' THEN 'INFOSHOP - COMERCIO ATACADISTA DE ARTIGOS PARA INFORMATICA EIRELI'
		WHEN cod_credor = '00829719' THEN 'K K M SOUSA'
		WHEN cod_credor = '00831151' THEN 'EMPRESA DE TRANSPORTE RODOVIARIO DE PASSAGEIROS URUBURETAMA LTDA - ME'
		WHEN cod_credor = '00831635' THEN 'UNI HOSPITALAR CEARA LTDA'
		WHEN cod_credor = '00833139' THEN 'MARIA DE FATIMA MAGALHAES BEZERRA - ME'
		WHEN cod_credor = '00833175' THEN 'COOPERATIVA AGROINDUSTRIAL LUIS CARLOS'
		WHEN cod_credor = '00833176' THEN 'COOPERATIVA AGROINDUSTRIAL ZE LOURENÇO'
		WHEN cod_credor = '00833694' THEN 'CERTARE ENGENHARIA E CONSULTORIA LTDA'
		WHEN cod_credor = '00834429' THEN 'C SOUSA OLIVEIRA EIRELI'
		WHEN cod_credor = '00834597' THEN 'PROCOPY COMERCIO E SERVICOS DE COPIADORAS EIRELI'
		WHEN cod_credor = '00834749' THEN 'EXPRESSO DISTRIBUIDORA EIRELI'
		WHEN cod_credor = '00834904' THEN 'COOP.AG.FAMILIARES DO VALE DO FORQUILHA'
		WHEN cod_credor = '00835065' THEN 'MARIA DO SOCORRO DE SOUSA LEITE CEREALISTA COMERCIO'
		WHEN cod_credor = '00835097' THEN 'FRANCISCO ROBERTO ARCANJO MATOS LTDA'
		WHEN cod_credor = '00835187' THEN 'A V F BATISTA MULTIVENDAS'
		WHEN cod_credor = '00835261' THEN 'DSS SOLUCOES TECNOLOGICAS LTDA'
		WHEN cod_credor = '00835515' THEN 'EMANUEL SALES DE MEDEIROS'
		WHEN cod_credor = '00835605' THEN 'LIMP TUDO SERVICOS DE LIMPEZA E CONSERVACAO LTDA'
		WHEN cod_credor = '00836584' THEN 'JOÃO VIANEI PEREIRA'
		WHEN cod_credor = '00836644' THEN 'VJ SILVA VARIEDADES LTDA'
		WHEN cod_credor = '00837435' THEN 'PERFEITA GRAFICA E EDITORA LTDA'
		WHEN cod_credor = '00837453' THEN 'H20 BOA INDUSTRIA E COMERCIO DE ÁGUA LTDA'
		WHEN cod_credor = '00837528' THEN 'J  A  NETO - ME'
		WHEN cod_credor = '00837613' THEN 'L E CONSTRUÇÕES EIRELI'
		WHEN cod_credor = '00838104' THEN 'GLÁUCIA PORTO DE FREITAS'
		WHEN cod_credor = '00838318' THEN 'IMPRESSIONE COMERCIO E SERVICOS GRAFICOS EIRELI'
		WHEN cod_credor = '00838729' THEN 'ALL SPORTS EVENTOS LTDA'
		WHEN cod_credor = '00839198' THEN 'FREDERICO LOPES FERNANDES NETO'
		WHEN cod_credor = '00839246' THEN 'ANTONIO LOPES DE MENEZES'
		WHEN cod_credor = '00839411' THEN 'INTELIT PROCESOS INTELIGENTES LTDA'
		WHEN cod_credor = '00839433' THEN 'CEARENSE COMERCIO DE PRODUTOS HOSPITALARES EIRELI'
		WHEN cod_credor = '00839455' THEN 'L&L  SERVIÇOS  DE  REFRIGERAÇÃO  LTDA'
		WHEN cod_credor = '00840526' THEN 'CSL BEHRING COMERCIO DE PRODUTOS FARMACEUTICOS LTDA'
		WHEN cod_credor = '00840992' THEN 'SANTOS CONSULTORIA E GESTAO CREATIVE LTDA'
		WHEN cod_credor = '00841141' THEN 'JOSIAS SARAIVA LIMA NETO'
		WHEN cod_credor = '00844474' THEN 'CONSTRUTORA SANTA BEATRIZ LTDA'
		WHEN cod_credor = '00846240' THEN 'J V COELHO CAMPELO'
		WHEN cod_credor = '00846648' THEN 'FRANCISCO DANILO TIMBO FERREIRA'
		WHEN cod_credor = '00847023' THEN 'GLOBAL SERVICOS E NEGOCIOS EMPRESARIAIS EIRELI'
		WHEN cod_credor = '00849437' THEN 'PHARMA BRASIL COMERCIO DE PRODUTOS MEDICOS EIRELI EPP'
		WHEN cod_credor = '00849903' THEN 'CENTRO DE ESTOMATOLOGIA E RADIOLOGIA DO CEARA S/C LTDA'
		WHEN cod_credor = '00850401' THEN 'HO CHAIR MOVEIS LTDA - ME'
		WHEN cod_credor = '00850880' THEN 'DELTA INDUSTRIA E COMERCIO EIRELI'
		WHEN cod_credor = '00851435' THEN 'CLAUDIO ROBERTO GONCALVES BARBOZA ME'
		WHEN cod_credor = '00852245' THEN 'GOLD NUTRI COMERCIO DE PRODUTOS NUTRICIONAIS E HOSPITALARES LTDA'
		WHEN cod_credor = '00852551' THEN 'TECNETWORKING SERVICOS E SOLUCOES EM TI LTDA'
		WHEN cod_credor = '00852866' THEN 'ARFRIO SERVICE COMERCIO E SERVICOS LTDA'
		WHEN cod_credor = '00852910' THEN 'ANDREZA CAVALCANTE BARBOSA'
		WHEN cod_credor = '00852980' THEN 'CS BRASIL TRANSPORTES DE PASSAGEIROS E SERVIÇOS AMBIENTAIS LTDA'
		WHEN cod_credor = '00853002' THEN 'MEDEVICES PRODUTOS MEDICOS E HOSPITALARES LTDA'
		WHEN cod_credor = '00853058' THEN 'EEF TEODORICO GUILHERME PEREIRA'
		WHEN cod_credor = '00853262' THEN 'CCARDIO - COOPERATIVA DOS MEDICOS ESPECIALISTAS EM CARDIOLOGIA DO ESTADO DO CEARA'
		WHEN cod_credor = '00853606' THEN 'P. MELO CONSTRUCOES E EMPREENDIMENTOS LTDA'
		WHEN cod_credor = '00854418' THEN 'HUDSON DARWIN VIEIRA GOMES'
		WHEN cod_credor = '00855358' THEN 'TEREZA PATRICIA CAVALCANTE'
		WHEN cod_credor = '00855410' THEN 'VIVA COMERCIO SERVIÇOS E TRANSPORTES LTDA - ME'
		WHEN cod_credor = '00855505' THEN 'CASA DA RACAO COMERCIAL LTDA'
		WHEN cod_credor = '00855556' THEN 'FORTE COMERCIO DE ALIMENTOS EIRELI'
		WHEN cod_credor = '00856169' THEN 'JOSE EDIVO PEIXOTO FILHO'
		WHEN cod_credor = '00856487' THEN 'NOVARTIS BIOCIÊNCIAS S.A.'
		WHEN cod_credor = '00856614' THEN 'DEUZIRAN PIRES CORREIA'
		WHEN cod_credor = '00857850' THEN 'ZM PONTES COMERCIO E CONSTRUCOES EIRELI'
		WHEN cod_credor = '00858209' THEN 'MTS REFRIGERACAO E CONSTRUCAO LTDA'
		WHEN cod_credor = '00859097' THEN 'ANA LEIDE NOGUEIRA VIEIRA'
		WHEN cod_credor = '00859294' THEN 'ADI CONSULTORIA E ASSESSORIA EM LICITACOES LTDA'
		WHEN cod_credor = '00860839' THEN 'CLINICA ODONTOLOGICA LUIZA BEZERRA LTDA'
		WHEN cod_credor = '00861564' THEN 'WIPRO DO BRASIL SERVICOS LTDA.'
		WHEN cod_credor = '00862000' THEN 'DIOGO F M DA SILVA EIRELI'
		WHEN cod_credor = '00862002' THEN 'LUIZ GUSTAVO  DA SILVA MATOS'
		WHEN cod_credor = '00862289' THEN 'AM INFORMATICA E SERVICOS LTDA'
		WHEN cod_credor = '00862332' THEN 'ORBITINF TECNOLOGIA LTDA ME'
		WHEN cod_credor = '00862544' THEN 'CLINICA OTORRINOLARINGOLOGICA DR FRANZE LTDA'
		WHEN cod_credor = '00862609' THEN 'FRANCISCO SOARES LIMA 37998331372'
		WHEN cod_credor = '00862730' THEN 'ELTON GARCIA DE OLIVEIRA'
		WHEN cod_credor = '00863393' THEN 'DV DA SILVA - EDUCACAO PROFISSIONAL'
		WHEN cod_credor = '00864065' THEN 'ANTONIO MARCOS DO NASCIMENTO SILVA'
		WHEN cod_credor = '00864340' THEN 'AGNUS COMERCIO DE MAQUINAS E EQUIPAMENTOS EIRELI'
		WHEN cod_credor = '00864443' THEN 'LAIRTON S DA SILVA'
		WHEN cod_credor = '00864948' THEN 'C V DE AGUIAR COMERCIO E SERVICOS AUTOMOTIVOS LTDA'
		WHEN cod_credor = '00865370' THEN 'ANA PAULA ALVES FERNADES'
		WHEN cod_credor = '00865395' THEN 'COM3BRASIL SERVICOS DE INFORMATICA LTDA'
		WHEN cod_credor = '00865638' THEN 'ZS TEXTIL INDUSTRIA DE CONFECÇÕES EIRELI'
		WHEN cod_credor = '00865679' THEN 'LITORANEA COMERCIO E SERVIÇOS EIRELI'
		WHEN cod_credor = '00865832' THEN 'L. L. PEREIRA ODONTOLOGIA ME'
		WHEN cod_credor = '00866111' THEN 'DKSA COMERCIAL LTDA'
		WHEN cod_credor = '00866388' THEN 'GABRIEL WANDERSON MAIA BENTO'
		WHEN cod_credor = '00866477' THEN 'CRANIOCOLUNA SERVICOS MEDICOS EIRELI'
		WHEN cod_credor = '00866902' THEN 'COFTALCE COOPERATIVA DOS OFTALMOLOGISTAS DO CEARA LTDA'
		WHEN cod_credor = '00867049' THEN 'POLICLINICA JUREMA LTDA ME'
		WHEN cod_credor = '00867302' THEN 'REALCE COMUNICACAO VISUAL EIRELI'
		WHEN cod_credor = '00868163' THEN 'J. E. CAVALCANTE PRATA'
		WHEN cod_credor = '00868369' THEN 'KARINE DA COSTA OLIVEIRA'
		WHEN cod_credor = '00868395' THEN 'T TAVARES FELINTO E CIA. LTDA'
		WHEN cod_credor = '00868439' THEN 'ACERTE ASSESSORIA & CONTABILIDADE LTDA'
		WHEN cod_credor = '00868487' THEN 'FAC COMERCIO SERVICOS E CONSTRUCAO EIRELI'
		WHEN cod_credor = '00868617' THEN 'NOOBI COMERCIO ELETRONICO LTDA'
		WHEN cod_credor = '00868755' THEN 'CICERO DIONES FERREIRA DE CARVALHO'
		WHEN cod_credor = '00868766' THEN 'DANIEL ROCHA MENDES'
		WHEN cod_credor = '00868783' THEN 'DIEGO FERREIRA VASCONCELOS'
		WHEN cod_credor = '00868786' THEN 'EDILANIA GONCALVES SOUSA'
		WHEN cod_credor = '00868798' THEN 'ELTON ELVEIS MARQUES DE FREITAS'
		WHEN cod_credor = '00868860' THEN 'FERNANDO GOMES AGUIAR'
		WHEN cod_credor = '00868870' THEN 'JOHN VITOR CANUTO SOUSA'
		WHEN cod_credor = '00868985' THEN 'JEFTER QUEIROZ LIMA'
		WHEN cod_credor = '00868987' THEN 'JHONANTAN DE OLIVEIRA DA SILVA'
		WHEN cod_credor = '00869027' THEN 'GILBER RAULISON RODRIGUES DA SILVA'
		WHEN cod_credor = '00869084' THEN 'VANESSA RODRIGUES DE ARAUJO'
		WHEN cod_credor = '00869149' THEN 'NIXON ALCANTARA'
		WHEN cod_credor = '00869249' THEN 'DELCONT CONTABILIDADE E TREINAMENTO LTDA'
		WHEN cod_credor = '00869255' THEN 'FRANCISCA ALEXANDRA DUARTE DA SILVA'
		WHEN cod_credor = '00869296' THEN 'KARLA LANY PEREIRA TELES'
		WHEN cod_credor = '00869327' THEN 'GYN COMERCIO DE PRODUTOS EM T.I EIRELI'
		WHEN cod_credor = '00869339' THEN 'SUCESSO TECNOLOGIA E INFORMACAO EIRELI'
		WHEN cod_credor = '00869400' THEN 'H & L PROMOCOES E EVENTOS EMPRESARIAIS EIRELI'
		WHEN cod_credor = '00870162' THEN 'BDO RCS AUDITORES INDEPENDENTES - SOCIEDADE SIMPLES'
		WHEN cod_credor = '00870167' THEN 'ANTONIA JOSIANA VIEIRA SILVA  94972494387'
		WHEN cod_credor = '00870180' THEN 'M. V. DANTAS'
		WHEN cod_credor = '00870185' THEN 'LOJAS FALC PAPELARIA EIRELI'
		WHEN cod_credor = '00870283' THEN 'DIGILOC SOLUCOES EM IMPRESSOES EIRELI'
		WHEN cod_credor = '00870317' THEN 'CAIO LUIZ LOURENÇO RIBEIRO'
		WHEN cod_credor = '00870495' THEN 'AR MEDIC SERVICOS EIRELI'
		WHEN cod_credor = '00870674' THEN 'AGUAMED COMERCIO  DE EQUIPAMENTOS HOSPITALARES E ODONTOLOGICOS LTDA'
		WHEN cod_credor = '00870728' THEN 'CABANES GUILLAUME'
		WHEN cod_credor = '00870931' THEN 'CUBO DESIGN MOBILIARIO & REVESTIMENTO LTDA'
		WHEN cod_credor = '00871404' THEN 'LIMPEMAX INDUSTRIA E COMERCIO DE PRODUTOS DE LIMPEZA LTDA  - EPP'
		WHEN cod_credor = '00872111' THEN 'FRANCISCA RODSINEIDE OLIVEIRA'
		WHEN cod_credor = '00872235' THEN 'G. DE SOUSA DINIZ'
		WHEN cod_credor = '00872239' THEN 'RIQUEL COMERCIAL DE ELETRO-ELETRONICOS CONFECÇÕES E FERRAMENTAS LTDA -ME'
		WHEN cod_credor = '00872388' THEN 'VITOR MACEDO MONTEIRO'
		WHEN cod_credor = '00872404' THEN 'ALCIONE DE LOURENÇO CARVALHO'
		WHEN cod_credor = '00872693' THEN 'REALIZE CONSTRUTORA E IMOBILIARIA LTDA'
		WHEN cod_credor = '00872740' THEN 'REALIZA SEGURANCA PATRIMONIAL LTDA'
		WHEN cod_credor = '00872902' THEN 'DREAMS COMERCIO DE PAPEIS LTDA'
		WHEN cod_credor = '00873102' THEN 'MARIA ELESEUDA LIMA FERREIRA'
		WHEN cod_credor = '00873960' THEN 'H. M. G. COMERCIO DE MIUDEZAS LTDA'
		WHEN cod_credor = '00874016' THEN 'CONSÓRCIO CE 155 - CLC/LOMACON'
		WHEN cod_credor = '00874146' THEN 'HELIA MARIA BARBOSA DINELLY'
		WHEN cod_credor = '00874170' THEN 'W R COMERCIO DE MATERIAIS DE LIMPEZA EIRELI'
		WHEN cod_credor = '00874238' THEN 'LUANA SILVA DE SOUSA'
		WHEN cod_credor = '00874399' THEN 'ACCESS COBRANCA CONTACT CENTER E INSTITUTO DE PESQUISAS LTDA'
		WHEN cod_credor = '00874426' THEN 'IMPORT HOSPITALAR EIRELI'
		WHEN cod_credor = '00874458' THEN 'MILAN MOVEIS INDUSTRIA E COMERCIO LTDA'
		WHEN cod_credor = '00874657' THEN 'PRIME WORLD SOLUCOES PUBLICAS LTDA'
		WHEN cod_credor = '00874704' THEN 'GEILSON GONCALVES DE LIMA'
		WHEN cod_credor = '00874769' THEN 'SALUTEM SERVICOS DE AGRONOMIA, ENGENHARIA E SOLUCOES AMBIENTAIS LTDA'
		WHEN cod_credor = '00874796' THEN 'ROSANGELA VIEIRA PAULO'
		WHEN cod_credor = '00874802' THEN 'CEPAP ESC. FRANCISCO RODRIGUES DE MACEDO'
		WHEN cod_credor = '00875042' THEN 'LILIAN VIRGINIA CARNEIRO GONDIM'
		WHEN cod_credor = '00875238' THEN 'NORDMARKET COMERCIO DE PRODUTOS HOSPITALARES LTDA'
		WHEN cod_credor = '00875664' THEN 'CARLA DE OLIVEIRA CORREA'
		WHEN cod_credor = '00875714' THEN 'PLINIO ALMINO E SILVA'
		WHEN cod_credor = '00876032' THEN 'GRAFICA E COMUNICACAO VISUAL IDEIA LTDA'
		WHEN cod_credor = '00876358' THEN 'JOSÉ MARCOS COSMO DA SILVA'
		WHEN cod_credor = '00882925' THEN 'IOHANNA ARAGÃO DE PAIVA'
		WHEN cod_credor = '00888530' THEN 'KELVIA MARIA OLIVEIRA'
		WHEN cod_credor = '00899662' THEN 'FRANCISCA ERBENE PIMENTA DOS SANTOS MONTEIRO'
		WHEN cod_credor = '00901716' THEN 'ANDREA MARIA CARMO DE OLIEIRA'
		WHEN cod_credor = '01703220331' THEN 'KARISIA SOUSA BARROS DE LIMA'
		WHEN cod_credor = '02268603000102' THEN 'R G MOREIRA SOUZA COMERCIAL DE ALIMENTOS LTDA'
		WHEN cod_credor = '03844304000123' THEN 'CLINICA ODONTOLOGICA INTEGRADA S/C LTDA-ME'
		WHEN cod_credor = '04304836358' THEN 'ANDERSON HERBERT ALVES MARQUES'
		WHEN cod_credor = '04691159398' THEN 'FRANCISCO DIEGO DA SILVA CHAGAS'
		WHEN cod_credor = '05647411320' THEN 'ANA THALYA APARECIDA DA SILVA BARBOSA'
		WHEN cod_credor = '06128769349' THEN 'ELIEZIO NEVES PEREIRA'
		WHEN cod_credor = '06183948349' THEN 'JOSE LUCIANO MARQUES MENESES'
		WHEN cod_credor = '07039347326' THEN 'ANA ELISA BIESEK LEITE'
		WHEN cod_credor = '07212809357' THEN 'LUCAS ALMEIDA COELHO'
		WHEN cod_credor = '07718372000105' THEN 'ASSOCIAÇAO QUIXADAENSE DE PROTEÇÃO E ASSISTÊNCIA À MATERNIDADE À INFÂNCIA E ADOLESCÊNCIA'
		WHEN cod_credor = '07726540000104' THEN 'PREFEITURA MUNICIPAL DE PEDRA  BRANCA'
		WHEN cod_credor = '10973526000101' THEN 'ADAMO VASCONCELOS DE OLIVEIRA EIRELI'
		WHEN cod_credor = '11805967000167' THEN 'GELAR REFRIGERACAO COMERCIAL EIRELI'
		WHEN cod_credor = '14233838000130' THEN 'FMAS DE TAUÁ'
		WHEN cod_credor = '15410425000146' THEN 'BRAS GO MOBILIDADE LTDA'
		WHEN cod_credor = '20905727000125' THEN 'ELEVARTECH ELEVADORES E COMPONENTES LTDA'
		WHEN cod_credor = '22845259387' THEN 'MARIA DE FATIMA BRITO FONTENELE OLIVEIRA'
		WHEN cod_credor = '24552178334' THEN 'KATHIA LILIANE DA CUNHA RIBEIRO ZUNTINI'
		WHEN cod_credor = '24712329300' THEN 'MARIA CONCEICAO FERNANDES LUCAS'
		WHEN cod_credor = '24794953372' THEN 'ANA SUELY CARVALHO PEREIRA'
		WHEN cod_credor = '28591995000121' THEN 'MULTICLINIC SAUDE & VIDA LTDA'
		WHEN cod_credor = '29101955000117' THEN 'YO FITNESS LTDA'
		WHEN cod_credor = '29964857349' THEN 'LAURO CARLOS DE A PRADO'
		WHEN cod_credor = '33651718000105' THEN 'W R COMERCIO DE MATERIAIS DE LIMPEZA EIRELI'
		WHEN cod_credor = '34761706000198' THEN 'LUANA BEATRIZ SILVA DE SOUSA'
		WHEN cod_credor = '38002841387' THEN 'CRISTIANE CID CRUZ'
		WHEN cod_credor = '38226790387' THEN 'EMERSON IESUS TABOSA SALES'
		WHEN cod_credor = '42410276000198' THEN 'HSMSHOP COMERCIO DE PRODUTOS HOSPITALARES E VARIEDADES LTDA'
		WHEN cod_credor = '14233838000130' THEN'FUNDO MUNICIPAL DE ASSISTENCIA SOCIAL'
		WHEN cod_credor = '00143035' THEN'F G COMERCIAL DE PRODUTOS HOSPITALARES LTDA'
		WHEN cod_credor = '47969571387' THEN'CICERO CRISTIANO DE OLIVEIRA'
		WHEN cod_credor = '58430180320' THEN'DEBORAH CAVALCANTE DE OLIVEIRA S GUARINE'
		WHEN cod_credor = '61604895349' THEN'ROOSEVELT MARINHO GOMES'
		WHEN cod_credor = '64200850397' THEN'PAOLO GIORGIO QUEZADO GURGEL E SILVA'
		WHEN cod_credor = '00227380' THEN'ABBOTT DIAGNOSTICOS RAPIDOS S.A.'
		WHEN cod_credor =  '00780721' THEN'GSK PRODUTOS LABORATORIAIS LTDA'
		WHEN cod_credor = '00803481'	THEN'SMT IMPORTADORA E DISTRIBUIDORA DE PRODUTOS HOSPITALARES LTDA'
		WHEN cod_credor = '00814700'	THEN'B1 BRASIL COMERCIO DE TECNOLOGIAS DIGITAIS LTDA'
		WHEN cod_credor = '00839469'	THEN'A L S CASTRO COMERCIO E SERVICOS - ME'
		WHEN cod_credor = '00847158'	THEN'COMERCIAL RIOS PRODUTOS DE LIMPEZA, DESCARTAVEIS E PAPELARIA LTDA'
		WHEN cod_credor = '00870495'	THEN'AR MEDIC SERVICOS EIRELI'
		WHEN cod_credor = '00870879'	THEN'BELIEVE FARMA COMERCIO DE MEDICAMENTOS E MATERIAIS HOSPITALARES LTDA'
		WHEN cod_credor = '00871353'	THEN'UNIDAS VEICULOS ESPECIAIS S.A.'
		WHEN cod_credor = '00871967'	THEN'CELIA MARIA FERREIRA DE MOURA'
		WHEN cod_credor = '00873799'	THEN'ALDERLAN DA SILVA BATISTA'
		WHEN cod_credor = '00875977'	THEN'MIDIA BISPO DA CRZ SARAIVA'
		WHEN cod_credor = '04304836358'	THEN'ANDERSON HERBERT ALVES MARQUES'
		WHEN cod_credor = '34133591000197'	THEN'NAUTICA COMERCIO E SERVIÇOS EIRELI'
		WHEN cod_credor = '84540710320' THEN 'NAARA SAMAI COEDEIRO DA SILVA PEREIRA LIMA'
	ELSE dsc_nome_credor -- mantém o valor existente 
 END
```

#### Correção de erros de digitação
Procuramos por erros de digitação, variações de maiúsculas/minúsculas e ajustamos conforme necessário para garantir consistência nos dados.

Padronização para tudo em maiúsculo:
```
UPDATE dbo.tabelaODS
	SET 
		dsc_orgao = UPPER(dsc_orgao),
		dsc_nome_credor = UPPER(dsc_nome_credor),
		dsc_fonte = UPPER(dsc_fonte);

	SELECT DISTINCT dsc_orgao FROM dbo.tabelaODS ORDER BY dsc_orgao;
	SELECT DISTINCT dsc_nome_credor FROM dbo.tabelaODS ORDER BY dsc_nome_credor;
	SELECT DISTINCT dsc_fonte FROM dbo.tabelaODS ORDER BY dsc_fonte;
```
Retiramos os espaços em branco das descrições:
```
--removendo espaços em branco das descrições
	UPDATE dbo.tabelaODS
	SET 
	 dsc_orgao = CASE WHEN dsc_orgao IS NOT NULL THEN TRIM(dsc_orgao) ELSE dsc_orgao END,
	 dsc_fonte = CASE WHEN dsc_fonte IS NOT NULL THEN TRIM(dsc_fonte) ELSE dsc_fonte END,
	 dsc_nome_credor = CASE WHEN dsc_nome_credor IS NOT NULL THEN TRIM(dsc_nome_credor) 
	 ELSE dsc_nome_credor END;
```
Conversão de todos os valores para decimais:
```
-- validando formato dos campos valores (todas deram resultados com duas casas decimais. Nada a normalizar)
	SELECT *
	FROM dbo.tabelaODS
	WHERE 
		(TRY_CAST(valor_pago AS DECIMAL(18,2)) IS NULL OR valor_pago <> TRY_CAST(valor_pago AS DECIMAL(18,2)))
		OR (TRY_CAST(vlr_resto_pagar AS DECIMAL(18,2)) IS NULL OR vlr_resto_pagar <> TRY_CAST(vlr_resto_pagar AS DECIMAL(18,2)))
		OR (TRY_CAST(vlr_empenho AS DECIMAL(18,2)) IS NULL OR vlr_empenho <> TRY_CAST(vlr_empenho AS DECIMAL(18,2)));
```
Ao analisar a coluna valor_pago, nos deparamos com 109.765 linhas com valor `null`. Ao investigarmos de forma mais profunda observamos que não havia valores de `data de pagamento` dessas linhas e o `resto a pagar` se encontrava zerado. 
Além disso, havia ainda 35.473 linhas sem valor de empenho. 
Segue abaixo o codigo utilizado para fazer a analise:
```
Select valor_pago, vlr_resto_pagar, dth_pagamento from dbo.tabelaODS where valor_pago is null and vlr_resto_pagar = 0.00 and dth_pagamento is null

	Select valor_pago, vlr_resto_pagar, dth_pagamento,vlr_empenho from dbo.tabelaODS where valor_pago is null and vlr_resto_pagar = 0.00 and dth_pagamento is null and vlr_empenho = 0
```
#### Identificação de valores extremos e outliers
Um Outlier é uma informação que representa um ponto fora da curva. Que se não tratado gera erro no gráfico.

Para validar a coluna vlr_empenho, utilizamos o seguinte filtro:
```
select * from dbo.tabelaOds where vlr_empenho = 0
```
Com isso, encontramos quais linhas não apresentam nenhum valor de empenho, logo essas linhas representam pontos que não geraram custos. Assim, removemos essas linhas para não apresentar distorção.
![Untitled](https://github.com/melissareboucas/BD-AV2/assets/86539553/89c0e368-ee39-498c-8bfa-aa65fcf7f557)

```
Select valor_pago, vlr_resto_pagar, dth_pagamento,vlr_empenho from dbo.tabelaODS where valor_pago is null and vlr_resto_pagar = 0.00 and dth_pagamento is null and vlr_empenho = 0

DELETE FROM dbo.tabelaODS 
WHERE valor_pago IS NULL 
AND vlr_resto_pagar = 0.00 
AND dth_pagamento IS NULL 
AND vlr_empenho = 0
```

#### Tratamento de valores nulos
Validamos alguns valores nulos em colunas.

SQL
```
-- Tratamento de alguns valores nulos em colunas de código<>descrição
--Orgao
	select distinct codigo_orgao, dsc_orgao
	from tabelaODS where dsc_orgao IS NULL

-- Credor
	select distinct cod_credor,dsc_nome_credor
	from tabelaODS where dsc_nome_credor IS NULL

	--não há nomes nulos. nada a normalizar

-- Fonte
	select distinct cod_fonte, dsc_fonte
	from tabelaODS where dsc_fonte IS NULL
```
![Untitled (9)](https://github.com/melissareboucas/BD-AV2/assets/86539553/36d83a46-6924-402e-85c2-fa4cea865b54)

Observamos que:
- Somente o `orgão` possui descrições nulas para um codigo. 
- Na `fonte` existe um codigo nulo com descrição nulo
- No `credor` não há nada nulo então não precisamos tratar.

--ÓRGÃO--
Verificamos dentre os códigos nulos de `orgão`, se existe algum deles que tem descrição:
```
SELECT DISTINCT
    codigo_orgao AS codigo_orgao,
    dsc_orgao AS descricao_orgao
	FROM 
    tabelaODS
	WHERE 
    codigo_orgao IN (
        SELECT codigo_orgao
        FROM tabelaODS
        GROUP BY codigo_orgao
        HAVING COUNT(DISTINCT CASE WHEN dsc_orgao IS NULL THEN 'NULO' ELSE dsc_orgao END) > 1
    );
```
![Untitled (10)](https://github.com/melissareboucas/BD-AV2/assets/86539553/025d7ae3-a356-44c9-9897-784e413580e9)

Achamos os seguintes códigos: 561001, 561101. Usamos o algoritmo abaixo para padronizar:
```
UPDATE tabelaODS
	SET dsc_orgao = 
	  CASE 
		WHEN codigo_orgao = 561001 THEN 'FUNDO DE INVESTIMENTOS DE MICROCREDITO PRODUTIVO DO CEARA'
		WHEN codigo_orgao = 561101 THEN 'FUNDO DE DEFESA AGROPECUARIO DO ESTADO DO CEARA'
		ELSE dsc_orgao -- mantém o valor existente 
	  END
	WHERE dsc_orgao IS NULL and codigo_orgao in (561101,561001)
```
Para os nulos, usamos a seguinte função para validar na tabela e tomar uma decisão do que deve ser feito:
```
-- verifica todas as colunas dos respectivos códigos

	SELECT *
	FROM 
		tabelaODS
	WHERE 
		codigo_orgao IN (
			229216, 229218, 229220, 229221, 229224, 229225, 229226, 229228,
			229235, 229240, 229241, 229243, 229245, 229247, 229248, 561001, 561101
		);
```
Tomamos a decisão de padronizar esses códigos com a seguinte descrição: 'ORGÃO SEM DESCRIÇÃO’. Segue abaixo o script usado para correção:
```
-- padroniza esses codigos para 'Orgão sem descrição'
	UPDATE dbo.tabelaODS
	SET dsc_orgao = 'ORGÃO SEM DESCRIÇÃO'
	WHERE dsc_orgao IS NULL;
```
--FONTE-- 
Na `fonte`, existe uma lacuna em código e descrição, vamos selecionar todas essas linhas para realizarmos uma melhor análise.
```
SELECT *
	FROM tabelaODS
	WHERE cod_fonte IS NULL;
```
Nas colunas que referenciam fonte não há nenhum código, vamos colocar: ‘FONTE SEM CODIGO’ e na descrição: ‘FONTE SEM DESCRICAO’
```
-- padroniza esses codigos para 'fonte sem codigo e descrição'
	UPDATE dbo.tabelaODS
	SET cod_fonte = 'FONTE SEM CODIGO'
	WHERE cod_fonte IS NULL;

	-- padroniza esses codigos para 'Orgão sem descrição'
	UPDATE dbo.tabelaODS
	SET dsc_fonte = 'FONTE SEM DESCRICAO'
	WHERE dsc_fonte IS NULL;

```

## Transformação dos dados

Nessa etapa, os dados já ajustados saem da `stage area`, para um `datawarehouse`.
* Processos realizados:
    * Criação do banco DW com as tabelas do modelo dimensional.
    * Dicionário de dados
 
### Criação do DW

O datawarehouse desse projeto consiste na tabela fato:
- `fato_empenho`
E nas dimensões:
- `dim_orgao`
- `dim_fonte`
- `dim_credor`
- `dim_calendario`

No dicionário de dados explicaremos cada uma delas.

A seguir, estão os códigos em sql utilizados para criar cada uma dessas tabelas:
Criar banco de datawarehouse
```
create database dw
```

Criar tabela fato
```
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
```

Criar tabela dimensão órgão
```
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
```

Criar tabela dimensão fonte
```
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
```

Criar tabela dimensão credor
```
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
```

Relacionar todas as tabelas
```
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
```

Criar tabela dimensão calendário
```
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
```


### Dicionário de dados



## Apresentação dos dados

Link do BI: zzzzz

* Relatórios:
    * Totais Gerais de Valor Original (Empenho)
    * Totais Gerais Pago
    * Totais Gerais a pagar
* Painéis:
    * Painel de xxx
    * Painel de yyy
* Visualizações:
    * Gráficos de barras
      fotinho
    * Gráficos de linhas
      fotinho
    * Gráficos de pizza
      fotinho
