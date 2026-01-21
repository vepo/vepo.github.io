---
title: Dicas para quem está iniciando na programação
published: true
description: | 
    Um guia prático com dicas essenciais para quem está começando na programação, desde entender o que é programar até escolher a IDE certa e evitar armadilhas comuns. Baseado em anos de experiência e observações de iniciantes nas redes sociais.
tags: [Como aprender a programar, Dicas para iniciantes, Java, Comunidade]
cover_image: /assets/images/capas/criancas-escola.jpg
permalink: /posts/dicas-para-quem-esta-iniciando-na-programacao
publish_date: 2026-01-21 18:44:00 +0300
---

Desde que comecei o meu canal recebo constantemente uma pergunta semelhate: _estou iniciando na programação e preciso de dicas, pode me dar algumas?_ Vou tentar esboçar aqui alguns conselhos que podem te ajudar. A grande maioria delas sugirá da experiência de ver **incautos** reclamando nas redes sociais.

[![Significado da palavra incauto no dicionário. As palavras "desprevenido e ingênuo" estão marcadas em vermelho](/assets/images/incauto.png)](https://www.dicio.com.br/incautos/)

## 1. Entenda o que é programar

Já perdi a conta das vezes que vi pessoas reclamando que o computador não faz aquilo que está programado, ou que "mágicas" acontece. Isso pode até parecer uma mera ingenuidade ou piada, mas vou levar com seriedade para me dar argumento de definir o que é programar.

Programar é definir o passo a passo que um programa deve fazer. Você é quem tem o total controle de tudo que está acontecendo no seu programa. Mas ele pode reagir a condições ou limitações externas. Se algo aconteceu de inesperado, ou você não "programou" ele direito ou algo de "inesperado" para você aconteceu. Lidar com o inesperado é uma habilidade que aprendemos com o tempo, aprendemos a isolar o inesperado para identificar e controlar ele.

Nós, como programadores, temos que ter ciência do que está acontecendo, entender e prever possíveis erros. E quando erros acontecerem precisamos identificar, corrigir os efeitos do erro e atualizar o código para que o erro não aconteça mais.

## 2. Entenda como o seu código é executado

Esse é uma dica que vai economizar muito do seu tempo. Erros acontecem e as vezes os erros acontecem porque seu código não foi executado corretamente, ou você está olhando para a execução de uma versão antiga dela.

É bom sempre entender como seu código é executado. Quais são os passos para transformar aquele arquivo texto em algo que o computador entenda. Computador não entende seu código, ele só entende a linguagem de máquina e é impraticável vocês escrever programas complexos em linguagem de máquina. Por isso muitas pessoas preferem aprender a programar em linguagens de script, ou seja, linguagens que são executadas diretamente do código como python e javascript.

Linguagens como o Java ou C precisam ser compiladas e depois executadas. É um passo um pouco dolorido para quem está aprendendo, mas é recompensador você entender o processo completo. A minha dica é que você faça apenas uma vez e depois escreva um script, quem sabe usando `bash` ou o similar do Windows, para repetir esses passos automáticamente.

Você também pode procurar alguma ferramenta que transforme a linguagem que você está estudando em script. No Java, por exemplo, existe o [JBang](https://www.jbang.dev/). Ou quem sabe algum site que facilita a sua vida criando ferramentas fáceis de executar o código, em uma busca rápida encontrei o [onlinegdb.com](https://www.onlinegdb.com/online_c_compiler) para C e sei do [exercism](https://exercism.org/) que dá suporte a sua linguagem.

Facilite a sua vida e foque no que é pioritário, tente automatizar tudo que é secundário.

## 3. Busque nas redes sociais as comunidades da sua linguagem

Minha próxima dica é construir uma "timeline" na sua rede _anti_-social preferida de pessoas que falam sobre o tema e dão dicas sobre o tema. Procure focar naqueles que realmente dão boas dicas e não naqueles que ficam fazendo piadas o tempo inteiro depreciando a imagem dos outros e das outras linguagens. 

Como exemplo, fiz o exercicio de procurar a comunidade da linguagem C no Brasil. Procurei no Google "comunidade c lang brasil" e achei a página [C & C++ Brasil](https://ccppbrasil.github.io/). Lá tem uma série de blogs que podem ser uma boa ajuda, já procura os autores nas redes sociais e segue eles.

Se alguma dúvida surgir, pergunta pra eles nas redes sociais. 

NOTE: Não siga babaca! Se você viu a pessoa sendo babaca com qualquer pessoa, unfollow é liberdade.

## 4. Procure uma boa IDE

Eu tenho mais de 20 anos programado Java e não sou ninguém sem uma boa IDE. Não vou dizer que eu não conseguiria escrever um programa sem meu VSCode, IntelliJ ou o Eclipse. Conseguiria. Mas eu não conheço todos os métodos da classe [String](https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/lang/String.html) decorado e nem tenho acesso fácil a documentação. Para colocar a referência a classe eu procurei no Google e muito dos métodos que eu sei de cabeça existem desde o Java 4 (está na 25 hoje), tenho uma dificuldade enorme para achar os métodos adicionados nos últimos 10 anos. Logo a IDE é sua melhor amiga!

IDEs são Integrated Development Environment, ou Ambiente de Desenvolvimento Integrado. As pessoas não usam o Word ou o Notepad pra desenvolver, nem o Notepad++. Usam uma IDE e uma IDE com plugins que dão suporte a sua linguagem. Está com uma variável e não conhece a documentação do tiop dela? `CTRL+SPACE` e a lista de métodos que você pode chamar está na mão, isso é o que se chama Code Completion e é infinitamente melhor do que qualquer LLM da vida porque ela vai te dar possibilidades e documentação.

Com a IDE é possível também rodar seu código, de forma fácil. As vezes só aperta no play ▶️ e 💡! Isso também cobre o que falei na dica 2.

## 5. Entenda a estrutura básica da linguagem

Você tem que entender 2 coisas básicas sobre a linguagem que você está aprendendo.

1. Qual o paradigma dela?
2. Quais as estruturas sintaticas dela?

A resposta da primeira pergunta vai te levar em um mundo de possibilidades que definirão a forma que você vai desenvolver. Saber que Java é uma linguagem Orientada a Objetos ou que Elixir é uma linguagem funcional, vai dar uma luz na hora de pensar o que você pode fazer.

Já a segunda pergunta vai te dar uma resposta bem óbvia. Joga "<linguagem> syntax" no Google e veja o resultado. Fiz o experimento e aqui estão as duas primeiras resposta em ordem:

1. `Java syntax`
    1. [W3 Schools: Java Syntax](https://www.w3schools.com/java/java_syntax.asp) ← LEIA ESSE!!!!
    2. [Especificação do Java Chapter 18. Syntax](https://docs.oracle.com/javase/specs/jls/se7/html/jls-18.html) ← Se quiser ir a fundo, depois de 10 anos de experiência, leia esse.
2. `golang syntax`
    1. [W3 Schools: Go Syntax](https://www.w3schools.com/go/go_syntax.php) ← LEIA ESSE!!!!
    2. [Especificação do GO](https://go.dev/ref/spec) ← Se quiser ir a fundo, depois de 10 anos de experiência, leia esse.

De posse de um tutorial sobre a sintaxe, vá experimentado a linguagem, tentando entender cada passo.

## 6. Faça exemplos simples

Existem inúmeros sites com exemplos que podem te ensinar a programar. Abra o [exercism](https://exercism.org/), [codewars.com](https://www.codewars.com/) ou [hackerrank.com](https://www.hackerrank.com/) e vai aprendendo. Não tente fazer um servidor web de inicio, isso só vai fazer você desistir.

Vá no exemplo simples. Comece com o programa que pergunta a sua idade e imprime com uma mensagem bonita. Depois escreva um programa que pergunta um número e imprime o valor do fatorial dele, ou imprime número na sequência fibonacci na posição do número. Depois faça um programa que lê um arquivo e verifica se os `(`, `[` e `{` estão corretamente definidos.

Evite usar a biblioteca da linguagem a principio, vá implementando na mão cada passo. Programar é aprender e aprender envolve desafio. Sem desafio você não vai muito longe não, vai estagnar.

## 7. Livros é bom?

Livros são excelentes, mas é preciso ter calma para escolher um livro bom. Em muitos casos os livros são verborrágicos e estão bem ultrapassados. Evite comprar livros muito caros a principio, a não ser que alguém de confiança tenha te indicado. 

Prefira baixar o livro, quem sabe você não encontra ele por aí.

## 7. Curso é bom?

Também vá com calma! Escolha bem o curso antes de comprar. Existe muito picareta no mercado. Escolha muito bem o curso e a dica que eu te dou é evitar promessas miraculosas e escolher aquele que dá um bom acompanhamento. Se o material do curso só for liberado depois do sétimo dia, cancela!!!! Isso acontece porque não existe material, o vendendor do curso está esperando vencer o prazo de cancelamento do curso para te mostrar que você foi engando.