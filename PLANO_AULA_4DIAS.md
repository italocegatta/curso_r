# Plano de Aula — Curso R Completo (4 dias / 32h)

> **Instrutor:** Ítalo Cegatta  
> **Carga horária:** 32 horas (8 períodos de 4h)  
> **Público-alvo:** Profissionais da área florestal sem conhecimento prévio de programação  
> **Pré-requisitos:** Nenhum (instalação do R e RStudio no início)  
> **Datasets:** `filmes_imdb.csv` (Dia 1 — engajamento) + dados florestais (Dias 2-4 — aplicação profissional)  
> **Formato:** Quarto Book (HTML) — nomes de capítulos em português

---

## Estratégia de datasets

| Dia | Dataset | Motivo |
|-----|---------|--------|
| **1** | `filmes_imdb.csv` | Universal, divertido — qualquer pessoa entende filmes. Ideal para aprender sintaxe sem barreira de domínio. |
| **2** | `filmes_imdb.csv` → `inv_florestal.csv` | Transição — mesmas técnicas, novo contexto profissional. |
| **3** | `clima.xlsx` + `talhoes.xlsx` | Dados reais do dia a dia florestal. |
| **4** | `inv_florestal.csv` + `experimento.xlsx` | Inventário completo + delineamento experimental. |

---

## Visão geral

| Dia | Manhã (4h) | Tarde (4h) |
|-----|-----------|-----------|
| **1** | P1: Introdução ao R e RStudio | P2: dplyr + **primeiros gráficos** 🎬 |
| **2** | P3: dplyr avançado + Joins | P4: Visualização de dados (ggplot2 completo) |
| **3** | P5: Strings, Fatores e Datas | P6: Tidy Data + Importação avançada |
| **4** | P7: Iteração + Funções | P8: Modelagem + Projeto final |

---

## Dia 1 — Fundamentos (filmes_imdb)

### Período 1 — Manhã: Introdução ao R e RStudio

**Objetivo:** Familiarizar o aluno com o ambiente R, entender a lógica de programação e dominar os tipos fundamentais de dados.

**Conteúdo:**

1. **O que é o R?** (15 min)
   - História, comunidade, CRAN
   - Por que R? (vs Excel, Python)
   - Filosofia: "everything is an object, everything is a function call"

2. **Instalação e ambiente** (30 min)
   - Download e instalação do R + RStudio
   - Tour pelo RStudio: console, editor, environment, files, plots, help
   - Configuração: tema escuro, fonte, encoding UTF-8

3. **Primeiros passos no console** (45 min)
   - R como calculadora
   - Atribuição (`<-` vs `=`)
   - Comentários (`#`)
   - Ajuda (`?`, `help()`)
   - Scripts `.R` e projetos (`.Rproj`)

4. **Estruturas de dados** (90 min)
   - Vetores: `numeric`, `character`, `logical`
   - Coerção: `as.numeric()`, `as.character()`
   - `NA`, `NaN`, `NULL`
   - Fatores (`factor`)
   - Listas e data frames
   - `str()`, `glimpse()`, `head()`, `summary()`

**Atividades práticas:**
- Criar projeto RStudio
- Criar vetor de notas de filmes, calcular média, máximo, mínimo
- Criar data frame manual com título, ano, nota de 5 filmes
- Explorar `filmes_imdb` com `glimpse()` e `summary()`

**Exercícios:**
1. Crie um vetor com as notas dos seus 5 filmes favoritos. Qual a média?
2. O que acontece ao tentar calcular `mean(c(8.5, 9.0, NA, 7.5))`? Como resolver?
3. Crie um data frame com 3 filmes: título, ano, nota. Qual a classe de cada coluna?
4. No `filmes_imdb`, quantas linhas? Quantas colunas? Qual o range de `nota`?
5. Qual o filme mais antigo? E o mais recente?

---

### Período 2 — Tarde: dplyr + seus primeiros gráficos 🎬

