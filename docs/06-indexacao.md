
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