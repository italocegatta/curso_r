# Diagnóstico — Unificação dos Cursos de Introdução ao R

> **Autor:** Hermes Agent (via Ítalo Cegatta)  
> **Data:** 30 de maio de 2026  
> **Objetivo:** Diagnosticar o conteúdo dos 5 repositórios de cursos e propor estrutura unificada no formato Quarto Book.

---

## 1. Repositórios analisados

| # | Repositório | Tecnologia | Ano | Capítulos | Duração estimada |
|---|------------|-----------|-----|-----------|-----------------|
| 1 | `curso_r` | bookdown::gitbook | 2019 | 10 capítulos | 4 dias (3 módulos × 16h) |
| 2 | `jornadas` | bookdown::gitbook | 2024 | 5 capítulos | 2 dias |
| 3 | `r_relampago` | bookdown::gitbook | 2020 | 4 capítulos | 1 dia |
| 4 | `cursos_old` | R Markdown v1 (standalone) | 2016 | 3 capítulos | 1-2 dias |
| 5 | `cursoR_gmap` | R Markdown v1 (standalone) | 2019 | 5 capítulos | 2 dias |

---

## 2. Análise por repositório

### 2.1 `curso_r` — O mais completo (4 dias)

**Estrutura (_bookdown.yml):**
```
index.rmd
01-sobre-r.rmd        → Introdução ao R, download, RStudio
02-manipulacao.rmd    → dplyr: filter, select, mutate, summarise, group_by
03-visualizacao.rmd   → ggplot2: geom_point, geom_histogram, geom_boxplot, facets
04-regressao.rmd      → lm(), ANOVA, pressupostos, broom::tidy
05-objetos.rmd        → Vetores, listas, data.frames, tibbles
06-indexacao.rmd      → $, [[]], [], filter lógico
07-string-factor-date.rmd → stringr, forcats, lubridate
08-joins.rmd          → left_join, inner_join, bind_rows
09-tidy-data.rmd      → pivot_longer, pivot_wider, separate
10-iteracao.rmd       → purrr::map, for loops, funções
```

**Pontos fortes:**
- Conteúdo mais abrangente (único com regressão, tidy-data, iteração)
- Dataset único (`filmes_imdb.csv`) mantém coerência entre capítulos
- `_util.R` como script de setup
- YAML bem estruturado com idioma PT-BR (Figura, Tabela, Capítulo)

**Pontos fracos:**
- bookdown (não Quarto)
- `.rmd` vs `.Rmd` — inconsistência entre `_bookdown.yml` e arquivos reais
- Sem capítulo de exercícios dedicado

---

### 2.2 `jornadas` — 2 dias (pesquisa florestal)

**Estrutura (_bookdown.yml):**
```
index.rmd
01-sobre-r.rmd        → Mesmo conteúdo do curso_r (cópia exata)
02-manipulacao.rmd    → dplyr + readxl
03-joins.rmd          → Joins (ordem diferente do curso_r)
04-visualizacao.rmd   → ggplot2
05-exercicios.rmd     → Exercícios práticos (DIFERENCIAL!)
```

**Pontos fortes:**
- Capítulo de exercícios dedicado (ausente nos outros)
- Atualizado em 2024 (mais recente)
- Contexto aplicado (dados florestais)

**Pontos fracos:**
- Menos tópicos (sem regressão, iteração, tidy-data)
- Joins antes de visualização (ordem didática questionável)
- Links quebrados (Sharepoint Suzano)

---

### 2.3 `r_relampago` — 1 dia

**Estrutura (_bookdown.yml):**
```
index.rmd
01-sobre-r.rmd        → Igual aos outros
02-manipulacao.rmd    → dplyr básico
03-joins.rmd          → Joins
04-visualizacao.rmd   → ggplot2
```

**Pontos fortes:**
- Enxuto — cobre o essencial em 4 capítulos
- Bom ponto de partida para o curso de 1 dia

**Pontos fracos:**
- Sem exercícios
- Sem capítulo de objetos/tipos de dados (importante para iniciantes)

---

### 2.4 `cursos_old` — Formato legado (2016)

**Estrutura:**
```
01_01_intro_geral.Rmd/.html
01_03_manipulacao.html
02_02_estat.html
_scr_avaliacao.R
dataset/*.xlsx
```

