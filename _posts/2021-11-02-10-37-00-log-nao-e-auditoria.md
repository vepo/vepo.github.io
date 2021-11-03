---
title: Log não é auditoria!
permalink: /posts/log-nao-e-auditoria
published: true
description: Log e Auditoria são duas funcionalidades diferentes. Objetivos de negócio diferentres, vamos ver?
tags: [Logging, Auditoria, Produto]
series: Coisas que todo Sênior deve saber
cover_image: /assets/images/backend/clint-eastwood-the-good-the-bad-and-the-ugly.jpg
publish_date: 2021-11-03 10:37:00 +0300
---

Esse post é uma resposta as inúmeras mensagens que recebi por um tweet.

No dia 02/11/2021 uma empresa de entrega de comida sofreu um ataque interno de um colaborador. Os nomes dos restaurantes foram alterados para nomes ofensivos. Foi um ataque politico, direcionado e baixo. Tentavam macular a imagem da vereadora Marielle Franco em ataques infantil. Na minha opinião era melhor a policia investigar e não a empresa. Foi uma ofensa a família da Marielle, aos restaurantes envolvidos e aos usuários.

Foi aí que comecei a ler minha timeline e percebi que muito se falava de investigar. E levantei a questão.... seu sistema tem auditoria como uma funcionalidade?

![Meu tweet](/assets/images/auditoria/auditoria.png)

Era tarde e pela manhã já havia várias interações, muitas delas falando de log. É confuso, mas vamos definir o que é um log e o que é uma auditoria?

# O que é log?

Muitos confundem log por log de aplicação. Log é um formato de armazenamento. É quando uma aplicação sempre escreve em um fluxo de dados. Esse fluxo pode ser qualquer coisa, um arquivo, um socket ou quem sabe uma impressora. 

Logs são usados desde o inicio da computação pois são extremamente úteis. Se você pensa que é usado somente com um proposito, está errado! Existem bancos de dados que usam logs para armazenar as informações. O Apache Kafka armazena as mensagem em arquivos de logs.

Para simplificar, qualquer dado imutável pode, e deve, ser armazenado usando logs. O que vai diferenciar é o framework. Já vi sistema que usava o SLF4J para enviar mensagens para o Apache Kafka, pode parecer fora de proposito, mas isso facilitava em muito a implementação e o Kafka poderia ser substituído pelo log de arquivo.

O log de sistema é um método para resolução de problemas (o famoso troubleshooting). Toda aplicação deve ter log usando níveis, mensagens mais importantes deve ser associadas a níveis mais elevados. Como o log é uma atividade cara, em termos de performance, certos níveis podem ser desabilitados. Eu não vou definir os níveis, porque eles são abertos e muitas vezes definido pelo framework. 

No momento em que escrevo esse post estou trabalhando em um sistema legado que tem três níveis de debug! Se eu ativer o nível máximo consigo até ler como as mensagens socket estão sendo lidas pela aplicação. Esse nível máximo só deve ser usando quando há algum problema no protocolo de comunicação e não na aplicação.

O log de sistema deve ter mensagens úteis para a resolução de problema, assim como avisos e erros de execução. Ele é um fluxo de dados volátil, pode ser descartado se não houver nada a se investigar. Ou em sistemas estáveis, pode até ser desabilitado, registrando apenas mensagens de erros.

# O que é auditoria?

Auditoria é um processo. Você com certeza já ouviu o termo "auditoria externa". Qualquer empresa pode passar por auditoria, é quando um auditor vem observar se os processos estão condizentes com a norma. Se não ficou óbvio vou ressaltar: auditoria pressupõe a existência de processos e normas.

Qualquer empresa que trabalha com dados precisa de processos bem definidos. Usar dados envolve armazenar, transformar e usar dados. Dados são ativos regulados por leis, inclusive pela LGPD que define que os dados não pertencem a empresa, mas ao usuário que originou ele. O usuário cede a empresa seus dados e deve autorizar o seu uso (não sou advogado e posso estar confundindo a LGPD brasileira com a europeia).

É papel de um CTO e do arquiteto da empresa ter um mapeamento de quais dados a empresa possui e como eles são usados internamente. Sei que é praticamente impossível ter essa informação atualizada por causa da agilidade do desenvolvimento. 

Computação ainda é um campo sem processos bem definidos, assim como a indústria do petróleo era no passado. Mas vazamentos e acidentes começaram a ocorrer com frequência o que ocasionou uma intensa regulamentação. A computação está prestes a chegar a maturidade, você pode ver no noticiário um CEO de uma Big Tech depondo (mentindo) para o congresso americano. Eu acompanhei o depoimento dele de 2018, ele se recusou a responder o que fazia com os dados de usuário da plataforma dele. Ele poderia ser preso por não responder ou responder de forma genérica, mas ele preferiu desconversar do que falar a verdade. Isso significa que a resposta dele poderia ocasionar sua imediata prisão e o fechamento da plataforma.

Porque eu estou falando isso? Fugi ao tema do post? Não! Processos de auditoria vão ficar cada vez mais comuns! Essa discussão do senado americano no fim vai provar como o uso de dados pessoais foram uma ameaça a democracia americana, democracia brasileira e a economia do Reino Unido. Quando eles provarem isso virá uma severa legislação. Muitas empresas vão reclamar, mas será culpa deles pode não terem se auto regulado!

Empresas vão precisar gerar dados para auditoria, frameworks vão ser padronizados e terceirizados, surgirão normas para gestão de dados, modelos de ML serão auditados. Já há uma literatura sobre o assunto, tente ler o livro [Algoritmos de Destruição em Massa](https://www.amazon.com.br/Algoritmos-Destrui%C3%A7%C3%A3o-Massa-Cathy-ONeil/dp/6586460026/) da Cathy O'Neil. Qualquer empresa que mexe com dados vai precisar construir sistemas de auditoria.

Mas esses sistemas já deveriam existir internamente. Sei que eles existem em bancos, porque são entidades muito regulamentadas. AINDA BEM!!! Se acha isso chato, é melhor do que você acordar pobre porque o banco não tem dinheiro. Isso já aconteceu no Brasil.

# Porque não usar o log para Auditoria

No fundo auditoria é um log, mas a diferença é quem o consulta e quando. Mas usar uma funcionalidade de log vai fazer com que a auditoria seja especifica de um serviço e não uma empresa. 

Quando falamos de microsserviços e computação distribuída, alguns sistemas não tem a informação completa. Já implementei um sistema que certos serviços não tinha a informação de usuário, só o identificador. Uma auditoria precisa de dados correlacionados, significado.

Auditoria precisa de interface de usuário também. Porque não criar uma interface simples que permite ver que dados foram alterados. Essa interface tem que proteger a integridade do dados, se um usuário alterar o número do cartão de crédito esse dado tem que estar ilegível, mas tem que existir esse dados. Na verdade é recomendável que informações sensíveis não estejam visíveis na base de dados. NINGUÉM DA EMPRESA PODE TER ACESSO A DADOS DE USUÁRIO!

# Frameworks para auditoria

Se você é desenvolvedor Java como eu e usa bases relacionais. Recomendo fortemente o uso do Hibernate com Envers. É uma framework de mercado, estável, bem documentado e que entrega auditória. Não conheço outros frameworks para bases não relacionais, se tiver algum me manda pelo twitter.

Mas isso não significa que o trabalho terminou. Você apenas armazenou os dados, o que é relevante para o sistema. Mas esses dados são signficativos?