**Objetivo:** Capacitar o aluno a importar, transformar e resumir dados com `dplyr` E criar visualizações simples com `ggplot2` — sair do primeiro dia já fazendo tabelas e gráficos.

**Conteúdo:**

1. **Importação de dados** (20 min)
   - `read_csv()`, `read_csv2()`
   - Caminhos relativos

2. **O pipe `%>%`** (15 min)
   - Atalho: `Ctrl/Cmd + Shift + M`

3. **Verbos principais do dplyr** (1h 30min)
   - `filter()` — `filter(filmes, nota >= 8.0, ano > 2000)`
   - `select()` — `select(filmes, titulo, ano, nota)`
   - `mutate()` — `mutate(filmes, lucro = faturamento - orcamento)`
   - `arrange()` — `arrange(filmes, desc(nota))`
   - `summarise()` — `summarise(filmes, nota_media = mean(nota), n = n())`
   - `group_by()` + `summarise()` — agrupar por gênero ou diretor
   - `count()` — `count(filmes, genero, sort = TRUE)`

4. **🎬 Seus primeiros gráficos (ggplot2)** (1h 15min)
   - **Sem teoria pesada — foco em resultado imediato!**
   - Receita simples: `ggplot(dados, aes(x, y)) + geom_*()`
   - `geom_histogram()` — distribuição das notas
   - `geom_point()` — orçamento × faturamento
   - `geom_col()` — top 10 diretores (com dados do `count()`)
   - `geom_boxplot()` — nota por gênero
   - Cada gráfico em 2-3 linhas de código
   - "Olha só o que vocês já conseguem fazer no primeiro dia!"

**Atividades práticas:**
- Pipeline: filter → select → mutate → group_by → summarise
- Cada tabela vira um gráfico na sequência
- Alunos reproduzem cada gráfico junto com o instrutor

**Exercícios:**
1. Filtre filmes com nota ≥ 8.5. Quantos são? Quem são?
2. Crie `lucro = faturamento - orcamento`. Qual o filme mais lucrativo?
3. Agrupe por gênero e calcule nota média. Qual gênero tem a maior média?
4. Faça um histograma da coluna `nota`. A distribuição é simétrica?
5. Plote `orcamento` × `faturamento` com `geom_point()`. Existe relação?
6. Crie um gráfico de barras com os 10 gêneros mais frequentes.
7. Faça um boxplot de `nota` por gênero. Surpreso com algum resultado?

---

## Dia 2 — Manipulação avançada e Visualização

### Período 3 — Manhã: dplyr avançado + Joins

**Objetivo:** Aprofundar transformações com operações condicionais, janelas e integração de múltiplas tabelas. **Transição para dados florestais.**

**Conteúdo:**

1. **Revisão + correção exercícios** (20 min)

2. **Manipulação condicional** (45 min)
   - `case_when()` — categorizar: `case_when(nota >= 8.5 ~ "Excelente", nota >= 7 ~ "Bom", TRUE ~ "Regular")`
   - `if_else()` — binário
   - **Dado florestal:** classificar DAP: "Fina", "Média", "Grossa"

3. **Operações com janelas** (45 min)
   - `slice_max(nota, n = 3)` — top 3 por gênero
   - `lag()`, `lead()` — comparar valores consecutivos
   - **Dado florestal:** top 5 árvores por parcela, IMA

4. **Joins** (70 min)
   - `left_join()`, `inner_join()`, `anti_join()`
   - Exemplo: filmes + elenco, inventário + cadastro de parcelas
   - `bind_rows()` — empilhar inventários de anos diferentes

**Atividades práticas:**
- Categorizar filmes por faixa de nota
- Top 3 filmes por gênero
- Juntar inventário com cadastro de parcelas

**Exercícios:**
1. Categorize filmes em "Oscar" (≥ 8.5), "Bom" (7-8.4), "Regular" (< 7).
2. Top 3 filmes por gênero com `slice_max()`.
3. No `inv_florestal`, classifique árvores por classe de DAP: < 15, 15-25, > 25 cm.
4. Faça `left_join` entre `inv_florestal` e `parcelas`. O volume/ha muda o ranking?
5. Use `anti_join` para verificar se há parcelas no inventário sem cadastro.
6. Calcule IMA (volume / idade). Qual parcela tem maior produtividade?

