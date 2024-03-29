
# (PART\*) Módulo II  {-}

# Estrutura de objetos e elementos {-}

Para fazer o melhor uso da linguagem R, você precisará de uma forte compreensão dos tipos de objetos e estruturas de dados.

É muito importante compreender isto, porque estes são os objetos que você vai manipular no dia-a-dia no R. Lidar com conversões de objetos é uma das fontes mais comuns de frustração para quem está começando.

> To understand computations in R, two slogans are helpful:  
    - Everything that exists is an object.  
    - Everything that happens is a function call.  
> _John Chambers_

Primeiro vamos falar dos elementos, ou seja, a matéria prima dentro de um objeto. No `R`, os tipos de elementos mais utilizados são:

* character
* numeric
* integer
* logical

Veja abaixo o exemplo de cada classe. Note que utilizamos o `L` para indicar o número inteiro.

| Exemplo         | Tipo      |
| -------         | ----      |
| "a", "swc"      | character |
| 2, 15.5         | numeric   | 
| 2L              | integer   |
| `TRUE`, `FALSE` | logical   |

Vamos fazer alguns testes para exemplificar os tipos na prática.


```r
library(tidyverse)

x <- "dataset"

typeof(x)

y <- 1:10

typeof(y)

length(y)

z1 <- c(1L, 2L, 3L)
z2 <- c(1, 2, 3)

typeof(z1)
typeof(z2)
```

Como em qualquer outra linguagem de programação, o R tem em sua concepção tipos e estruturas de dados que determinam como será o comportamento durante os processos. Os tipos de dados são estes: 

|    | Homogêneo     | Heterogêneo   |
|----|---------------|---------------|
| 1d | Atomic vector | List          |
| 2d | Matrix        | Data frame    |
| nd | Array         |               |

É importante entender a diferença entre estes tipo de objetos pois cada um dele tem um comportamento diferente e exigem tipos específicos de elementos.


## Vetores {-}

Um vetor é a estrutura de dados mais comum e básica do `R`. Tecnicamente, os vetores podem ser de dois tipos: `atomic vectors` e `lists`. No dia a dia, utilizamos o termo `vector` para se referir ao objeto comumente se refere ao tipo atômico, não listas.

Um `vector` pode ser do tipo `character`,` logical`, `integer` ou` numeric`, o que nos remete ao tipo de elemento que ele armazena.

Você pode criar um vetor vazio com `vector()` (por padrão, o modo é `logical`. Você pode ser mais direto e especificar outro tipo de elemento). Outra forma é usar construtores diretos como `character()`, `numeric()`, etc.


```r
x <- vector()
vector("character", length = 10) 
logical(5)
x <- c(1, 2, 3)
length(x)
```

`x` é um vetor numérico. Para criar inteiros explicitamente, adicione um `L` no final.


```r
x1 <- c(1L, 2L, 3L)
```

Você também pode ter um vetor de caracteres.


```r
z <- c("Alex", "Danilo", "Maria", "Jéssica")
```

Para saber mais sobre o seu vetor.


```r
typeof(z)
length(z)
class(z)
str(z)
```

Adicionando elementos com o contatenador básico `c()`.


```r
z <- c(z, "João")
```

Você também pode criar vetores como uma sequência de números.


```r
series <- 1:10
seq(10)
seq(1, 10, by = 0.1)
```

O que acontece quando você mistura tipos? Primeiro tente adivinhar o que o comandos abaixo vão fazer e depois execute no console.


```r
xx <- c(1.7, "a", "B") 
xx <- c(TRUE, FALSE, 2) 
xx <- c("a", TRUE)
```

Isso é chamado de coerção implícita. Você também pode forçar vetores explicitamente usando o `as.<Class_name>`. Exemplo


```r
as.numeric()
as.character()
```


```r
x <- 0:6
as.logical(x) 
as.character(x)
```

Entretanto, coerções absurdas não funcionam.


```r
x <- c("a", "b", "c")
as.numeric(x) 
as.logical(x)
```
  
  
## Fatores {-}

Fatores são vetores especiais que representam dados categóricos. Os fatores podem ser ordenados ou desordenados e são importantes para funções de modelagem como `lm()` e `glm()` e também na criação de gráficos.

Os fatores são números inteiros que têm rótulos sobre eles. Enquanto os fatores parecem (e muitas vezes se comportam) como vetores de caracteres, eles são inteiros sob o capô, e você precisa ter cuidado ao tratá-los como caracteres.

Fatores podem ser criados com `factor()`. A entrada é geralmente um vetor de caracteres.


```r
x <- factor(c("sim", "nao", "sim", "nao", "sim"))
```

Se você precisa converter um fator em um vetor de caracteres, simplesmente use:


```r
as.character(x)
```

