---
title: Algoritmos - Uma introdução
permalink: /posts/algoritmos-uma-introducao
published: true
description: O que é um algoritmo? O que define um algoritmo?
tags: [Algoritmo, Ciência da Computação]
cover_image: /assets/images/pexels-artem-beliaikin-5456314.jpg
series: Algoritmos
publish_date: 2022-06-10 12:47:30 +0300
---

> _A NOÇÃO de um algoritmo é básica para toda a programação de computadores._ 
> Donald E. Knuth

Mesmo que você não se importe com algoritmos, se você programa em qualquer linguagem, você usa, produz e lê algoritmos. Talvez você não saiba definir o que é um algoritmo, ou talvez você tenha uma ideia errada do que é. Mas é uma ideia básica para todo programa, tanto que foram com as palavras acima que Donald E. Knuth decidiu abrir seu livro **The Art of Computer Programming**. 

Antes de falar em algoritmos, vamos tentar entender o que é uma linguagem de programação? 

# O que é um computador?

Devemos considerar computadores como máquinas extremamente burras. Ao contrário do senso comum, os computadores não avançaram nos últimos 40 anos, todos eles seguem a mesma arquitetura de lê uma instrução, executar a instrução e lê a instrução seguinte. Essas instruções vão alterar valores na memória, ou em registradores, que podem alterar o fluxo do programa. Todo avanço que tivemos foi na velocidade de processamento dessas instruções, na quantidade de memória disponível e na velocidade de comunicação entre computadores.

Essas instruções são armazenadas na memória em algo chamado linguagem de máquina que são dados binários. A geração desse binário é feita a partir de uma linguagem possível de ser compreendida pelo ser humano. É aí que entra uma linguagem de programação.

Uma Linguagem de Programação é capaz de expressar algoritmos que são traduzidos para linguagem de máquina em que computadores podem o entender. É preciso fazer uma diferente entre Linguagem de Programação, Linguagem de Definição de Interface (IDL) e Linguagem de Apresentação. Existem algumas linguagens no contexto do desenvolvimento de software que não viram programas, mas são usadas por programas para outros propósitos, como é o caso do HTML, CSS e algumas IDLs como gRPC. Nenhuma dessas linguagens é transformada em código executável e não é possível definir um algoritmo nelas. Isso não implica que elas não tenham algoritmos próprios, o CSS por exemplo tem um algoritmo para aplicação de estilo. 🤓

Uma linguagem de programação sempre será de dois tipos, ou ela é declarativa ou imperativa. Uma Linguagem Declarativa é usada para declarar qual a forma que um problema deve ser resolvido, essas linguagens são em muitos casos funcionais (LISP, Erlang ou Haskell). SQL e HTML também são consideradas linguagens declarativas para problemas específicos como consulta a base de dados e criação de telas, respectivamente.

# Definindo Algoritmos