---

### Período 4 — Tarde: Visualização de dados (ggplot2 completo)

**Objetivo:** Dominar a gramática de gráficos — customização, facetas e exportação. Gráficos com qualidade de publicação usando dados florestais.

**Conteúdo:**

1. **Gramática de gráficos** (30 min)
   - Revisão: `ggplot(data, aes(x, y)) + geom_*()`
   - Mapeamento estético: `aes(color = especie)`, `aes(size = volume)`

2. **Geometrias essenciais** (60 min)
   - `geom_histogram()` — distribuição diamétrica
   - `geom_point()` + `geom_smooth()` — relação hipsométrica
   - `geom_boxplot()` — comparar espécies ou parcelas
   - `geom_col()` — volume por espécie

3. **Customização** (60 min)
   - Cores: `scale_color_brewer(palette = "Set1")` / `scale_fill_viridis_d()`
   - Temas: `theme_minimal()`, `theme_bw()`
   - Títulos: `labs(title = "Distribuição diamétrica", x = "DAP (cm)", y = "Frequência")`
   - Legendas: posição, títulos
   - `coord_flip()` para nomes longos de espécies

4. **Facetas** (30 min)
   - `facet_wrap(~parcela)` — ver todas as parcelas
   - `facet_grid(especie ~ .)` — comparar espécies

5. **Exportação** (30 min)
   - `ggsave("dist_diametrica.png", width = 8, height = 6, dpi = 300)`

**Atividades práticas:**
- Distribuição diamétrica por espécie
- Relação hipsométrica (DAP × altura) com `geom_smooth()`
- Boxplot de volume por parcela
- Dashboard florestal com `patchwork`

**Exercícios:**
1. Histograma da distribuição diamétrica. Qual a moda?
2. Plote DAP × altura, cor por espécie. Adicione `geom_smooth(method = "lm")`.
3. Boxplot de DAP por parcela. Quais parcelas têm maior variabilidade?
4. Gráfico de barras: volume total por espécie.
5. Use `facet_wrap(~especie)` na relação hipsométrica.
6. Exporte seu melhor gráfico como PNG (10×6 pol, 300 DPI).

---

## Dia 3 — Dados reais e automação

### Período 5 — Manhã: Strings, Fatores e Datas

**Objetivo:** Dominar a manipulação de texto, fatores e datas nos dados florestais reais — limpeza de espécies, ordenação, datas de medição.

**Conteúdo:**

1. **Texto com `stringr`** (75 min)
   - `str_detect()` — encontrar espécies: `str_detect(especie, "Euca")`
   - `str_replace()` — padronizar: "Eucalyptus grandis" → "E. grandis"
   - `str_to_lower()`, `str_trim()` — faxina pós-campo
   - `str_extract()` — extrair número da parcela: "PARC-001" → "001"

2. **Fatores com `forcats`** (45 min)
   - `fct_reorder(especie, dap)` — ordenar por DAP médio
   - `fct_lump(n = 3)` — agrupar espécies raras
   - `fct_infreq()` — ordenar por frequência

3. **Datas com `lubridate`** (60 min)
   - `dmy("15/03/2023")` — datas brasileiras
   - `year()`, `month()`, `semester()`
   - `interval(data_plantio, data_medicao) / years(1)` — idade
   - Dados climáticos: temperatura média por mês

**Atividades práticas:**
- Padronizar nomes de espécies
- Reordenar espécies por volume no boxplot
- Parsear datas de medição e calcular idade

**Exercícios:**
1. Na coluna `especie`, quantos nomes contêm "Eucalyptus"?
2. Padronize: remova espaços extras, converta para minúsculas.
3. Agrupe espécies raras (< 10 árvores) como "Outras".
4. Parse `data_medicao` no formato `"15/03/2023"` e extraia o mês.
5. Calcule idade = `interval(data_plantio, data_medicao) / years(1)`.
6. No `clima.xlsx`, calcule temperatura média por mês e plote.

