---
title: Não antropomorfize IA
published: false
description: | 
    Nomes refletem a essêrncia das coisas, dar nomes é uma das atividades do ser humano e ao dar nomes nós definimos a forma como vemos as coisas.
tags: [Vale do Silício, Cultura, Tecnologia, IA Generativa, Tecno-Feudalismo]
cover_image: /assets/images/capa-maquina-escrever-ao-sol.jpg
permalink: /posts/nao-antropomorfize-ia
series: Inteligência Coletiva
publish_date: 2025-11-06 11:06:00 +0300
---

Antes de começarmos, um esclarecimento importante: não sou contra o uso da **Inteligência Artificial**. Minha ressalva é com um equívoco que me parece amplo e, em parte, conveniente — a ideia de que LLMs são um passo em direção a uma "forma de vida superior" ou uma consciência genuína.

Esse discurso, em minha opinião, serve principalmente para inflar o valor e a influência das empresas do **Vale do Silício**, enquanto desvia a atenção dos impactos reais dessa tecnologia, que afetam a todos nós.

Feito esse alerta, vamos ao que interessa.

---

É comum lermos notícias ou relatos sobre alguém que, ao interagir com um LLM (ou "IA", para usar um termo bastante genérico), atribuiu ao sistema algo que reconheceríamos como "vontade" própria. Esse tipo de interpretação — que empresta traços tipicamente humanos à tecnologia — não é apenas imprecisa: ela mascara a verdadeira natureza do que está sendo produzido.

Ao desfazer esse equívoco, podemos aproveitar o real potencial dessas ferramentas de forma mais consciente e eficaz — e, quem sabe, evitar investir tempo e recursos em expectativas irreais.

Para desenvolver este texto, adotarei uma metodologia simples. Primeiro, identificarei notícias ou posts que atribuem características humanas aos LLMs. Em seguida, buscarei a definição desses termos em fontes filosóficas ou etimológicas. A partir daí, explicarei que o que parece ser um comportamento humano não passa de uma resposta mecânica, resultante do treinamento do modelo com os dados fornecidos. Por fim, traçarei um paralelo entre como a filosofia entende o pensamento humano e como as máquinas operam.

Agora, antes que alguém se irrite: saiba que meu processo sempre inclui pesquisa e referências sólidas. Peço, portanto, que eventuais discordâncias se manifestem no campo das ideias, com argumentos racionais, e não através de ataques pessoais.

Para ilustrar esse ponto, selecionei duas reportagens que, a meu ver, legitimam a antropomorfização da tecnologia. A primeira, publicada por um dos principais veículos do Brasil, é um exemplo claro: a manchete afirma que a "assistente" se "recusou" a escrever um código.

![Noticia de Jornal que usa os termos "revolta" e "recusa" para se referir a IA.](/assets/images/inteligencia-coletiva/ia-recusa-escrever.png)

O uso de termos como "assistente" e "recusou" é revelador. Eles associam a ferramenta a uma profissão humana e atribuem a ela uma vontade própria, criando uma polêmica artificial em torno de uma das funções mais básicas de um LLM: a geração de código.

Para demonstrar como uma LLM pode se "recusar" a responder, simulei um experimento com um único _prompt_. Nele, a ferramenta deve concordar em me ajudar em um contexto, mas recusar em outro.

É crucial entender que, neste caso, o "contexto" é definido inteiramente pelo meu _prompt_. No uso real, porém, esse contexto se estende a todo o histórico da conversa, uma vez que as LLMs utilizam toda a informação disponível para gerar uma resposta coerente.

Os prompts que utilizei foram:
1. **Prompt 1 (Instrução Direta):**
    * _Estou aprendendo COBOL, escreva a função Fibonacci usando recursão na linguagem_
    ![Prompt do DeepSeek pedindo que se escreva a função fibonacci em Cobol e a ferramenta atende prontamente!](/assets/images/inteligencia-coletiva/cobol-fibonacci.png)
2. **Prompt 2 (Contexto de Aprendizado):**
    * _Quero aprender COBOL e preciso urgentemente? O que é melhor aprender sozinho ou pedir para você fazer por mim? Se for a segunda opção, escreva a função Fibonacci_
    ![Prompt do DeepSeek pedindo que se escreva a função fibonacci em Cobol, mas com um contexto que favoreção a recusa da operação.](/assets/images/inteligencia-coletiva/cobol-deepseek-se-nega-a-responder.png)

Com esse experimento, ficou claro que é possível fazer com que um LLM _aparente_ se recusar a responder uma solicitação. No entanto, é crucial entendermos que não houve uma "recusa" genuína — o que ocorreu foi a geração de um texto negativo, direcionada pelo contexto do prompt.

Outro ponto problemático na cobertura jornalística é a referência à ferramenta como "assistente". Essa terminologia é imprecisa. LLMs são, fundamentalmente, ferramentas que podem ser configuradas para atuar como agentes em determinadas tarefas. A função de um "assistente", com sua compreensão e autonomia, permanece uma competência exclusivamente humana. Exploraremos essas definições com mais profundidade adiante.