**Pontos fortes:**
- Datasets reais em Excel (`.xlsx`) — potencial para reuso
- Script de avaliação (`_scr_avaliacao.R`)
- Conteúdo de estatística aplicada

**Pontos fracos:**
- Formato obsoleto (R Markdown v1, Bootstrap 3)
- Estrutura confusa de nomenclatura (`01_01`, `01_03`, `02_02`)
- Scripts `.R` sem renderização

---

### 2.5 `cursoR_gmap` — Formato legado com experimental (2019)

**Estrutura (HTML/Rmd standalone):**
```
01_warm-up.Rmd/.html       → Introdução + objetos
02_manipulacao.html         → dplyr
03_visualizacao.html        → ggplot2
04_experimental.html        → Estatística experimental (DIFERENCIAL!)
04_exercicios.html          → Exercícios
05_exercicios.html          → Mais exercícios
```

**Pontos fortes:**
- **Único com delineamento experimental** (DIC, DBC, ANOVA)
- Grande quantidade de exercícios (2 capítulos!)
- `cursoR_gmap.Rproj` — projeto RStudio organizado

**Pontos fracos:**
- Formato standalone (sem bookdown/Quarto)
- Só HTML compilado para alguns capítulos (sem fonte `.Rmd`)
- Bootstrap 3 desatualizado

---

## 3. Matriz de tópicos × repositórios

| Tópico | curso_r (4d) | jornadas (2d) | r_relampago (1d) | cursos_old | cursoR_gmap |
|--------|:-----------:|:-----------:|:-------------:|:--------:|:---------:|
| Intro R + RStudio | ✅ | ✅ | ✅ | ✅ | ✅ |
| Objetos e tipos | ✅ | ❌ | ❌ | ✅ | ✅ |
| Indexação | ✅ | ❌ | ❌ | ❌ | ❌ |
| Manipulação (dplyr) | ✅ | ✅ | ✅ | ✅ | ✅ |
| Visualização (ggplot2) | ✅ | ✅ | ✅ | ❌ | ✅ |
| Joins | ✅ | ✅ | ✅ | ❌ | ❌ |
| Strings/Factors/Datas | ✅ | ❌ | ❌ | ❌ | ❌ |
| Tidy data | ✅ | ❌ | ❌ | ❌ | ❌ |
| Iteração (purrr) | ✅ | ❌ | ❌ | ❌ | ❌ |
| Regressão/ANOVA | ✅ | ❌ | ❌ | ✅ | ✅ |
| Delineamento experimental | ❌ | ❌ | ❌ | ❌ | ✅ |
| Exercícios dedicados | ❌ | ✅ | ❌ | ❌ | ✅ |

---

## 4. Proposta: Estrutura unificada `curso_r_v2`

### 4.1 Arquitetura (Quarto Book)

```
curso_r_v2/
├── _quarto.yml              # Configuração principal
├── index.qmd                # Apresentação + programa
├── 01-intro.qmd             # Introdução ao R e RStudio
├── 02-objetos.qmd           # Objetos, tipos, indexação
├── 03-manipulacao.qmd       # dplyr (filter, select, mutate, summarise, group_by)
├── 04-visualizacao.qmd      # ggplot2
├── 05-joins.qmd             # Joins (left, inner, full, bind)
├── 06-strings.qmd           # stringr, forcats, lubridate
├── 07-tidy.qmd              # pivot_longer, pivot_wider
├── 08-iteracao.qmd          # purrr, for, funções
├── 09-modelagem.qmd         # lm(), ANOVA, delineamento
├── 10-exercicios.qmd        # Exercícios integrados
├── _util.R                  # Script de setup
├── data/                    # Datasets
│   ├── filmes_imdb.csv
│   └── dados_florestais/
├── profiles/                # Perfis por duração
│   ├── 1-dia.yml
│   ├── 2-dias.yml
│   └── 4-dias.yml
└── README.md
```

### 4.2 Grade por duração

#### ☀️ Curso de 1 dia (8h) — "R Express"