Nas funções de modelagem, é importante saber qual é o nível de linha de base.
Este é o primeiro fator, mas por padrão o pedido é determinado por ordem alfabética das palavras inseridas. Você pode alterar isso especificando os níveis (outra opção é usar a função `fct_relevel`).


```r
x <- factor(c("sim", "nao", "sim"), levels = c("sim", "nao"))
x

fct_relevel(x, "nao", "sim")
```

## Matrizes e arrays {-}

Se acrescentarmos mais dimensões aos vetores teremos matrizes (2d) e arrays (ou arranjos) para várias dimensões.


```r
matrix(data = c("A", "B", "C", 1, 2, 3), ncol = 3, nrow = 2)

x <- matrix(data = 1:6, ncol = 3, nrow = 2)
x
```


```r
typeof(x)
```


```r
class(x)
```


```r
x <- array(data = 1:18, dim = c(2, 3, 3))
x
```


```r
typeof(x)
```


```r
class(x)
```


```r
x <- list(1:3, "a", TRUE, 1.0, matrix(1:6, ncol = 3, nrow = 2))
x
```


```r
typeof(x)
```


```r
class(x)
```


## Lists {-}

As listas são vetores com flexibilidade quanto ao tipo do elemento. Para criá-la basta usar `list()` ao invés de `c()`.


```r
x <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
x
```


```r
str(x)
```


## Data frame {-}

Objetos do tipo `data.frame` são os mais comuns quando estamos trabalhando no R. Você pode entender um data frame como um conjunto de vetores, ou como uma matriz com maior flexibilidade. Quando você combina colunas, o números de linhas precisam corresponder. Se você estiver adicionando um vetor, ele será repetido pelo princípio do `recycling`



```r
df <- data.frame(id = letters[1:10], x = 1:10, y = rnorm(10), z = 4)

tbl <- tibble(id = letters[1:10], x = 1:10, y = rnorm(10), z = 4)
```

Algumas funções úteis que lidam com data frames  

* `head()` - veja as primeiras 6 linhas  
* `tail()` - veja as últimas 6 linhas  
* `dim()` - ver dimensões  
* `nrow()` - número de linhas  
* `ncol()` - número de colunas  
* `str()` - estrutura de cada coluna  
* `bind_rows` - empilhas as linhas dos data.frames com colunas equivalentes
* `bind_cols` - junta colunas de data.frames com o mesmo número de linhas


## Missing values {-}

Denotado por `NA` e / ou` NaN` para operações matemáticas indefinidas.


```r
is.na(100)
is.nan(0/0)
```


```r
x <- c(1, 2, NA, 4, 5)
mean(x)
mean(x, na.rm = TRUE)
na.omit(x)
```


## Exercícios {-}


(@) **Crie um vetor de caracteres que 20 elementos quaisquer.**


```
#>  [1] "g" "e" "t" "b" "o" "k" "n" "p" "a" "l" "m" "c" "d" "i" "r" "q" "f"
#> [18] "s" "j" "h"
```
<br>

(@) **Crie uma sequência de 50 a 150, somente com numeros pares.**


```
#>  [1]  50  52  54  56  58  60  62  64  66  68  70  72  74  76  78  80  82
#> [18]  84  86  88  90  92  94  96  98 100 102 104 106 108 110 112 114 116
#> [35] 118 120 122 124 126 128 130 132 134 136 138 140 142 144 146 148 150
```
<br>

(@) **Crie um vetor lógico com 4 elementos, armazene em um objeto e em seguida trasforme em um vetor numérico.**


```
#> [1]  TRUE FALSE  TRUE  TRUE
#> [1] 1 0 1 1
```
<br>

(@) **Crie uma vector de caracteres quaisquer que possua 2 fatores.**


```
#>  [1] a b a b a b a b a b a b a b a b a b a b a b a b a b a b a b
#> Levels: a b
```
<br>

(@) **Crie um data frame com 3 colunas e 10 linhas utilizando números aleatórios para o compor.**


```
#>               x           y          z
#> 1  -0.236918034 -0.48832377  1.5791733
#> 2   0.209041392  2.46034851 -1.2978575
#> 3   1.594494569 -2.93769813  0.8046953
#> 4  -0.388472845 -2.19728450 -0.8040328
#> 5   0.608257271  1.19193302  0.4315485
#> 6   0.752073053 -0.82293139  0.7896385
#> 7  -0.741333344 -1.36321722 -0.9090382
#> 8   0.207068624 -0.77813055 -0.2827280
#> 9  -0.334033498  0.08450971 -0.7932897
#> 10  0.003045311  0.77610512  1.0454384
```
<br>

(@) **Crie um vetor com 10 numeros aleatorios e armazene-o em um objeto de nome 'x'. Em seguida mostre seu conteúdo.**


```
#>  [1]  0.3065743  0.4444781  0.1909876  0.9505543 -2.0747753 -0.9263543
#>  [7]  1.3569865  1.3645342  0.6529419  1.0725909
```