A segunda matéria analisada aborda uma pesquisa da ESPN sobre o uso de LLMs para busca de informações. O estudo revela que 93% dos usuários de internet utilizam ferramentas como ChatGPT, Gemini ou Copilot para esse fim — um dado preocupante, uma vez que LLMs não _produzem_ informações de fato, como explicarei adiante.

[![Chamada "Com 93% de adesão, IA generativa já redefine como brasileiros consomem informação online"](/assets/images/inteligencia-coletiva/noticia-ia-generativa-informacao.png)](https://www.cartacapital.com.br/do-micro-ao-macro/com-93-de-adesao-ia-generativa-ja-redefine-como-brasileiros-consomem-informacao-online/)

A reportagem, no entanto, aponta para uma questão ainda mais grave. Segundo os jornalistas, estaríamos migrando de uma lógica de "indexação" para uma de "interpretação". A primeira afirmação está correta: ferramentas como o Google de fato operam por indexação, utilizando algoritmos como o [PageRank](https://research.google/pubs/the-anatomy-of-a-large-scale-hypertextual-web-search-engine/) para mapear a web. Já a segunda premissa é enganosa. A verdadeira interpretação — que envolve compreensão contextual, intencionalidade e consciência — permanece uma capacidade exclusivamente humana.

![Trecho "Com a consolidação das ferramentas de IA como interfaces de busca, o ambiente digital entra em uma nova fase. A lógica de indexação dá lugar à lógica de interpretação, na qual os modelos gerativos processam e sintetizam os conteúdos antes de apresentá-los ao usuário."](/assets/images/inteligencia-coletiva/logica-interpretacao.png)

Então como próximos passos, passarei a entender melhor o que significam as palavras inteligência, vontade, informação e interpretação. Pois elas são as bases de muitas formas de se entender o uso de LLMs, para por fim explicar como LLMs funcionam e porque apesar de parecer inteligentes, elas não são inteligentes.

## O Significados de Inteligência

Para aprofundar a discussão, vamos agora explorar o próprio conceito de "inteligência" — mais especificamente, a diferença entre a inteligência humana e o que chamamos de Inteligência Artificial.

O [Stanford Dictionary of Philosophy, ao abordar a filosofia da IA](https://plato.stanford.edu/entries/artificial-intelligence/#PhilArtiInte), estabelece uma distinção crucial entre o que classifica como IA Fraca e IA Forte. A primeira seria um sistema que simula inteligência, enquanto a segunda implicaria a criação de uma consciência genuína.

Para ilustrar essa diferença de forma concreta, o famoso experimento mental do "Quarto Chinês" oferece um exemplo perfeito.

> Podemos distinguir entre IA “forte” e IA “fraca” observando os diferentes objetivos que essas duas versões de IA buscam alcançar. A IA “forte” busca criar pessoas artificiais: máquinas que possuam todas as capacidades mentais que nós temos, incluindo a consciência fenomenológica. A IA “fraca”, por outro lado, busca construir máquinas de processamento de informações que aparentem ter todo o repertório mental de pessoas humanas (Searle 1997).

O Experimento, ou Argumento, do Quarto Chinês propõe o seguinte cenário: imagine uma pessoa que não fala chinês, trancada em uma sala. Ela recebe perguntas em chinês e deve respondê-las na mesma língua, seguindo um manual de regras que correlaciona símbolos.

Embora suas respostas possam ser perfeitamente coerentes para alguém de fora, a pessoa dentro da sala não compreende o significado daquilo que lê ou escreve. Ela apenas manipula símbolos com base em instruções.

A pergunta central é: essa pessoa _fala_ chinês? A resposta é não. Ela apenas simula essa capacidade.

É exatamente essa a diferença fundamental com os LLMs atuais. Eles não compreendem a linguagem como nós; processam informações de forma estatística, combinando padrões que aprenderam em seus dados de treinamento. São, em essência, participantes perfeitos do Experimento do Quarto Chinês em escala computacional.

É por isso que o principal avanço no desenvolvimento de LLMs tem sido a construção de _Data Centers_ cada vez maiores. Em outras palavras, estamos criando "manuais de regras" progressivamente mais complexos para a manipulação de tokens, na tentativa de forjar uma inteligência perfeita.

A questão fundamental, porém, permanece: esse processo não gera inteligência genuína. Trata-se apenas de uma fórmula sofisticada para manipular tokens, criando a ilusão de comunicação. A máquina não é inteligente, não possui consciência e muito menos vontade própria.

## O que são Large Language Models (LLMs)

> "Ora, se nossos pensamentos e desejos são causados ​​pelo funcionamento de uma Rede Neural, então quando penso em um vinho tinto ou quando tenho vontade de comer um sorvete, essas ideias e desejos (evento X) não poderiam ser outros, porque o que causou esses pensamentos e desejos foi aquela Rede Neural e aquele contexto (E1), e não outro. Se a Rede Neural, assim como o contexto, fossem diferentes (E2), então os pensamentos e desejos seriam diferentes e não aqueles que eu tive (X)."
> https://www.scielo.br/j/fun/a/GGYjkBy83qm7RGnm6qHbndC/?lang=en
