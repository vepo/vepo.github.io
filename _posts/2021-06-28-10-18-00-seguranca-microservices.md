---
title: Segurança em Microsserviços
published: false
description: Pequeno estudo sobre segurança de microsserviços
tags: [Microsserviços, Segurança]
cover_image: /assets/images/pexels-negative-space-169573.jpg
publish_date: 2021-05-22 18:13:00 +0300
permalink: /posts/seguranca-de-microsservicos
---

Microsserviços são complicados. Imaginar que se apenas quebrarmos um serviço em vários vamos simplificar as coisas é um grande engano. Pior. Um engano distribuído.

Quando temos um monolito, podemos facilmente garantir a identidade de quem o está acessando, a cada requisição temos acesso ao token da sessão de usuário assim como todas as informações do mesmo. Já quando falamos de microsserviços isso não é possível.

## Problemas de segurança com microsserviços

Quando falamos de microsserviços, não estamos mais falando de um serviços, mas vários. Só essa informação já nos dá um panorama interessante do desafio, se temos `n` serviços temos `n` vezes mais chances de termos uma falha se segurança. Não adianta nos iludirmos que nossso software não tem falhas de segurança, ele tem sim. Mas se conhecermos bem alguns padrões podemos reduzir o número de possíveis falhas.

_- Mas como podemos caracterizar uma falha de segurança?_

Ora, não podemos falar de segurança sem entender o que ela significa. Primeiro precisamos entender o que é fundamental. Todo serviço deve ter: confidencialidade, integralidade e disponibilidade. Se qualquer um dessas caracteristicas falharem, temos um problema de segurança. Mas vamos definir cada uma?

**Confidencialidade** é a potencialidade de um serviço entregar a funcionalidade correta para o usuário correto. Um serviço dever ser capaz de identificar o usuário e saber quais são as permissões que o mesmo tem no serviço ou recurso sendo requerido.

**Integralidade** é a certeza que temos que um dado não foi alterado. Será que podemos confiar que uma requisição que veio de determinado usuário não foi realmente alterada?

E por fim a **disponibilidade**, será que podemos confiar quem um serviço estará sempre disponível quando necessário? Se um serviço pode ser facilmente derrubado, temos uma falha de segurança séria no nosso sistema, mesmo que nenhum dado seja corrompido.

O grande problema de microsserviços é que não temos apenas um ponto ou um canal para nos preocuparmos, há uma grande superfície de contato entre o sistema e o mundo externo que podem trazer instabilidade.