---

### Período 6 — Tarde: Tidy Data + Importação Avançada

**Objetivo:** Dominar pivotagem e importar dados de fontes reais — múltiplas abas, múltiplos CSVs, dados climáticos.

**Conteúdo:**

1. **Princípios de Tidy Data** (20 min)
   - Cada coluna = variável, cada linha = observação
   - Formato largo vs longo

2. **Pivotagem com `tidyr`** (90 min)
   - `pivot_longer()` — inventário contínuo (colunas dap_2021, dap_2022, dap_2023)
   - `pivot_wider()` — tabela volume por parcela × espécie
   - `separate()` — "T1-P2" → talhão + parcela
   - `complete()`, `fill()` — preencher combinações e NAs

3. **Importação de múltiplos arquivos** (60 min)
   - `excel_sheets()` + `map(read_excel)` — todas as abas
   - `list.files("dados/")` + `map(read_csv2)` — todos os CSVs
   - Combinar inventários anuais: `bind_rows()`

4. **Dados ausentes** (10 min)
   - `drop_na()`, `replace_na()`

**Atividades práticas:**
- Converter inventário de formato largo para longo
- Importar e combinar todas as abas do `talhoes.xlsx`
- Tabela de volume por parcela × espécie

**Exercícios:**
1. Converta colunas `dap_2021`, `dap_2022`, `dap_2023` para formato longo.
2. Após pivotar, plote evolução do DAP médio ao longo dos anos.
3. Importe todas as abas do `talhoes.xlsx` e combine.
4. Gere tabela de volume total por talhão × espécie (`pivot_wider`).
5. Verifique com `complete()` se toda parcela tem registro de toda espécie.

---

## Dia 4 — Automação e Modelagem

### Período 7 — Manhã: Iteração e Funções

**Objetivo:** Escrever funções para cálculos florestais e automatizar análises com `purrr`.

**Conteúdo:**

1. **Por que iterar?** (20 min)
   - Exemplo: calcular volume para 50 parcelas manualmente

2. **Funções** (75 min)
   - Anatomia: `area_basal <- function(dap) { pi * (dap/200)^2 }`
   - Funções florestais: área basal, volume, IMA, sortimento
   - Classificação de sítio
   - Documentação

3. **Iteração com `purrr`** (75 min)
   - `map()` — aplicar função a cada parcela
   - `map_dbl()`, `map_dfr()` — saída tipada
   - Aninhar: `group_by(parcela) %>% nest()` → `mutate(modelo = map(data, ~lm(altura ~ log(dap), data = .x)))`
   - `walk()` — salvar gráfico por parcela
   - Gerar relatório de inventário por talhão

**Atividades práticas:**
- Escrever função `area_basal(dap)`
- Aninhar dados por parcela e ajustar modelo hipsométrico
- Salvar gráfico de cada parcela

**Exercícios:**
1. Escreva `area_basal(dap)` — retorne área basal em m².
2. Crie `volume(dap, altura, ff = 0.5)`.
3. Use `map_dbl()` para aplicar `volume()` a todas as linhas.
4. Aninhe por `parcela` e ajuste `lm(altura ~ log(dap))` para cada.
5. Extraia R² de cada modelo com `map_dbl()` e `broom::glance()`.
6. Gere e salve um gráfico DAP×altura por parcela com `walk()`.

---

### Período 8 — Tarde: Modelagem + Projeto Final

**Objetivo:** Introduzir modelos estatísticos aplicados à silvicultura e consolidar o aprendizado em um projeto completo de inventário florestal.

**Conteúdo:**

1. **Regressão florestal** (60 min)
   - Relação hipsométrica: `lm(altura ~ log(dap), data = inv)`
   - Modelo de volume: `lm(log(volume) ~ log(dap) + log(altura), data = inv)`
   - `summary()` — interpretar R² e significância
   - `broom::tidy()`, `glance()`, `augment()`
   - Diagnóstico de resíduos

