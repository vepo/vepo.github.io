---
title: Encapsulando a complexidade
published: true
description: 'Qual é a melhor forma de dar nome a métodos?'
tags: [Design de Código, Orientação a Objetos]
image: /assets/images/ferramentas-chaves-100-42.webp
permalink: /posts/encapsulando-a-complexidade
publish_date: 2024-05-06 23:00:00 +0300
---

Esse post é motivado por um fio do tweet que foi mal interpretado por diversas pessoas. No final 
vou fazer uma analise do texto para defender porque o texto é claro, mas a forma como nos 
acostumamos a ler em redes sociais o deixou confuso.


{% twitter https://twitter.com/vepo/status/1787479135138230777 %}

Com esse tweet a maioria das pessoas interpretou que eu estou defendendo algo que nunca defenderia, 
que o nome de um método tem que ser desatrelado da sua função. Observe a palavra **exatamente** 
posicionada exatamente ali para remover essa má interpretação. 

Mas vamos entender do que estou falando de forma argumentativa?

## _Clean Code_ e más práticas de design

Eu não tenho muitas paixões pelo livro _Clean Code_, todos que me seguem e vêem meus vídeos sabem que 
teço diversas críticas ao livro. Uma dessas críticas é a forma como o autor criar um dualismo entre o
"bom desenvolvedor" que está preocupado em escrever "código limpo" e o "mal desenvolvedor" que por 
escolhas morais escreve código sem se preocupar.

Eu não gosto dessa visão fundamentalista de separar pessoas que estão apenas fazendo seu trabalho, as 
vezes em condições adversas, em bons e maus. Não creio que exista esse dualismo. O que existe é pessoas 
fazendo seu melhor em condições adversas. Já falei que as vezes o desenvolvedor trabalha em condições
adversas?

Bom, desculpe-me pela piada. Mas vamos detalhar melhor essas condições adversas? O código ruim pode surgir 
por diversos motivos:

1. Tempo insuficiente
2. Mudanças de escopo e requisitos
3. Má comunicação
4. Falta de mentoria e suporte para desenolvedores inesperientes
5. Falta de treinamento para desenvolvedores com maior senioridade

Gosto muito de uma frase que uma _Product Owner_ disse em uma das melhores reuniões de review que participei:
_não estamos tentando procurar culpados, estamos tentando aumentar a maturidade do time, creio que o que foi feito,
foi feito da melhor forma possível no momento, mas as decisões dessa reunião podem nos possibilitar entregas melhores_. 
(OK! Não foi assim, ela ficou falando minutos e isso é um resumo).

Outro ponto negativo do _Clean Code_ é a redução de *escolhas de design* a pequenas regras, assim questões subjetivas
se tornam questões objetivas, o que pode facilitar a compreensão, mas se perde o objetivo. Uma dessa regras, e é sobre o
que vamos falar aqui, é que métodos "_devem fazer apenas uma coisa_" e a outra é "_use nomes que revelem seu propósito_".
Ainda na seção sobre nomear métodos, o autor coloca uma série de limitações no ato de nomear que limita ainda mais o nome 
de métodos, a única forma de atender suas **regrinhas** é ser o mais objetivo possível.

## Vá ler código dos outros

Agora, antes de você continuar a ler esse post, peço que pare por 5 minutos e vá ler código Open Source. Ler código e 
comparar o que os outros fizeram, tentar compreender ou memso tentar ver se existia melhor forma de fazer é o caminho
pra se aprender a escrever código compreensível.

Se você não sabe qual código ler, tente abrir o reposótirio do Apache Kafka e dê uma procurada. Eu recomendaria a
classe [`BufferPool`, mais especificamente o método `allocate`](https://github.com/apache/kafka/blob/trunk/clients/src/main/java/org/apache/kafka/clients/producer/internals/BufferPool.java#L111).
Observe que esse método não é pequeno, não faz apenas uma coisa, o nome não diz exatamente o que ele faz e, por fim,
uma das maiores heresias segundo o autor do livro, está cheio de comentários! 😯

{% twitter https://twitter.com/unclebobmartin/status/1730664458437996737 %}

Se você for procurar outras classes, vai ver que esse padrão se segue. Procure outros códigos Open Source, e verá o mesmo padrão. 
Já parou para pensar porque o código Open Source não é um _código limpo_? Seriam os desenvolvedores do Apache Kafka desenvolvedores
malévolos que desejam escrever código ruim?

Agora releia a função `allocate`! Me descreva o que ela faz? 

> _— Primeiro verifica se há memória suficiente. Depois se tiver espaço no buffer, faz o poll. Se não tiver libera memória, podendo
> bloqueiar até ter memória suficiente._

Segundo as regras do _clean code_ esse método deveria se chamar `verificaMemoriaLivreEExecutaPoolOuLiberaMemoria`. Sabe porque ele 
não tem esse nome _verboso_? **Porque essa complexidade é encapsulada no conceito de Buffer.**

## Crie abstrações e encapsule complexidade

O autor do livro "Trabalhando efetivamente com Código Legado", que eu recomendo muito, é bem suscinto a descrever a diferença entre 
Programação Orientada a Objetos e Programação Funcional. Em tradução livre ele diz "orientação a objetos torna código compreensível
ao encapsular as partes móveis. Programação funcional torna código compreensível ao minimizar as partes móveis".

{% twitter https://twitter.com/mfeathers/status/29581296216 %} 

É nessa ideia que vamos focar aqui nesse post: "encapsular as partes móveis". Orientação a Objetos torna código compreensível ao
criar abstrações que controle a complexidade, que limite ela ao contexto de uma classe, um método. Assim, concordo que um método 
deva fazer apenas alguma coisa, mas quando olhado de fora da classe. Ao se abrir uma classe, um método pode fazer diversas operações.

Para isso vamos imaginar um sistema que publique em redes sociais. Cada entrada na base de dados será uma publicação contendo o conteúdo 
e a rede social em questão.

```java
public enum RedeSocial {
    TWITTER,
    INSTAGRAM,
    ORKUT,
    LINKEDIN
}

public enum Status {
    PENDENTE,
    PUBLICADO,
    ERRO
}

public record Post(long id, RedeSocial rede, String conteudo, Status status) {
}
```

Assim, o primeiro desenvolvedor implementará a conexão com o Orkut (sim, é uma piada).

```java
public class Publicador {
    public void run() {
        while(running.get()) {
            posts.find(Status.PENDENTE, 10)  // Tô sendo bonzinho aqui de usar uma API fluente.
                 .forEach(post -> {
                    if (post.rede() == RedeSocial.ORKUT) {
                        postaNoOrkut(post.conteudo());
                        atualizaStatus(post.id(), Status.PUBLICADO);
                    } else {
                        atualizaStatus(post.id(), Status.ERRO);
                    }
                 });

            try {
                Thread.sleep(500);
            } catch(InterruptedException ie) {
                // sabia que essa excessão não é nada de mais?
                // Faça isso que tá bom em 99% das vezes
                Thread.currentThread().interrupt(); 
            }
        }
    }
}
```

Nessa implementação o método `postaNoOrkut` irá realmente fazer apenas uma coisa? Não sei! Pode ser que exista uma autenticação,
que exista uma sessão de usuário e que essa complexidade seja implementada na mesma classe que está executando o loop. Essas são
as **partes móveis**.

Agora em um segundo sprint, um outro desenvolvedor vai implementar a conexão com o LinkedIn. Logo ele segue o mesmo padrão.

```java
public class Publicador {
    public void run() {
        while(running.get()) {
            posts.find(Status.PENDENTE, 10)  // Tô sendo bonzinho aqui de usar uma API fluente.
                 .forEach(post -> {
                    if (post.rede() == RedeSocial.ORKUT) {
                        postaNoOrkut(post.conteudo());
                        atualizaStatus(post.id(), Status.PUBLICADO);
                    } else if(post.rede() == RedeSocial.LINKEDIN) {
                        postaNoLinkedIn(post.conteudo());
                        atualizaStatus(post.id(), Status.PUBLICADO);
                    } else {
                        atualizaStatus(post.id(), Status.ERRO);
                    }
                 });

            try {
                Thread.sleep(500);
            } catch(InterruptedException ie) {
                // sabia que essa excessão não é nada de mais?
                // Faça isso que tá bom em 99% das vezes
                Thread.currentThread().interrupt(); 
            }
        }
    }
}
```

Observe que o método `run` está compreensível, mas a classe `Publicador` pode ter ficado complexa demais. Pois além de conectar
com a base de posts tem que lidar com as complexidades das conexões com o LinkedIn e com o Orkut. Qual é a solução encontrada
pelo desenovedor Clean Code? Criar Helpers!

Porque isso acontece? Porque o clean code enfatiza as regras e não a reflexão. A classe não pode ser grande, os métodos não podem 
ser grandes, mas... onde está o design, o projeto? Não é feita nenhuma discussão sobre o conceito de complexidade, encapsulamento
ou responsabilidades.

[Uma boa definição de complexidade vem do livro A Philosophy of Software Design](https://vepo.substack.com/p/sobre-design-de-software-i), 
nele o autor defince complexidade como algo que surge com 3 sintomas:
* Mudança amplificada
* Carga Cognitiva
* Desconhecidos Desconhecidos

Quando desejamos encapsular complexidades, desejamos reduzir a carga cognitiva e para isso precisamos criar abstrações e interfaces.
Quando criamos funções com nomes que dizem exatamente o que elas estão fazendo, deixamos a carga cognitiva vazar. Por exemplo, ao se 
escolher os nomes `postarNoOrkut` e `postarNoLinkedIn` tornamos duas operações que deveria ser iguais diferentes. Aí o desenvolvedor
não poderá encapsular essa complexidade, criando classes auxiliares para o Orkut e o LinkedIn.

Para resolver esse problema é preciso que o nome da função se limite a interface dela. Se o primeiro desenvolvedor tivesse criado o 
conceito de `Connector` fazendo com que o método apenas carregasse o conector através de um **factory method**. Como ficaria essa solução?

```java
public interface Connector {
    public static Connector create(RedeSocial rede) {
        return switch(rede) {
            ORKUT -> new ConnectorOrkut();
            default -> null;
        }
    }
    void postar(String conteudo);
}

public class Publicador {
    public void run() {
        while(running.get()) {
            posts.find(Status.PENDENTE, 10)  // Tô sendo bonzinho aqui de usar uma API fluente.
                 .forEach(post -> {
                    try(var connector = Connector.create(post.rede())) {
                    if (connector != null) {
                        connector.postar(post.conteudo());
                    } else {
                        posts.atualizar(post.id(), Status.ERRO);
                    }
                 });

            try {
                Thread.sleep(500);
            } catch(InterruptedException ie) {
                // sabia que essa excessão não é nada de mais?
                // Faça isso que tá bom em 99% das vezes
                Thread.currentThread().interrupt(); 
            }
        }
    }
}
```

Agora deixo para você responder. Como a classe publcidor ficaria mais complexa se adicionassemos mais 100 novos conectores?
E se a sessão de usuário do conector fosse precisar ser reutlizada? Qual solução seria mais fácil de se adaptar?

A grande diferença entre as soluções está em limitar a complexidade ao se encapsular ela. Interfaes existem para que a 
complexidade seja dividida. Uma interface deve ser sas operações comuns entre todos os objetoss similares.

## Porque não vejo problemas no meu tweet? 

Muitos me criticaram porque afirmaram que meu tweet induz ao erro. Bom, vamos analisar ele! Quero aqui analisar textualmente o meu tweet,
mas primeiro quero fazer uma reflexão sobre como consumimos as mídias.

O Twitter (É TWITTER O NOME) é uma rede social de **ideias fragmentas** em trechos com até 280 caracteres. Por ser uma mídia tão reduzida 
é comum encadearmos twitters em um fio. Meu tweet está em um fio, mas vamos ignorar esse fato.

O texto do meu tweet é composto de 3 afirmações:

1. Constatação de um sentimento associado a padrão
2. Elaboração da ideia do padrão
3. Promessa de discussão futura

Agora tente procurar as palavras mais relevanes em cada frase? Já vou respondendo: exatamente, abstração e encapsular.
Por uma limitação de caracteres a primeira frase tem como palavra mais significativa um adjetivo e não um nome ou verbo 
como as frases seguintes.

Tente ler o tweet sem esse adjetivo:

> Uma das coisas que mais me irrita em código é quando o nome da função diz o que ela faz. 
> Isso traz zero abstração ao código, não ajuda a reduzir a complexidade.
> Creio que amanhã ou quinta gravo um vídeo sobre isso. OO é sobre ENCAPSULAR complexidade.

Não faz sentido, certo? O que eu estaria defendendo com esse tweet? Não tenho ideia, mas é bem provável que um dia faça um tweet assim
por um esforço de contenção de caracteres! Aliás, já fiz muito e creio que você também o faça!

Digamos aqui que eu queria escrever um único tweet com uma ideia completa, mas para isso precise de 350 caracteres! Após escrito, começa 
o trabalho de edicão e reescrita para se limitar aos 280. Isso pode levar a uma desconexão entre o que existe no texto e o que desejo dizer.
Logo nossa postura ao não entender um texto é ARGUMENTAR compreensível. Não é que as ideias colocadas ali sejam bizarras, mas que o espaço limitado
gera limitações argumentativas.

Outra questão é que não somos acostumados a adjetivar. Mas creio que se você leu esse post consegue compreender essas questões. 

MAS... voltando ao meu tweet. Responde aí, você compreendeu que o exatamente? 

_Provavelmente vou publicar um vídeo amanhã em sequência a esse._

<iframe width="560" height="315" src="https://www.youtube.com/embed/3SvVY6eceP4?si=KJeVdPakMskjfuW0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