O [Dicionário Oxford](https://www.oxfordlearnersdictionaries.com/definition/english/algorithm) define algoritmo como:

> Um conjunto de regras que devem ser seguidas para resolver um problema em particular.

Qualquer programa de computador é desenvolvido para resolver um problema. _Ou para criar um problema... sem estresse_ 😉

Mas um programa **DEVE** segui uma receita, isto é, o seu algoritmo. Isto é onipresente em qualquer sistema computacional e nenhum programa consegue fugir do seu algoritmo. É importante entender isso até para desmentir algumas péssimas matérias que tentam passar a ideia que estamos perto de alcançar a singularidade, isto é, o momento que computadores serão superior ao seres humanos podendo inclusive se reprogramar. Algum tempo atrás saiu uma matéria dizendo que a Meta havia desligado uma IA porque ela estava criando uma linguagem nova, isso é uma mentira contada usando fatos. O que, provavelmente, aconteceu foi que a IA se degenerou mais rapidamente do que se imaginava e por isso o experimento foi terminado. O experimento não terminou por medo de se criar uma nova _Skynet_, mas porque se decidiu não investir mais tempo em tentar criar um chatbot autônomo. No fim, o chatbot estava fazendo exatamente aquilo para qual ele foi desenvolvido, ele não saiu do conjunto de regras para o qual foi desenvolvido. **Todo programa respeita o seu algoritmo, o que acontece é que ou o algoritmo está errado ou há um erro na implementação dele**.

![Noticia falsa "Facebook desliga inteligência artificial que criou sua própria linguagem"](/assets/images/fakes/facebook-desliga-ia.PNG)

A origem do termo algoritmo é incerta, alguns acreditam que ela descende do termo antigo _algorismo_ que significa **o processo de fazer aritmética usando algarismos arábicos**. Durante a idade médica, os cálculos eram feitos através de ábacos usando algoritmos. Na Renascença esse termo foi colocado em dúvida porque alguns linguistas consideraram ele a junção de _algiros_ (doloroso) + _arithmos_ (números). Mas também pode vir do nome do autor _Abu Abdalá Maomé ibne Muça ibne Alcuarismi_ que escreveu [**Livro da Restauração e do Balanceamento**](https://pt.wikipedia.org/wiki/Livro_da_Restaura%C3%A7%C3%A3o_e_do_Balanceamento). Essa foi a primeira obra a reunir algoritmos para resolução de um conjunto de problemas, e o nome algoritmo deriva da pronuncia do nome do autor _al-Khwarizmi_.

![Capa do Livro da Restauração e do Balanceamento](/assets/images/books/algoritmo-livro-arabe.jpg)

Durante o tempo, o termo árabe se degenerou e acabou misturado com um termo grego que tem sua raiz em aritmética. Por volta de 1950 o termo algoritmo era facilmente associado ao Algoritmo de Euclides, que é o processo matemático para se encontrar o máximo divisor comum de dois inteiros.

```
Algoritmo E (Algoritmo de Euclides). Dado dois inteiros positivos m e n, encontre seu maior divisor comum, isto é, o maior inteiro positivo que divide tanto m e n.

E1. [Encontrar resto] Divida m por n e assuma r como o resto da divisão. (0 ≤ r < n)
E2. [Igual a zero?]   Se r = 0, o algoritmo termina; n é a resposta
e3. [Reduz]           Assuma m ← n, n ← r, e volte para o passo E1.
```

# Características de um algoritmo

Um algoritmo é uma receita, mas receitas de bolo não são algoritmos. Porque? A resposta é simples e já falamos dela quando descrevemos um computador. Você consegue entender uma receita de bolo, mas um computador não consegue entender. Você é infinitamente mais esperto que um computador.

Para que um conjunto de passos seja um algoritmo, ele deve ter as seguintes características: 

1. Finitude
2. Definitividade
3. Entrada
4. Saída
5. Eficácia

## 1. Finitude

Um algoritmo **DEVE** sempre terminar depois de um conjunto finito de passos.

Existem algoritmos que buscam indefinitivamente por um valor ótimo. Mesmos esses algoritmos devem terminar depois de um número finito de interações ou ao encontrar um **valor estável**. Esse é o caso do algoritmo de treinamento de redes neurais, o algoritmo não está buscando por uma valor exato, mas por um valor aproximado baseado na entrada.

## 2. Definitividade

Cada passo de um algoritmo **DEVE** ser precisamente definido.

Você pode fazer 

Você pode fazer suposições sobre algo que lê, mas um computador não pode fazer suposições. Cada passo deve ser preciso.

[![Tirinha do site monkeyuser.com chamada "Determinism", na descrição o site usa "As suposições são a mãe de todas as merdas!"](/assets/images/monkeyuser/148-determinism.png)](https://www.monkeyuser.com/2019/determinism/)

Volte para o **Algoritmo E** e procure espaços para duvida nos passos, se houver qualquer dúvida o algoritmo não pode ser implementado ou mesmo executado manualmente. 

## 3. Entrada

Um algoritmo tem dados de entrada, eles são parte da definição do algoritmos. No caso do **Algoritmo E** são os números inteiros `m` e `n`.

## 4. Output

Um algoritmo tem dados de saída, eles são parte da definição do algoritmos. No caso do **Algoritmo E** é o valor do máximo divisor comum de `m` e `n`.

## 5. Eficácia

Todos os passos precisam ser efetivos, isto significa que devem ser simples o suficiente para serem executados sem nenhum outro conhecimento. Passos complexos podem ser encapsulados em algoritmos, por exemplo, se um outro algoritmo precisar encontrar o máximo divisor comum de dois números, este pode ser encapsulado através de um passo simples `mdc ← E(m, n)`, onde `E(m, n)` significa a execução do **Algoritmo E**.

# Notação

Para escrever um algoritmo, precisamos:

* **Passos numerados**: Devemos poder nos referir aos passos
* **Pseudocódigo**: Devemos ser capazes de traduzir o algoritmo em qualquer linguagem de programação
* **Dados de entrada**
* **Dados de saída**
* **Atribuições**: Representa quando uma variável assume um novo valor. Normalmente usamos a notação `x ← y`onde significa que `x` será atribuído o valor de `y`.

No **Algoritmo E** temos todas essas características.

# Ordenando um array

Como podemos ordenar um array? Existe uma série de algoritmos que são bastante estudados, o mais simples dele é o [_Selection sort_](https://pt.wikipedia.org/wiki/Selection_sort) que consiste basicamente de selecionar cada posição a partir do inicio do array e procurar o menor valor nas posições seguintes. Abaixo definimos ele como **Selection Sort**.

```
Dado:
    v    → O array de entrada contendo números inteiros
    n    → O tamanho de v
    x[i] → O valor armazenada na posição i do array x

INICIO:
  S1: PARA CADA i EM [0, n - 2]:
  S2:   min_index ← i
  S3:   PARA CADA j EM [i + 1, n - 1]:
  S4:     SE v[j] < v[min_index]?
  S5:       min_index ← j
  S6:   SE v[i] != v[min_index]?
  S7:     aux ← v[min_index]
  S8:     v[min_index] ← v[i]
  S9:     v[i] ← aux
```

Sobre este algoritmo podemos perguntar:

1. **É finito?** Sim, ele irá iterar sobre o array.
2. **É definitivo?** Sim, cada passo pode ser feito sem qualquer suposição.
3. **Qual é a entrada?** A matriz e seu comprimento.
4. **Qual é a saída?** A mesma matriz já que o algoritmo altera os valores de entrada.
5. **É eficaz?** Sim, classificará qualquer array.

## Executando manualmente

Todo algoritmo pode ser executado manualmente, não é fácil mas, ao executar, podemos ver como dos dados são transformados por ele e compreender o seu funcionamento. Abaixo vemos a execução do **Selection Sort** para o vetor `[5, 100, -6, 98, -111, 0]`.

```
DADO: 
  v = [5, 100, -6, 98, -111, 0]
  n = 6

  S1: i ← 0                                v = [5, 100, -6, 98, -111, 0]   min_index = 0   aux = 0
  S2: min_index ← 0                        v = [5, 100, -6, 98, -111, 0]   min_index = 0   aux = 0
  S3: j ← 1                                v = [5, 100, -6, 98, -111, 0]   min_index = 0   aux = 0
  S4: v[1] < v[0] ? (100 < 5)    NO        v = [5, 100, -6, 98, -111, 0]   min_index = 0   aux = 0
  S3: j ← 2                                v = [5, 100, -6, 98, -111, 0]   min_index = 0   aux = 0
  S4: v[2] < v[0] ? (-6 < 5)     YES       v = [5, 100, -6, 98, -111, 0]   min_index = 0   aux = 0
  S5: min_index ← 2                        v = [5, 100, -6, 98, -111, 0]   min_index = 2   aux = 0
  S3: j ← 3                                v = [5, 100, -6, 98, -111, 0]   min_index = 2   aux = 0
  S4: v[3] < v[2] ? (98 < -6)    NO        v = [5, 100, -6, 98, -111, 0]   min_index = 2   aux = 0
  S3: j ← 4                                v = [5, 100, -6, 98, -111, 0]   min_index = 2   aux = 0
  S4: v[4] < v[2] ? (-111 < -6)  YES       v = [5, 100, -6, 98, -111, 0]   min_index = 2   aux = 0
  S5: min_index ← 4                        v = [5, 100, -6, 98, -111, 0]   min_index = 4   aux = 0
  S3: j ← 5                                v = [5, 100, -6, 98, -111, 0]   min_index = 4   aux = 0
  S4: v[5] < v[4] ? (0 < -111)   NO        v = [5, 100, -6, 98, -111, 0]   min_index = 4   aux = 0
  S6: v[0] != v[4] ? (5 != -111) YES       v = [5, 100, -6, 98, -111, 0]   min_index = 4   aux = -111
  S7: aux ← -111                           v = [5, 100, -6, 98, -111, 0]   min_index = 4   aux = -111
  S8: v[4] ← 5                             v = [5, 100, -6, 98, 5, 0]      min_index = 4   aux = -111
  S9: v[0] = -111                          v = [-111, 100, -6, 98, 5, 0]   min_index = 4   aux = -111
  S1: i ← 1                                v = [-111, 100, -6, 98, 5, 0]   min_index = 4   aux = -111
  S2: min_index ← 1                        v = [-111, 100, -6, 98, 5, 0]   min_index = 1   aux = -111
  S3: j ← 2                                v = [-111, 100, -6, 98, 5, 0]   min_index = 1   aux = -111
  S4: v[2] < v[1] ? (-6 < 100)   YES       v = [-111, 100, -6, 98, 5, 0]   min_index = 1   aux = -111
  S5: min_index ← 2                        v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S3: j ← 3                                v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S4: v[3] < v[2] ? (98 < -6)    NO        v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S3: j ← 4                                v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S4: v[4] < v[2] ? (5 < -6)     NO        v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S3: j ← 5                                v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S4: v[5] < v[2] ? (0 < -6)     NO        v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S6: v[1] != v[2] ? (100 != -6) YES       v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S7: aux ← -6                             v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -6
  S8: v[2] ← 100                           v = [-111, 100, 100, 98, 5, 0]  min_index = 2   aux = -6
  S9: v[1] = -6                            v = [-111, -6, 100, 98, 5, 0]   min_index = 2   aux = -6
  S1: i ← 2                                v = [-111, -6, 100, 98, 5, 0]   min_index = 2   aux = -6
  S2: min_index ← 2                        v = [-111, -6, 100, 98, 5, 0]   min_index = 2   aux = -6
  S3: j ← 3                                v = [-111, -6, 100, 98, 5, 0]   min_index = 2   aux = -6
  S4: v[3] < v[2] ? (98 < 100)   NO        v = [-111, -6, 100, 98, 5, 0]   min_index = 2   aux = -6
  S3: j ← 4                                v = [-111, -6, 100, 98, 5, 0]   min_index = 2   aux = -6
  S4: v[4] < v[2] ? (5 < 100)    YES       v = [-111, -6, 100, 98, 5, 0]   min_index = 2   aux = -6
  S5: min_index ← 4                        v = [-111, -6, 100, 98, 5, 0]   min_index = 4   aux = -6
  S3: j ← 5                                v = [-111, -6, 100, 98, 5, 0]   min_index = 4   aux = -6
  S4: v[5] < v[4] ? (0 < 5)      YES       v = [-111, -6, 100, 98, 5, 0]   min_index = 4   aux = -6
  S5: min_index ← 5                        v = [-111, -6, 100, 98, 5, 0]   min_index = 5   aux = -6
  S6: v[2] != v[5] ? (100 != 0)  YES       v = [-111, -6, 100, 98, 5, 0]   min_index = 5   aux = -6
  S7: aux ← 0                              v = [-111, -6, 100, 98, 5, 0]   min_index = 5   aux = 0
  S8: v[5] ← 100                           v = [-111, -6, 100, 98, 5, 100] min_index = 5   aux = 0
  S9: v[2] = 0                             v = [-111, -6, 0, 98, 5, 100]   min_index = 5   aux = 0
  S1: i ← 3                                v = [-111, -6, 0, 98, 5, 100]   min_index = 2   aux = 0
  S2: min_index ← 3                        v = [-111, -6, 0, 98, 5, 100]   min_index = 3   aux = 0
  S3: j ← 4                                v = [-111, -6, 0, 98, 5, 100]   min_index = 3   aux = 0
  S4: v[4] < v[3] ? (5 < 98)     YES       v = [-111, -6, 0, 98, 5, 100]   min_index = 3   aux = 0
  S5: min_index ← 4                        v = [-111, -6, 0, 98, 5, 100]   min_index = 4   aux = 0
  S3: j ← 5                                v = [-111, -6, 0, 98, 5, 100]   min_index = 4   aux = 0
  S4: v[5] < v[4] ? (100 < 5)    NO        v = [-111, -6, 0, 98, 5, 100]   min_index = 4   aux = 0
  S6: v[3] != v[4] ? (98 != 5)   YES       v = [-111, -6, 0, 98, 5, 100]   min_index = 4   aux = 0
  S7: aux ← 5                              v = [-111, -6, 0, 98, 5, 100]   min_index = 5   aux = 5
  S8: v[4] ← 98                            v = [-111, -6, 0, 98, 98, 100]  min_index = 5   aux = 5
  S9: v[3] = 5                             v = [-111, -6, 0, 5, 98, 100]   min_index = 5   aux = 5
  S1: i ← 4                                v = [-111, -6, 0, 5, 98, 100]   min_index = 5   aux = 5
  S2: min_index ← 4                        v = [-111, -6, 0, 5, 98, 100]   min_index = 5   aux = 5
  S3: j ← 5                                v = [-111, -6, 0, 5, 98, 100]   min_index = 5   aux = 5
  S4: v[5] < v[4] ? (100 < 98)   NO        v = [-111, -6, 0, 5, 98, 100]   min_index = 5   aux = 5
```

Como podemos ver, dada a entrada `[5, 100, -6, 98, -111, 0]`, retorna a saída `[-111, -6, 0, 5, 98, 100]`. Portanto, na saída não há valor `v[i]` e `v[j]` onde `i < j` e `v[i] > v[j]`, isso significa que o array está ordenado.

# Conclusão

Agora sabemos o que algoritmos são similares a receitas, mas não são receitas. Se você ver um passo em uma receita dizendo "adicione sal", você vai saber o que fazer, mas um computador não pode fazer nada porque ele não conseguirá definir a quantidade de sal necessária. Ou se houver um passo "deixe no forno até dourar", o computador pode não entender que o forno deve estar ligado e nem quanto tempo é necessário para dourar uma carne.

Receitas são avaliadas pelo seu resultado, se é agradável ao paladar ou não. Já algoritmos são avaliados pelo número de passos que ele tem ou pelos próprios passos. Um algoritmo que executa menos passos até chegar um resultado é mais rápido que outro que executa mais passos, mas um algoritmo que executa menos passo pode em determinados cenários executar mais passos. Quando avaliamos a performance de um algoritmo devemos levar em conta o caso médio, ou quantos passos são necessários para se encontrar uma resposta para um problema de tamanho `n`, temos o contexto de _analise de algoritmos_. Em Análise de Algoritmos, são estudados como os algoritmos performam sob determinadas circunstâncias afim de tentar entender a melhor forma de usar eles.