2. **ANOVA e delineamento** (45 min)
   - Comparar volume entre espécies: `aov(volume ~ especie, data = inv)`
   - `TukeyHSD()` — teste de comparação múltipla
   - Boxplot + letras de Tukey
   - DIC com `experimento.xlsx`

3. **Comunicando resultados** (30 min)
   - Tabelas formatadas com `gt`
   - Inline code no Quarto
   - Storytelling: contexto → análise → recomendação

4. **Projeto final** (105 min)
   - Dataset: inventário florestal completo
   - Roteiro:
     1. Importar e inspecionar (10 min)
     2. Calcular área basal, volume/árvore, volume/ha (15 min)
     3. Análise exploratória (distribuição diamétrica, hipsométrica) (20 min)
     4. Modelagem (volume + ANOVA espécies) (20 min)
     5. Mini-relatório técnico (20 min)
     6. Apresentação (20 min)

**Exercícios:**
1. Ajuste `lm(altura ~ log(dap))`. Qual o R²?
2. Ajuste `lm(log(volume) ~ log(dap) + log(altura))`. Interprete.
3. ANOVA comparando volume entre espécies. Significativo?
4. Boxplot de volume por espécie com letras de Tukey.
5. Tabela-resumo: volume/ha, DAP médio, árvores/ha por espécie.
6. **Projeto final:** mini-relatório de inventário com descrição, estatísticas, gráficos e recomendação.

---

## Resumo dos datasets por período

| Período | Dataset | Destaque |
|---------|---------|----------|
| P1 | `filmes_imdb.csv` | 🎬 Engajamento — todo mundo entende filme |
| P2 | `filmes_imdb.csv` | 📊 dplyr + primeiros gráficos no 1º dia! |
| P3 | `filmes_imdb` → `inv_florestal` + `parcelas` | 🌲 Transição para dados profissionais |
| P4 | `inv_florestal.csv` | 📈 ggplot2 completo com contexto florestal |
| P5 | `inv_florestal` + `clima.xlsx` | 🧹 Faxina de dados reais de campo |
| P6 | `clima.xlsx` + `talhoes.xlsx` | 📥 Importação de fontes reais múltiplas |
| P7 | `inv_florestal.csv` | ⚙️ Automação — funções e purrr |
| P8 | `inv_florestal` + `experimento.xlsx` | 📐 Modelagem + projeto final |

---

## Estrutura de arquivos

```
curso_r_v2/
├── _quarto.yml
├── index.qmd
├── 01-introducao.qmd
├── 02-manipulacao.qmd
├── 03-manipulacao-avancada.qmd
├── 04-visualizacao.qmd
├── 05-strings-fatores-datas.qmd
├── 06-tidy-data.qmd
├── 07-iteracao-funcoes.qmd
├── 08-modelagem.qmd
├── _util.R
├── data/
│   ├── filmes_imdb.csv
│   ├── inv_florestal.csv
│   ├── parcelas.csv
│   ├── clima.xlsx
│   ├── experimento.xlsx
│   └── talhoes.xlsx
└── profiles/
    ├── 1-dia.yml
    ├── 2-dias.yml
    └── 4-dias.yml
```

---

## Avaliação

- **Exercícios por período:** 5-7 (graduados: fácil → desafiador)
- **Projeto final:** relatório de inventário florestal completo
- **Feedback:** correção coletiva no início de cada período seguinte
- **Nivelamento:** exercícios bônus para alunos avançados

---

## ⚡ Diferencial pedagógico

- **Dia 1, Período 2:** alunos saem fazendo tabelas E gráficos — motivação instantânea
- **Dia 2:** mesmas técnicas, novo domínio — mostrando que R se aplica a qualquer área
- **Dia 3:** dados reais, bagunçados, do mundo real — preparação para a rotina
- **Dia 4:** automação + modelagem — o aluno vira analista de verdade
