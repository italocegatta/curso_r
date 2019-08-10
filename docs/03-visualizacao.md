
# Visualização {-}

O `ggplot2`é o pacote mais utilizado para criação de gráficos no R. Ele implementa a Gramática dos Gráficos proposta por Leland Wilkinson em seu livro [The Grammar of Graphics](https://www.amazon.com/Grammar-Graphics-Statistics-Computing/dp/0387245448). A ideia é que há uma gramática racional e computacional para a composição de gráficos estatísticos. Ao controlar a gramática, você pode gerar um grande conjunto de gráficos cuidadosamente construídos a partir de um conjunto relativamente pequeno de operações.

Existem muitos materiais e cursos sobre como criar gráficos com o ggplot2. Basta um simples google sobre o assunto ou problema que você tem e rapidamente vai aparecer uma pergunta semelhante e várias respostas assunto. Como padrão, a documentação do pacote pode ser consultada, bem como diversos livros sobre o assunto. Recomendo o site do pacotes [ggplot2](https://ggplot2.tidyverse.org/) e o [livro do autor](https://www.amazon.com.br/dp/B01GVCRF6M/)


## Conceitos básicos {-}

Existem alguns conceitos básicos em torno desde universo de gráficos. Em primeiro lugar, os gráficos são construídos em camadas (layers). Cada componente do gráfico, a partir dos dados fornecidos, está amarrado ao sistema de coordenadas e este por sua vez, está condicionado aos resumos estatísticos, rótulos e escalas. Portanto, gráficos expressos são construídos com poucos comandos, mas com definições padrões. Para criar gráficos personalizados e de maior qualidade é preciso adicionar algumas funções... mas fique tranquilo, dificilmente vai passar de 7 camadas.

As propriedades gráficas que codificam os dados são dimensões tratadas como *aesthetic* no ggplot2, destacando:

*  x 
*  y 
*  size 
*  shape
*  color
*  fill

Os elementos gráficos são as geometrias, como:

*  point
*  line
*  segment
*  bar/col
*  text
*  area
*  hitogram
*  density

Você também vai querer adicionar estatísticas que resumem seus dados, e o pacote possibilita algumas delas:

*  smooth
*  mean/median
*  function

As dimensões (aesthetic), geometrias e resumos estatísticos constituem as mais importantes camadas de gráfico, mas há uma série de outras características que você vai querer ajustar. As mais comuns são:

*  Eixo x ou y em escala logarítmica
*  Paletas de cores personalizadas
*  Formas de pontos personalizado, ou tipos de linha

As seções seguintes são dedicadas a alguns destes elementos básicos ggplot2.


## Layers {-}

Iremos criar gráficos em camadas. A estratificação de elementos é talvez o aspecto mais poderoso do ggplot2. Isso significa que gráficos relativamente complexos são construídos com pequenas peças, que você pode adicionar ou remover de forma iterativa.


## Os dados {-}

O primeiro argumento da função  `ggplot()` é um `data.frame`, e seu segundo argumento é `aes()`. Você nunca vai usar `aes()` em qualquer outro contexto, exceto dentro de outras funções do ggplot2, por isso talvez seja melhor não pensar em `aes()` como função individual, mas sim como uma forma especial de definir as dimensões dos gráficos.


```r
library(tidyverse)
library(readxl)

inv <- read_excel("input/TUME_134_2016.xlsx")

ggplot(inv, aes(x = CAP_cm, y = H_m))
```

Veja que os dados e as dimensões dos dados já foram informados, entretanto não nada no gráfico criado por não temos uma geometria definida.

Cada layer tem uma base de dados. Você pode indicar os dados na função principal `ggplot()` ou nos layers específicos. O mesmo ocorre para a definição das dimensões com a função `aes()`.


## A camada de geometria {-}

O passo seguinte, depois de definir os dados e as dimensões, é adicionar a geometrias. Iremos discutir geometrias em mais detalhe abaixo, mas por agora, vamos adicionar a mais simples de todas: os pontos.


```r
ggplot(inv, aes(x = CAP_cm, y = H_m)) +
  geom_point()
```

Cada camada é feita por uma função. Algumas não precisarão de argumentos pois será utilizado o *default*. No exemplo anterior, fizemos um gráfico e adicionamos a camada de ponto `geom_point()`, por padrão, serão mostrados pontos pretos e sólidos de tamanho 1.

Caso você queira alterar o formato do ponto, basta especificar no argumento indicado.


```r
ggplot(inv, aes(x = CAP_cm, y = H_m)) +
  geom_point(shape = 2)
```

Ou, se quiséssemos usar pontos vermelhos e maiores, poderíamos definir:


```r
ggplot(inv, aes(x = CAP_cm, y = H_m)) +
  geom_point(color = "red", size = 3)
```

Como padrão, o ggplot2 cria um fundo cinza e linhas de grades brancas. Tem uma explicação plausível para isso e na maioria das vezes é bem útil, mas de forma geral não estamos acostumados a esse tema e isso pode incomodar. Mas fique tranquilo, isso é perfeitamente ajustável, vamos ver a seguir como fazê-lo.

Outro padrão é o nome dos eixos. Ele é correspondente à variável indicada, mas também pode ser alterado utilizando a função `labs`.

Finalmente, note que nós não precisamos dizer em `geom_point()` quais são as dimensões do gráfico. Já fizemos isso na função principal. Os layer herdam essas definições da função principal e por isso não precisamos ficar redefinindo a todo momento.


## A camada de estatísticas {-}

Adicionar uma linha de tendência uma suavização é muito simples, veja o exemplo.


```r
ggplot(inv, aes(x = CAP_cm, y = H_m)) +
  geom_smooth(method = "lm")
```

Nesse gráfico, foi ajustado uma regressão linear com um intervalo de confiança de 95%.

Uma coisa importante a entender é que não é necessário incluir os pontos, podemos apresentar somente a linha de tendência.


```r
ggplot(inv, aes(x = CAP_cm, y = H_m)) +
  geom_smooth(method = "lm")
```


## Edições de eixos {-}

Podemos alterar o nome dos eixos e ainda adicionar título, subtítulo e fonte ao gráfico.


```r
ggplot(inv, aes(x = CAP_cm, y = H_m)) + 
  geom_smooth(method = "lm") +
  labs(
    title = "TUME 134",
    subtitle = "Faz. Areão",
    caption = "Projeto TUME",
    x = "CAP (cm)",
    y = "Altura (m)"
  ) +
  theme_bw()
```


## Aesthetics {-}

No ggplot2, *aesthetic* são os elementos gráficos que representam as dimensões dos dados, e que são definidos com `aes()`. Em certa medida, a dimensão que você precisa para definir depende das geometrias que você deseja utilizar. Por exemplo, segmentos de linha tem propriedades geométricas diferentes de pontos. Mas de maneira geral, essa padronização não é problemática.

* **x**: localização do eixo-X.
* **y**:  localização do eixo y.
* **color**: A cor das linhas, pontos, e as fronteiras externas das geometrias (polígonos, barras, etc.).
* **fill** : A cor de preenchimento das geometrias.
* **size**: O tamanho dos pontos.
* **shape**: Específico para pontos, define a forma dele.
* **linetype**: Específico para linhas, define o tipo de linha, caminho, ou borda de uma geometria.
* **alpha**: Isto define a opacidade de qualquer propriedade geométrica. É mais utilizada quando temos sobreposição de pontos ou linhas e queremos enxergar o que está por de trás.
* **xend**, **yend**: Você vai usá-los raramente, quando criar um segmento de linha, ou seta. O início do segmento de linha será localizado o x e y, e a extremidade do segmento de linha será definida em xend, yend.

Se aplicarmos a dimensão de cor em função da variável `Cod`, vamos notar que o `ggplot2` entendeu que se trata de números e por isso adicionou uma escala contínua de cor na legenda. Não está certo, mas é o default.


```r
ggplot(inv,  aes(x = CAP_cm, y = H_m, color = Cod)) +
  geom_point() 
```

O ggplot2 gerou automaticamente uma paleta de cores para os dados e criou uma legenda. Tal como acontece com tudo, a paleta de cores também é ajustável, o que será discutido em mais detalhe abaixo. O padrão de cores do ggplot2 é bastante inteligente. Cada cor é equidistante em torno de um círculo de cor HSL, e têm igual luminância. A ideia é que nenhuma categoria tenha maior destaque que outra, em contrapartida ela pode ser um problema para leitores daltônicos.


```r
ggplot(inv,  aes(x = CAP_cm, y = H_m)) +
  geom_point(color = "red") 
```


Neste momento você pode notar a diferença de indicar a cor fora do `aes()` não gera legenda e se aplica a todos os pontos. Quando a cor representa uma dimensão dos nossos dados, seja uma escala discreta ou contínua, ela deve ser indicada dentro da função `aes()` em conjunto com a variável que definirá a dimensão.


## Grupos {-}

Vamos criar um gráfico com uma linha de tendência por ano. O parâmetro `se = FALSE` é para retirar o intervalo de confiança da linha de tendência e facilita a visualização.


```r
ggplot(inv, aes(x = CAP_cm, y = H_m, color = Esp)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
```

Como a dimensão cor foi definida na função principal, todos layers herdaram essa informação. Mas e se quisermos um gráfico com pontos coloridos, mas só uma linha de tendência? Simples, vamos dar a dimensão de cor somente para o layer de pontos.


```r
ggplot(inv, aes(x = CAP_cm, y = H_m)) +
  geom_point(aes(color = Esp)) +
  geom_smooth(method = "lm")
```

É importante lembrar que não é só a dimensão de cor que gera sub-agrupamentos no gráfico. Se utilizarmos a forma para diferenciar a variável, essa definição também será herdade nos layers subsequentes.


```r
ggplot(inv, aes(x = CAP_cm, y = H_m, shape = Esp)) +
  geom_point()
```

A criação de gráficos com cores é uma atividade comum em muitas situações. Podemos definir se um gráfico será colorido de duas formas, o preenchimento interno da geometria ou a linha externa. Para o primeiro, utilizamos o argumento `fill = <variável>`e para o segundo `color = <variável>`. Note que as variáveis podem ser contínuas ou discretas para ambos os casos.


```r
resumo_clone <- inv %>% 
  group_by(Esp) %>%
  summarise(
    H_m = mean(H_m, na.rm = TRUE),
    CAP_cm = mean(CAP_cm, na.rm = TRUE),
    n_arv = n(),
    n_falha = sum(ifelse(Cod == 1, 1, 0), na.rm = TRUE),
    p_alha = (n_falha / n_arv) * 100
  )

ggplot(resumo_clone, aes(Esp, CAP_cm)) +
  geom_col()
```

Se quisermos colorir as barras, o primeiro instinto seria provavelmente para definir `color = Esp`. Mas este argumento considera apenas o contorno das figuras bidimensionais.


```r
ggplot(resumo_clone, aes(Esp, CAP_cm, color = Esp)) +
  geom_col()
```

O preenchimento é feito utilizando o argumento `fill = Esp`.


```r
ggplot(resumo_clone, aes(Esp, CAP_cm, fill = Esp)) +
  geom_col()
```


## Geometrias {-}

Até o momento, nós usamos as seguintes geometrias:

*  geom_point()
*  geom_smooth()
*  geom_col()

Todas as geometrias começam com `geom_*`, esta é a lista completa das geometrias disponível pelo ggplot2.


```r
apropos("^geom_")
```

Esta é uma lista bastante extensa, e não iremos ver todo seu conteúdo hoje. Mas podemos iremos exemplificar alguns casos.


### Histograma e Densidade {-}

O histograma é um gráfico univariado bastante comum no meio científico. Sua principal função é apresentar a distribuição de frequências dos dados.


```r
ggplot(inv, aes(CAP_cm)) +
  geom_histogram()
```

Também é possível considerar a distribuição dos Clones de maneira independente e adicionar uma transparência às barras.


```r
ggplot(inv, aes(CAP_cm, fill = Esp)) +
  geom_histogram(position = "identity", alpha = 0.5)
```


### Densidade {-}

Visualizar a distribuição de frequências também é um recurso muito interessante para entender os nossos dados. Podemos fazê-lo através de um histograma eu de gráfico de densidade de frequências.


```r
ggplot(inv, aes(H_m)) +
  geom_density()
```

Podemos identificar a distribuição do Esp através de cores.


```r
ggplot(inv, aes(H_m, fill = Esp)) +
  geom_density()
```

Entretanto o padrão da função `geom_density()` é usar `position = "identity"`. Isso significa que pode haver (como de fato acontece) sobreposição das curvas. Uma alternativa rápida é colocar opacidade ao preenchimento para poder ver através das curvas.


```r
ggplot(inv, aes(H_m, fill = Esp, color = Esp)) +
  geom_density(alpha = 0.3)
```

Caso o interesse seja ver a contribuição de cada sexo para a distribuição total do peso, iremos trabalhar com o parâmetro `position = "stack"`


```r
ggplot(inv, aes(H_m, fill = Esp, color = Esp)) +
  geom_density(position = "stack")
```

A próxima variação é tratar os valores em porcentagem, do mesmo modo que fizemos com as barras.


```r
ggplot(inv, aes(H_m, fill = Esp, color = Esp)) +
  geom_density(position = "fill")
```


### Boxplot {-}

O boxplot é um gráfico muito útil para demonstrar a distribuição dos dados. Seu objetivo é evidenciar os quartis e outliers.


```r
ggplot(inv, aes(Esp, H_m)) +
  geom_boxplot()
```

Entretanto não vemos os pontos e muitas vezes o gráfico pode nos enganar pois não vemos quantos pontos cada fator tem de verdade. Como alternativa a isto, podemos plotar os pontos em conjunto.


```r
ggplot(inv, aes(Esp, H_m)) +
  geom_boxplot() +
  geom_point()
```

Entretanto, mais uma vez o gráfico pode nos enganar pois a sobreposição dos pontos esconde a verdadeira quantidade. A alternativa para esta situação é utilizar a função `jitter()`, que adiciona uma variação aleatória aos pontos transformando-os em uma massa de pontos. Para não haver duplicidades nos outliers, podemos retirara-los do boxplot.


```r
ggplot(inv, aes(Esp, H_m)) +
  geom_boxplot(outlier.color = NA) +
  geom_jitter(
    width = 0.1,
    alpha = 0.5
  )
```


### Vilolin e dotplot {-}

Para os que não gostam ou não entendem o boxplot, uma alternativa de gráfico que expressa a mesma ideia é o violin plot. O gráfico consiste em uma curva de densidade simétrica para cada fator.


```r
ggplot(inv, aes(Esp, CAP_cm)) +
  geom_violin()
```

Podemos ainda adicionar os pontos para ter uma noção de quantidade.


```r
ggplot(inv, aes(Esp, CAP_cm)) +
  geom_violin() +
  geom_jitter(alpha = 0.3, width = 0.1)
```

Entretanto, o mais indicado é combinar o violin plot com o dot plot e assim evidenciar claramente a distribuição de frequência com uma curva de suavização.


```r
ggplot(inv, aes(Esp, CAP_cm)) +
  geom_violin() +
  geom_dotplot(
    binaxis="y",
    stackdir="center",
    dotsize = 1
  )
```


### Barras {-}

Para demonstrar como os diferentes tipos de agrupamento de barras funcionam, vamos criar um gráfico que possui contagem de diferentes categorias por fator.


```r
ggplot(resumo_clone, aes(Esp, CAP_cm)) +
  geom_col()
```

Podemos adicionar a dimensão de color para verificar a diferença nos dado


```r
resumo_clone %>% 
  ggplot(aes(Esp, CAP_cm, fill = n_falha)) +
    geom_col()
```


### Texto {-}

Adição de texto e rótulos ao gráfico em forma de geometria. Caso queira inserir uma anotação, utiliza `annotate()`. Uma questão especial Há uma estético especial apenas para `geom_text()` ou `geom_label()` chamadas label, que define a coluna que deve ser utilizada como marcador de texto.


```r
ggplot(inv, aes(CAP_cm, H_m, label = Cod)) +
    geom_point() +
    geom_label() +
    annotate("text", 70, 10, label = "Este é um comentário")
```


## Escalas {-}

Todos os tipos de escala (eixos x e y, cor, preenchimento e tamanho) tem funções específicas de controle e podem ser totalmente customizadas.

Os eixos, por exemplo, são modificados pelas funções com o prefixo `scale_[x|y]_**()`.


```r
apropos("^scale_x_")
```

`scale_x_continuous`, `scale_x_discrete`, `scale_x_datetime` e `scale_x_date` são os tipos básicos de eixos x e y que você pode modificar no ggplot2. `scale_x_log10`, `scale_x_sqrt` e `scale_x_reverse` são transformações básicas para uma escala contínua. Também veremos como criar nossa nossa sequência para composição de eixos.

Existem alguns argumentos básicos par as funções relacionadas às escalas numéricas.

*  **name**: Nome do eixo ou título da legenda.
*  **limits**: Define o intervalo que os dados serão apresentados no gráfico.
*  **breaks**: Marcadores dos eixos ou da legenda.
*  **labels**: Rótulos dos marcadores.


## scale_x|y_continuous {-}

O ggplot2 determina uma escala e limite padrão para os gráficos de acordo com a escala de variação. Às vezes, queremos maior detalhe da escala e por isso temos que modificar os argumentos.


```r
ggplot(inv, aes(CAP_cm, H_m)) +
  geom_point()
```

A alteração dos `breacks` é feita por um vetor que indica onde será adicionado o marcador do eixo.


```r
ggplot(inv, aes(CAP_cm, H_m)) +
  geom_point() +
  scale_x_continuous(breaks = seq(0, 90, 2))
```

Caso seja interessante altera o rotulo do marcador, temos que criar um novo vetor que contem os nomes.


```r
ggplot(inv, aes(CAP_cm, H_m)) +
  geom_point() +
  scale_x_continuous(breaks = seq(0, 90, 10), labels = paste(seq(0, 90, 10), "cm"))
```


## Escalas de cor {-}

A paleta de cor é um ponto crítico em um gráfico. Muitas vezes utilizamos a dimensão de cor para comparar algo e por este motivo devemos escolher com cuidado as cores que iremos colocar. O ggplot2 disponibiliza algumas paletas e funções à nossa disposição. Vocês podem pesquisar cada uma delas mais tarde e ver qual o diferencial que cada uma trás.


```r
apropos("^scale_color_")
```

A característica básica é que existem funções para variáveis discretas e funções para variais contínuas. Para variáveis discretas, por exemplo, a função padrão é a `scale_[fill|color]_hue()`.


```r
ggplot(inv, aes(CAP_cm, H_m, color = Esp)) +
  geom_point() +
  scale_fill_hue()
```

O pacote `RColorBrewer` disponibiliza um conjunto de paletas que podem ser incorporadas no ggplot2. basta identificar qual você deseja. Há paletas sequenciais e paletas divergentes.
Caso queria ver as paletas, explore pelo comando `RColorBrewer::display.brewer.all()`. No gráfico, basta indicar o nome da paleta no argumento `palette`.


```r
ggplot(inv, aes(CAP_cm, H_m, color = Esp)) +
  geom_point() +
  scale_color_brewer(palette = "Set1")
```

Caso você queria colocar suas próprias cores, terá de fazer isso manualmente. Eu recomendo o site http://colorbrewer2.org/. A partir do código hexadecimal, podemos colocar as cores que queremos com a função `scale_[color|fill]_manual()`.


```r
ggplot(inv, aes(CAP_cm, H_m, color = Esp)) +
  geom_point() +
  scale_color_manual(values = c("red", "blue", "darkgreen", "gold", "cyan", "#fc9272", "#4a1486"))
```

Se for preciso economizar na impressão e colocar o gráfico em escala de cinza, sem problema, temos uma função pronta para isto.


```r
ggplot(inv, aes(CAP_cm, H_m, color = Esp)) +
  geom_point() +
  scale_color_grey()
```


## Facets {-}

Talvez o recuso mais interessante do R e ggplot2 no contexto de gráficos exploratórios seja a possibilidade (e facilidade) de criar gráficos em painéis. Esse pode ser feito em outros softwares, mas o ggplot2 oferece uma gama de funcionalidades relacionadas a este tema.


```r
ggplot(inv, aes(CAP_cm, H_m, color = Esp)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~Esp) +
  scale_color_brewer(palette = "Dark2")
```
