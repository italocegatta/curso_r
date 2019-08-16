
# Indexação {-}

O R tem muitos operadores de indexação e dominá-los permitirá que você execute facilmente uma operação complexa em qualquer tipo de conjunto de dados. Permite manipular dados de forma muito sucinta.
  
  
## Vetores {-}


```r
x <- c(5.4, 6.2, 7.1, 4.8)
```

Nós podemos indexar valores de um objeto de 4 maneiras. Usando inteiros positivos.


```r
x[1]
x[c(3,1)]
x[c(1, 1)]
x[c(2.1, 2.9)]
```

Usando números inteiros negativos.


```r
x[-1]
x[-c(1, 5)]
```

Usando operadores lógicos.


```r
x[c(TRUE, TRUE, FALSE, FALSE)]
x[x > 3]
x[which(x >3)]
```

Referenciando objetos por seus nomes.


```r
y <- setNames(x, letters[1:4])
y[c("d", "c", "a")]
y[c("a", "a", "a")]
z <- c(abc = 1, def = 2)
z[c("a", "d")]
```
  
  
## Listas {-}

Indexar uma lista funciona exatamente da mesma maneira como subconjunto de um vetor atômico. Indexar uma lista com `[` sempre retornará uma lista: `[[` e `$`, conforme descrito abaixo, permitem que você retire os componentes da lista.


```r
x <- as.list(1:10)
x[1:5]
```

Para extrair elementos individuais dentro de uma lista, use o operador `[[`.


```r
x[[5]]
class(x[[5]])
another_variable <- x[[5]]
```

Ou usando seus nomes.


```r
names(x) <- letters[1:5]
x$a
x[["a"]]
```
  
  
## Matrizes {-}

Uma matriz é um subconjunto com dois argumentos dentro de colchetes simples, `[]`, e separados por uma vírgula. O primeiro argumento especifica as linhas e o segundo as colunas.


```r
a <- matrix(1:9, nrow = 3)
colnames(a) <- c("A", "B", "C")
a[1:2, ]
a[c(T, F, T), c("B", "A")]
a[0, -2]
```


## Data frames {-}


```r
df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
df[df$x == 2, ]
df[c(1, 3), ]
```

Há duas maneiras de selecionar colunas de um data frame, como Como uma lista ou como uma matriz.


```r
df[c("x", "z")]
df[c(1, 3)]
df[, c("x", "z")]
```

Há uma diferença importante se você selecionar uma coluna simples: o subconjunto de matriz simplifica por padrão, o subconjunto de lista não.


```r
df[, "x"]
df["x"]
```


## Exercícios {-}


(@) **Crie um vetor chamado 'y' com os 30 numeros aleatórios. Mostre todos os numeros do vetor e em segue mostre apenas o quinto e o ultimo elemento.**


```
#>  [1] -0.496735894 -0.307230029  1.259041790  1.564497209 -1.537230527
#>  [6] -1.333390731 -0.176819026 -0.234252829  0.280553296 -0.383512630
#> [11] -0.236918034  0.209041392  1.594494569 -0.388472845  0.608257271
#> [16]  0.752073053 -0.741333344  0.207068624 -0.334033498  0.003045311
#> [21] -0.488323772  2.460348506 -2.937698132 -2.197284502  1.191933021
#> [26] -0.822931391 -1.363217219 -0.778130555  0.084509709  0.776105123
#> [1] -1.5372305  0.7761051
```
<br>

(@) **Armazene este data frame `data.frame(a = letters[1:10], b = 10:1)` em um objeto de nome 'x'. Em seguida mostre seu conteúdo.**


```
#>    a  b
#> 1  a 10
#> 2  b  9
#> 3  c  8
#> 4  d  7
#> 5  e  6
#> 6  f  5
#> 7  g  4
#> 8  h  3
#> 9  i  2
#> 10 j  1
```
<br>

(@) **Extraia do data frame 'x' apenas a columa a, de forma que o resultado seja um vetor.**


```
#>  [1] a b c d e f g h i j
#> Levels: a b c d e f g h i j
```
<br>

(@) **Extraia do data frame 'x' todas as linhas que tenham na coluna b um número menor que 7.**


```
#>    a b
#> 5  e 6
#> 6  f 5
#> 7  g 4
#> 8  h 3
#> 9  i 2
#> 10 j 1
```