| Horário | Capítulo | Conteúdo |
|---------|----------|----------|
| 08:00-09:30 | 01-intro | R, RStudio, primeiros passos |
| 09:30-10:30 | 02-objetos | Vetores, data.frames, tibbles (essencial) |
| 10:30-12:00 | 03-manipulacao | filter, select, mutate, summarise |
| 13:00-15:00 | 04-visualizacao | geom_point, geom_histogram, geom_boxplot |
| 15:00-16:30 | 10-exercicios | Exercícios integrados |
| 16:30-17:00 | Encerramento | Dúvidas, próximos passos |

#### 🌤️ Curso de 2 dias (16h) — "R Fundamentos"

| Dia | Capítulos | Conteúdo |
|-----|-----------|----------|
| **Dia 1 manhã** | 01-intro + 02-objetos | Ambiente R + tipos de dados |
| **Dia 1 tarde** | 03-manipulacao | dplyr completo |
| **Dia 2 manhã** | 04-visualizacao + 05-joins | gráficos + cruzar tabelas |
| **Dia 2 tarde** | 10-exercicios | Exercícios integrados |

#### 🌞 Curso de 4 dias (32h) — "R Completo"

| Dia | Capítulos | Conteúdo |
|-----|-----------|----------|
| **Dia 1** | 01-intro + 02-objetos + 03-manipulacao | Fundamentos |
| **Dia 2** | 04-visualizacao + 05-joins | Visualização e joins |
| **Dia 3** | 06-strings + 07-tidy + 08-iteracao | Dados reais e automação |
| **Dia 4** | 09-modelagem + 10-exercicios | Estatística e prática |

### 4.3 Tecnologia: Quarto Book

**Migração de bookdown → Quarto:**

| bookdown | Quarto |
|----------|--------|
| `_bookdown.yml` | `_quarto.yml` |
| `index.Rmd` | `index.qmd` |
| `.Rmd` | `.qmd` |
| `bookdown::gitbook` | `format: html` com `type: book` |
| `before_chapter_script` | `execute: before: _util.R` |
| `output_dir: docs` | `output-dir: docs` |
| `PART` headers | `part:` no YAML do capítulo |

---

## 5. O que aproveitar de cada repo

| Repositório | O que APROVEITAR | Prioridade |
|-------------|-----------------|-----------|
| **curso_r** | 10 capítulos (conteúdo quase completo), `filmes_imdb.csv`, estrutura `_bookdown.yml`, `_util.R` | 🔴 Alta — base principal |
| **jornadas** | Capítulo de exercícios (05-exercicios), abordagem aplicada a dados reais | 🟡 Média — exercícios |
| **r_relampago** | Estrutura enxuta (referência para o curso de 1 dia) | 🟢 Baixa — já coberto |
| **cursos_old** | Datasets `.xlsx` (dados florestais reais), script de avaliação | 🟡 Média — datasets |
| **cursoR_gmap** | Conteúdo de delineamento experimental, exercícios extras, `.Rproj` | 🟡 Média — experimental |

---

## 6. Próximos passos

1. ✅ Criar repositório `curso_r_v2`
2. ⬜ Configurar `_quarto.yml` com Quarto Book
3. ⬜ Migrar `curso_r/.Rmd` → `.qmd` (iniciar pelo conteúdo de `curso_r`)
4. ⬜ Criar arquivos `profiles/1-dia.yml`, `profiles/2-dias.yml`, `profiles/4-dias.yml`
5. ⬜ Extrair datasets do `cursos_old/dataset/`
6. ⬜ Mesclar exercícios de `jornadas` e `cursoR_gmap`
7. ⬜ Adicionar delineamento experimental do `cursoR_gmap` ao capítulo 09
8. ⬜ Setup GitHub Pages para deploy automático
9. ⬜ Testar renderização dos 3 perfis
10. ⬜ Atualizar README com instruções

---

## 7. Decisões a tomar

1. **Dataset principal:** Manter `filmes_imdb.csv` (neutro, acessível) ou migrar para dados florestais (contexto dos alunos)?
2. **Idioma do código:** Manter `rmd_files` com nomes em português ou usar inglês (mais padrão na comunidade)?
3. **Formato de saída:** Apenas HTML ou também PDF? (Quarto suporta ambos nativamente)
4. **Pacotes:** Atualizar para `tidyverse` completo ou manter seleção enxuta?
