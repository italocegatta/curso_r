
# Iteração {-}

Existe uma máxima muito interessante entre programadores que diz:

> Don’t Repeat Yourself (DRY)

Humanos são extremamente distraídos e cometem muitos erros quando fazer operações repetitivas. Quando estamos programando, não é diferente. As vezes parece mais fácil copiar e colar uma estrutura de código para alterar apenas um detalhe e ter o resultado que se espera. Mas quando o numero de repetições começa a aumentar a chance de fazermos algo errado cresce junto.

No R, esse tipo de problema é resolvido de duas formas: com funções customizadas ou com loops. Nesse modulo vamos falar apenas de loops, mas com certeza ele já vai resolver muitos dos nossos problemas de repetição.

Como exemplo para esse tema, temos um planilha com os dados separados em abas e temos de juntar todos eles para iniciar a análise. Os dados estão na planilha `base_vespa1.xlsx` e em seguida vamos fazer essa junção de 3 formas diferentes.


```r
library(tidyverse)
library(readxl)
library(broom)

aba1 <- read_excel("input/base_vespa1.xlsx", sheet = 1)
aba2 <- read_excel("input/base_vespa1.xlsx", sheet = 2)
aba3 <- read_excel("input/base_vespa1.xlsx", sheet = 3)
aba4 <- read_excel("input/base_vespa1.xlsx", sheet = 4)
aba5 <- read_excel("input/base_vespa1.xlsx", sheet = 5)

base_mobral <- bind_rows(aba1, aba2, aba3, aba4, aba5)

base_mobral
```


```r
base_loop_out <- list()

for (i in 1:5) {
  
  base_loop_out[[i]] <- read_excel("input/base_vespa1.xlsx", sheet = i)
}

base_loop <- bind_rows(base_loop_out)

base_loop
```


```r
base_purrr <- excel_sheets("input/base_vespa1.xlsx") %>% 
  map_df(read_excel, path = "input/base_vespa1.xlsx")

base_purrr
```

Estes 3 métodos exemplificam bastante a relação entre domínio da programação e quantidade de trabalhado apenas pelo computador. No primeiro exemplo tivermos que repetir várias vezes a estrutura do código para poder chegar no resultado esperado. No segundo, já fomos um pouco mais diretos e deixamos o trabalho repetitivo para o computador. Imagina se tivéssemos 30 abas para juntar? E se fossem 500 arquivos? O terceiro exemplo é um passo além de loops e em linguagem de programação chama-se functional programming, onde funções são usadas para realizar as operações que envolvem loops.


## For loop {-}

Loops são bem comuns em linguagem de programação e nos ajudam muito nas tarefas repetitivas. Eles são compostos de 3 partes: 

* O output, estrutura que será populada em cada iteração. Pode ser um vetor, lista ou data frame. 
* Uma sequência, o universo de possibilidades que será executada em cada iteração ou passo. É comum chamarmos de `i`, mas pode ser qualquer denominação e no código é como se fosse um objeto que a cada iteração muda de conteúdo. 
* O corpo, parte que faz o calculo ou operação envolvendo os passos `i` e guardando no `output`.

Retomando o loop que fizemos para ler as abas, temos os 3 componentes bem claros. Vamos rescreve os loop seguindo algumas boas práticas.


```r
arquivo <- "input/base_vespa1.xlsx"

base_loop_out <- vector("list", length = length(excel_sheets(arquivo)))

for (i in seq_along(base_loop_out)) {
  
  base_loop_out[[i]] <- read_excel(arquivo, sheet = i)
}

base_loop <- bind_rows(base_loop_out)

base_loop
```

## Programação funcional {-}

A outra forma de realizar tarefas repetitivas em R é utilizando funções que foram desenhadas para trabalhar com iteração. O pacote do `tidyverse` que reúne estas funções chame-se `purrr`. A ideia das funções do `purrr` é desenhar as iterações sobre vetores, listas ou linhas de um data frame.


