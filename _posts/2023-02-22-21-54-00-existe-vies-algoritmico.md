---
title: Existe "Viés Algorítmico"?
published: true
permalink: /posts/existe-vies-algoritmico
description: 
tags: [Algoritmos, Tecnologia, Jacques Ellul, Sociedade]
series: A Sociedade Tecnológica no Século XXI
cover_image: /assets/images/narciso-100-42.webp
publish_date: 2023-02-22 21:21:00 +0300
---

Em pleno carnaval de 2023 surge um tema polemico no Twitter. E como a comunidade do Twitter é muito madura sabendo discutir com argumentos embasados, os especialistas de Viés Algorítmico e Deep Learning foram consultaados para emitirem opiniões e explanarem sobre os estudos no tema.

Se você não percebeu a ironia no parágrafo anterior é bom treinar um modelo de Deep Learning para detecção de ironia, porque seu modelo interno está péssimo.

Voltando ao tema, realmente surgiu uma polemica se Inteligência Artificial, ou sendo mais especifico Algoritmos de Machine Learning tem ou não vieses. Eu acabei omitindo a minha opinião e nesse artigo vou me alongar mais sobre o porque eu creio que Machine Learning é por design baseado em viés.

## Definindo Viés

Não podemos discutir viés algorítmico sem antes entender o que é viés. Ao tentar procurar alguma publicação sobre o tema, encontrei no site do Núcleo de Estudos da Violência da USP (NEV-USP) um levantamento bibliográfico [Viés algorítmico – um balanço provisório](https://nev.prp.usp.br/publicacao/vies-algoritmico-um-balanco-provisorio/).

Nesse levantamento tive uma grande surpresa ao perceber que esse tema é mais falado na Sociologia (12,3%) e no Direito (27,9%) do que na Computação (7,4%). Dessas publicações, a grande maioria são ensaios (74,4%) tendo pouca pesquisa empirica e pouco embasamento teorico.

A busca por uma definição do que é um "viés algorítmico" também é neglicenciada pois nenhum dos artigos encontrados propõe uma definição. Uma das definições de víes é encontrada em [Algorithmic decision-making in AVs: Understanding ethical and technical concerns for smart cities](https://arxiv.org/abs/1910.13122) "_Um sistema é considerado enviesado quando contém características 'intencionais' ou 'não intencionais' que discriminam injustamente certos indivíduos ou grupos de indivíduos na sociedade_"

Já outros autores vão defender que o viés algorítmico é quando há uma distorção de dados, algoritmos e resultados de acordo com uma realidade social pré-existente. O que isso significa? Que já existe um problema social e através da construção de modelos eles são ressaltados.

No levantamento, as causas apontadas para o viés algorítmico são a estrutura social, os dados enviesados, a construção da ferramenta/modelo e a interpretação dos resultados.

## Entendendo _Machine Learning_

Agora que compreendemos o que é viés e o que é viés algorítmico, vou tentar explicar como funciona um modelo de Machine Learning e como ele se relaciona com o algoritmo em si.

Inteligência Artificial é um campo da computação muito rico, ela via tentar emular a inteligência humana em sistemas que apresentam uma forma de raciocínio ou buscam soluções de forma eficiente. Os algoritmos de IA podem ser classificados em vários tipos, chamarei aqui de IA Clássica todo algoritmo que racionaliza a estrutura do problema para buscar uma solução. Por exemplo, quando implementamos uma IA para jogar xadres, podemos implementar o [algoritmo Minimax](https://pt.wikipedia.org/wiki/Minimax) que é uma busca em uma árvore de possibilidades tentando maximizar a pontuação de um jogador pressuponto que o outro jogador vai também tentar maximizar a sua pontuação.

![Desenho de uma árvore gerada pelo algoritmo Minimax](/assets/images/minimax.gif)

Quer ver uma implementação do Minimax? Tenta jogar a [minha versão do jogo da velha em Scala](https://github.com/vepo/tic-tac-toe/).

Já os algoritmos de Machine Learning em sua grande maioria vão tentar resolver problemas taxonômicos. São algoritmos que vão tentar fazer identificações baseados em features. Uma feature é uma caracteristica do objeto desejado. O exemplo mais clássico é a classificação de um algoritmo para identificação da flor Iris entre Iris Setosa, Iris Versicolour ou Iris Virginica. Já existe um [dataset composto com a largura e tamanho da pétala e da sépala e a respectiva classificação](https://archive.ics.uci.edu/ml/datasets/iris) e baseado nele é possível construir um sistema para identificação de qualquer flor desse tipo.

Durante alguns anos da minha vida eu construi sistemas de reconhecimento de fala e sintese de voz baseado em algoritmos de Machine Learning usando [Hidden Markov Models](https://cmusphinx.github.io/wiki/tutorialconcepts/). Esses algoritmos são um pouco diferentes dos de identificação, mas ainda são algoritmos de identificação, pois reconhecer um trecho de fala é identificar fonemas e transcrever esses fonemas nas palavras corretas.

Por fim temos os algoritmos de Deep Learning que são baseados em Redes Neurais. Uma rede neural é baseada na ideia do Perceptron. O perceptron é uma estrutura que permite a criação de uma função para transformação de dados inpirado no neuronio. Um neuronio recebe vários sinais eletricos de suas sinapses e produz um novo sinal que é uma função de todas as entradas. Um perceptron seria composto por um conjunto de entradas, uma função de transformação e um conjunto de parâmetros.

![Desenho esquemático do Perceptron](/assets/images/perceptron.webp)

Para que o perceptron tenha uma utilidade, ele precisa ser treinado para que os parâmetros sejam escolhidos. Por muitos anos esse treinamento não era fácil pela ausência de um bom método, mas em 1986 foi proposto o algoritmo _Backpropagation_ que possibilitou o treinamento de uma rede neural composta de várias camadas de perceptrons alinhados.

![Desenho esquemático do Backpropagation](/assets/images/backpropagation.webp)

Então quando falamos de _Deep Laerning_ temos uma base de dados que alimentará uma rede neural complexa e será treinada para que se encontre uma função de transformação com um erro mínimo. Esse treinamento é a escolha dos coeficientes afim de se reduzir o erro usando Gradiente Descendente e Backpropagation. Caso tenha interesse em ver um código que implementa tudo isso, em 2020, durante um periodo de tédio e ócio e com a necessidade de relembrar como é programar em C++ [eu fiz uma POC de implementar um NN em C++](https://github.com/vepo/cerebro).

Podems então resumir que os algoritmos de _Deep Learning_ são um subconjunto dos algoritmos de _Machine Learning_ que por sua vez é um subconjunto dos algoritmos de Inteligência Artificial. Estamos falando na construção de programas que emulem as carateristicas da inteligência humana, mas esses programas nunca vão ser inteligentes como os humanos.

![Tipos de Redes Neurais](/assets/images/tipos-de-nn.png)

## Pressupostos do _Deep Learning_

O primeiro pressuposto quando vamos falar de qualquer algoritmo de inteligência artificial é que ele emula a inteligência.

Vamos criar uma situação hipotetica que queremos construir uma rede neural para que se identifique se o canídeo em uma foto é um cachorro ou um lobo. O programa não terá uma ideia do que é um lobo, ou do que é um lobo. O programa não terá medo ao ver um lobo ou não se sentirá feliz quando vê a foto de um cachorro brincando. Isso não acontecerá porque programas não tem subjetividade, o programa será apenas um conjunto de parametros que alimentará uma rede neural para construção de uma função que identifica se na foto existe um cachorro ou um lobo.

Ainda no caso do cachorro e do lobo, é possível que o programa faça uma identificação completamente enviesada porque existe uma caracteristica comum aos lobos que é incomum aos cachorros. Lobo é um animal não domesticado, logo é bastante improvavel que um lobo seja fotografado em um ambiente domestico. Já cachorros, em sua maioria, são fotografados em ambientes domesticos ou areas externas, muito raramente em uma floresta.

Quando treinamos uma Rede Neural, não temos o controle de quais parâmetros estão sendo usados fazer a identificação. O ambiente é levado em consideração? Como podemos identificar isso?

Para fazer essa identificação é preciso falsear um resultado, ou seja, eu preciso provar se essa minha ideia é falsa ou verdadeira. Assim, preciso de fotos de cachorros em ambientes selvagens e fotos de lobos em ambientes domésticos. Quais são as taxas de assertividades nessas fotos?

O segundo pressuposto é que todo algoritmo de _Deep Learning_ é uma função de transformação com um erro embutido. Nos estamos sempre falando de dadas sendo transformados e a criação de uma função que capturará a essência dessa transformação mas nunca será realmente fiel.

Quando nós vamos identificar um cachorro, nós sabemos o que é um cachorro. Mas o algoritmo não sabe, ele terá que calcular os parâmetros para minimizar o erro, mas o erro ainda existirá! Logo erro é inerente a qualquer algoritmo de _Deep Learning_. Quando tentamos minimizar demais o erro, encontramos o que é chamado de _overfitting_ o que significa que dentro do teste o erro foi minimizado ao extremo, mas para dados fora do testo o modelo não terá uma taxa de assertividade alta. Já quando o erro não é tão minimizado temos o _underfitting_ que é quando o modelo tem uma alta taxa de erro mesmo durante o treinamento.

O terceiro pressuposto é que estamos falando de identificação de padrões. Qualquer atividade de identificação de padrões será enviesada porque no mundo real não existem padrões. Quando eu falo pra você que tenho um modelo de indentificação de cachorros ou lobos você já conseguiu imagina o que é um cachorro ou um lobo. Seu cachorro será ou um pastor alemão, ou  um labrador, ou um golden retriever ou um vira-lata caramelo. Idependente da imagem que você tem na sua cabeça você acessou o seu [universal](https://pt.wikipedia.org/wiki/Universal_(filosofia)) de cachorro, mas quando você vê um pincher de 3 patar, você continua acreditando que aquilo é um cachorro, mesmo que esse particular seja completamente diferente do universal.

Ao se tentar identificar universais, você está construindo um modelo que intrisecamente tem uma ideia do que é esse universal. Se eu aceito que esse modelo tem um erro estatistico, eu devo aceitar que esse modelo ou aceitará particulares externos ao universal ou não aceitará particulares internos ao universal.

Se voltarmos ao modelo do lobo e do cachorro, pode ser que o modelo identifique um gato domestico como cachorro e um Puli seja ignorado, quem sabe confundido com farrapos.

O quarto pressuposto é que esse modelo fará uma escolha baseada em probabilidade condicional, o que implica que vises sociais podem ser codificados no modelo. Por probabilidade condicional entenda que é uma conclusão logica que pode estar falsa.

Vamos ver o exemplo do lobo e cachorro, se 99% das fotos de lobos eles estão em uma floresta, se eu tenho uma foto de um canídeo em uma floresta eu posso supor que ela seja um lobo? Não! Para que essa carateristica seja minimizada precisamos ter base de dados balanceadas, ou seja, o número de fotos de cachorro dentro de casa, cachorro na floresta, lobo dentro de casa e lobo na floresta devem ser semelhante. Mas é factível ter uma base assim?

## Víes por design

Algoritmos de _Deep Laerning_ são extremamente úteis, mas eles estão codificando padrões usando variáveis que muitas vezes não tem relação com o universal desejado.

Se nós formos nos questionar o que é um ser humano, a resposta não será em forma de uma descrição matemática, mas uma uma descrição repleta de subjetividade.

Os algoritmos de _Deep Learning_ vão tentar encontrar um padrão que não existe e mesmo assim serão sucestível ao erro. É a forma como essa tecnologia foi pensada.

## O que é ChatGPT?

Seundo sua própria documentação, o ChatGPT é [um "Modelo de Linguagem otimizado para o dialogo"](https://openai.com/blog/chatgpt/). Reparou que na descrição não há nenhuma menção a "conhecimento" ou "informação"? Porque a tecnologia GPT não tem uma gestão da informação. 

Um modelo de linguagem é definido no paper [Better Language Models and Their Implications](https://openai.com/blog/better-language-models/) como um modelo que tem como objetivo prever a próxima palavra, dado o conjunto de palavras anteriores. O que isso quer dizer? Voltamos a proabilidade condicional! Se escrevemos uma pergunta, o ChatGPT vai propor uma resposta usando uma função que era qual será a resposta mais provavel. 

Nisso temos que levantar as questões:
1. O texto mais provavél é correto?
2. A base de dados usada para o treinamento é balanceada?
3. Existe a possibilidade de ponderação nas respostas?

Quando falamos em ponderação é algo que está se tornando raro nas discussões da internet. Não temos mais a habilidade de levantar pontos possitivos e pontos negativos de uma ideia e ponderar se a ideia é boa ou ruim.

O exemplo mais comum foi quando perguntaram qual foi o papel da URSS na segunda guerra mundial. Nos documentos e filmes sabemos que a URSS foi crucial para destruir a Alemanha. Hitler tinha odiava comunistas e socialistas e esse era um ponto tão crucial na sua ideologia que investiu por meses tentando destruir Stalingrado. Foi a URSS que chegou com as tropas em Berlin para tomar o poder, mas circulou vários prints em que essa informação hora era apresentada como verdadeira e hora era apresentada a versão que os EUA tinham tomado Berlin.

Essa versão que os EUA tomaram Berlin é tão comum nos EUA que foi até ironizada pelo Clint Eastwood no filme [15h17 - Trem para Paris](https://www.papodecinema.com.br/filmes/15h17-trem-para-paris/)

Podemos então concluir que o ChatGPT tem o compromisso de tentar soar como um texto fluido em que as ideias sejam realmente apresentadas e verossímeis, mas ele não tem compromisso que essas ideias sejam verdadeiras. Ele não foi desenhado pra isso e isso está na documentação e nos papers apresentados no site da OpenIA.

## IA como commodity

Qualquer algoritmo de IA é um algoritmo que pode ser reimplementado, mas as Big Techs tentam vender IA como uma commiditie. Apesar de ser muito dificil de replicar esses algoritmos, eles são frutos de anos de investimento em pesquisa e inovação e muito dos estudos que poossibilitaram a contrução deles estão aí a nossa disposição.

Pode não ser fácil entender como funciona um algoritmo complexo, mas vale a pena ler o artigo que descreve esse algoritmo. Ele trará luz ao metodo de funcionamento e as limitações do algoritmo. Toda publicação academica faz uma analise completa levantando inclusive os defeitos encontrados para que sejam endereçado em pesquisas futuras.

Treine a sua capacidade de leitura e investigação.

## Qual deve ser nossa postura quando vemos uma nova tecnologia?

Para concluir eu os clamo a se questionarem qual é a nossa postura quando vemos uma nova tecnologia. Somos um fã de tecnologia sempre ansiando pelo que tem de novo e acreditando que aquela é a solução de todos os nossos problemas? Ou somos céticos fazendo questionamentos criticos e validando a documentação existente?

Tecnologias promente resolver problemas, mas elas também podem criar problemas. Hoje nós temos uma possibilidade infinita de coisas que podem ser feitas a ponto de não podermo acreditar na própria realidade. Podemos construir vídeos com _Deep Fake_ que nunca foram gravados. Quais são as implicações éticas disso?

A culpa dessa postura está no jornalismo tecnológico que se presta a ser uma assessoria de impresa das grandes empresas de tecnologia e não usam o sua capacidade de criticar aquilo que é óbvio.