```r
map(c(1, 2, 3, 4), rnorm)

map_dbl(mtcars, mean)

map_int(iris, function(x) length(unique(x)))

map_int(iris, ~ length(unique(.)))
```

O pacote tem várias funções e você pode ler sobre elas com mais calma depois. Neste bloco, utilizar a programação funcional para ajustar regressões especificas para um determinado grupo e sempre mantendo tudo amarado a data frames. Esse é uma concepção de programação bastante nova no R, onde coloca o data frame como esqueleto principal da análise e aplicando todas as etapas dentro dele.


```r
inv <- read_excel("input/TUME_134_2016.xlsx")

inv
```

Nosso objetivo é ajustar um modelo hipsométrico (diâmetro-altura) para cada espécie e em seguida predizer as alturas das árvores. O gráfico a seguir mostra a relação que teríamos se fosse ajustado apenas um modelo para todas as espécies.


```r
ggplot(inv, aes(CAP_cm, H_m)) +
  geom_point(alpha=0.4) +
  geom_smooth(method="lm") +
  theme_bw()
```

Mas na prática, a relação diâmetro-altura é diferente entre as espécies, como pode ser notado logo abaixo. Talvez fique mais evidente a diferença observando os coeficientes dos modelos que serão ajustados a seguir.


```r
ggplot(inv, aes(CAP_cm, H_m)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~Esp)
```

Para entendermos o processo, vamos ajustar a regressão para algumas espécies. O comando `lm()` utiliza a notação em formula para especificar o modelo. Lê-se `H_m` em função de `CAP_cm`, sendo o `~` responsável por determinar as variáveis dependentes e independentes.

O pacote `broom` tem algumas funções que facilitam a extração das informações do modelo ajustado. Iremos utilizar a função `glance` para pegar as estatísticas gerais do modelo e a função `tidy` para acessar os coeficientes e significâncias.



```r
m1 <- lm(H_m ~ CAP_cm, data = filter(inv, Esp == "E_citriodora"))

glance(m1)
```


```r
tidy(m1)
```


```r
m2 <- lm(H_m ~ CAP_cm, data = filter(inv, Esp == "E_maculata"))

glance(m2)
```


```r
tidy(m2)
```

A primeira etapa é entender que um data.frame pode conter vários tipos de elementos, como números, caracteres, listas e também outros data.frames. Para isso utilizaremos a função nest() do pacote tidyr e aninharemos os dados em função das espécies.


```r
inv_nest <- inv %>%
  group_by(Esp) %>%
  nest() 

inv_nest
```

Agora podemos ajustar um modelo de regressão para cada espécie utilizando a função map, do pacote purrr.


```r
dados_modl <- inv_nest %>% 
  mutate(
    ajuste = map(data, ~lm(H_m ~ CAP_cm, data = .)),
    resumo = map(ajuste, glance),
    coef = map(ajuste, tidy),
    resid = map(ajuste, augment)
  )
 
dados_modl
```

Da mesma forma que aninhamos os dados por espécie, podemos retorná-los para o formato original, mas agora mostrando apenas as informações que realmente interessam.


```r
dados_modl %>%
  select(Esp, resumo) %>% 
  unnest(resumo)
```


```r
dados_modl %>%
  select(Esp, coef ) %>% 
  unnest(coef)
```

Após o ajuste do modelo, temos de predizer as alturas. Por fim, temos de volta um `data.frame` com as alturas preditas.


```r
dados_pred <- dados_modl %>% 
  mutate(
    hpred = map2(ajuste, data, predict)
  ) %>%
  select(Esp, data, hpred) %>% 
  unnest(hpred, data)

dados_pred
```

Para visualizar o resultado da regressão, podemos colocar no gráfico a comparação entre valores medidos e preditos.


```r
dados_pred %>% 
  ggplot(aes(CAP_cm)) +
    geom_point(aes(y = H_m), color = "cadetblue") +
    geom_point(aes(y = hpred), color = "red") +
    facet_wrap(~Esp) +
    theme_bw()
```