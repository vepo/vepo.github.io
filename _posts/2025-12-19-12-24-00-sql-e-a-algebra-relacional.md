---
title: SQL e a Álgebra Relacional
published: false
description: |
    Nesse post, vamos explorar a álgebra relacional, que é a base teórica para o SQL, a linguagem de consulta mais utilizada em bases de dados relacionais.
tags: [Ciência da Computação, Bases de Dados, Modelos de Dados, SQL, História da Computação]
cover_image: /assets/images/capas/disquete-100-42.jpg
series: Introdução a Bases de Dados
permalink: /posts/sql-e-a-algebra-relacional
publish_date: 2025-12-19 12:03:00 +0300
---

> Esse post é baseado nas notas sobre um curso que estou acompanhando no YouTube, chamado [CMU Intro to Database Systems (15-445/645 - Fall 2025)](https://www.youtube.com/playlist?list=PLSE8ODhjZXjYMAgsGH-GtY5rJYZ6zjsd5). O curso é ministrado por [Andy Pavlo](https://www.cs.cmu.edu/~pavlo/) e cobre diversos tópicos relacionados a sistemas de banco de dados, incluindo arquitetura, indexação, transações, recuperação e muito mais. Todas as notas de aulas e os slides estão disponíveis na [página oficial do curso](https://15445.courses.cs.cmu.edu/fall2025/schedule   .html).

No post anterior, discutimos o que são bases de dados, os modelos de dados mais comuns e a história por trás do modelo relacional. Neste post, vamos explorar a álgebra relacional, que é a base teórica para o SQL, a linguagem de consulta mais utilizada em bases de dados relacionais.

## O que é SQL?

Como já falamos antes, SQL significa Structured Query Language (Linguagem de Consulta Estruturada) dessa breve definição já podemos extrair duas informações muito valiosas: SQL é uma linguagem e SQL é usada para fazer consultas.

Todas as linguagens na computação possuem uma **sintaxe**, uma **semântica** e um proposito. Muitas pessoas gostam muito de pensar que toda linguagem é uma linguagem de programação, mas isso não é verdade. SQL é usada para interagir com bases de dados. HTML é usada para estruturar documentos web. CSS é usada para adicionar estilo. E existem as linguagens de programação de propósito geral, como Python, Java, C, JavaScript, entre outras. 

O SQL por sua vez não é uma linguagem especifica de um banco de dados, mas sim um padrão suportado por diversos sistemas. Ela é especificada pela ISO (International Organization for Standardization) e pela ANSI (American National Standards Institute). O padrão SQL é atualizado periodicamente para incluir novos recursos e melhorias. Alguns dos sistemas de gerenciamento de banco de dados relacionais (SGBDR) mais populares que suportam SQL incluem MySQL, PostgreSQL, Oracle Database, Microsoft SQL Server e SQLite. A linguagem SQL é constantemente atualizada para incluir novos recursos e melhorias, mas as bases de dados nem sempre implementam todas as funcionalidades do padrão. 


Por exemplo, algumas das versões do padrão SQL incluem:

| Nome da Versão | Ano  | Especificação                                                 | Principais Recursos Introduzidos                   |
|----------------|------|---------------------------------------------------------------|----------------------------------------------------|
| SQL:1986       | 1986 | ANSI X3.135:1986 <br/> ISO/IEC 9075:1987 <br/> FIPS PUB 127   | Padrão inicial                                     |
| SQL:1989       | 1989 | ANSI X3.135-1989 <br/> ISO/IEC 9075:1989 <br/> FIPS PUB 127-1 | Integridade (_Constraints_)                        |
| SQL:1992       | 1992 | ANSI X3.135-1992 <br/> ISO/IEC 9075:1992 <br/> FIPS PUB 127-2 | Suport a Unions, Joins, Case                       |
| SQL:1999       | 1999 | ISO/IEC 9075:1999                                             | Expressões Regulares, Triggers, Queries recursivas |
| SQL:2003       | 2003 | ISO/IEC 9075:2003                                             | XML, Windows, Sequences                            |
| SQL:2006       | 2006 | ISO/IEC 9075-14:2006                                          | Suporte aprimorado para XML                        | 
| SQL:2008       | 2008 | ISO/IEC 9075:2008                                             | Truncation, Fancy Sorting                          |
| SQL:2011       | 2011 | ISO/IEC 9075:2011                                             | Temporal DBs, Fetch e Windows Functions            |
| SQL:2016       | 2016 | ISO/IEC 9075:2016                                             | JSON, Polymorphic tables                           |
| SQL:2019       | 2019 | ISO/IEC 9075-15:2019                                          | Multi-Dimensional Arrays                           |
| SQL:2023       | 2023 | ISO/IEC 9075-2023                                             | Property Graph Queries                             |

## O que é Álgebra Relacional?

Agora que entendemos o que é SQL, temos que nos perguntar porque a linguagem é baseada na álgebra relacional e o que é essa tal de álgebra relacional.

**_A Álgebra Relacional é um conjunto de operações fundamentais para recuperar e manipular tuplas em uma relação. Cada operador recebe uma ou mais relações como entrada e produz uma nova relação como saída. Para escrever consultas, podemos "encadear" esses operadores._**

A álgebra relacional é uma derivação da lógica de primeira ordem e da teoria dos conjuntos com o propósito de prover operações que possam ser usadas para selecionar e manipular dados em bases relacionais (ver o livro _Relational completeness of data base sublanguages_).

Em uma base relacional, podemos imaginar que cada relação (ou tabela) é um conjunto de tuplas que podem ser manipuladas por meio de operações da álgebra relacional. As principais operações são:

- **Seleção (σ)**: Seleciona tuplas que satisfazem uma condição específica.
- **Projeção (π)**: Seleciona colunas específicas de uma relação.
- **União (∪)**: Combina tuplas de duas relações, removendo duplicatas.
- **Interseção (∩)**: Retém apenas as tuplas que estão presentes em ambas as relações.
- **Diferença (-)**: Retira tuplas de uma relação que também estão em outra relação.
- **Produto Cartesiano (×)**: Combina todas as tuplas de duas relações possíveis.
- **Junção (⨝)**: Combina tuplas de duas relações com base em uma condição de correspondência.


Nas próximas seções, vamos explorar cada uma dessas operações e como elas se relacionam com consultas SQL comuns. Para exemplificar, vamos usar as seguintes relações:

```plaintext
Aluno(ID, Nome, Idade)
Curso(Codigo, Nome, Creditos)
```


### Seleção (σ)

A seleção recebe uma relação e retorna um subconjunto das tuplas dessa relação que satisfazem um predicado da seleção. O predicado atua como um filtro, e podemos combinar múltiplos predicados usando conjunções e disjunções.

#### Exemplo de Seleção

Dado a relação Alunos, podemos selecionar todos os alunos com idade maior que 20 anos:

```plaintext
001     Alice     22
002     Bob       19
003     Carol     23
004     Dave      21
005     Eve       18
006     Frank     17
007     Grace     20
008     Heidi     24
009     Ivan      22
010     Judy      19
```

Aplicando a seleção σ(Idade > 20)(Aluno), obtemos:

```plaintext
001     Alice     22
003     Carol     23
004     Dave      21
008     Heidi     24
009     Ivan      22
```

### Projeção (π)

A projeção recebe uma relação como entrada e retorna uma relação com tuplas que contêm apenas os atributos especificados. Você pode reorganizar a ordem dos atributos na relação de entrada, bem como manipular os valores.

#### Exemplo de Projeção

Dado a relação Alunos, podemos projetar apenas os nomes dos alunos:

```plaintext
001     Alice     22
002     Bob       19
003     Carol     23
004     Dave      21
005     Eve       18
006     Frank     17
007     Grace     20
008     Heidi     24
009     Ivan      22
010     Judy      19
```

Aplicando a projeção π(Nome)(Aluno), obtemos:

```plaintext
Alice
Bob
Carol
Dave
Eve
Frank
Grace
Heidi
Ivan
Judy
```

### União (∪)

A união recebe duas relações e retorna uma relação que contém todas as tuplas que aparecem em pelo menos uma das relações de entrada. Observação: as duas relações de entrada devem ter exatamente os mesmos atributos.

#### Exemplo de União

Dadas as relações Aluno1 e Aluno2:

```plaintext
001     Alice     22
002     Bob       19
003     Carol     23
004     Dave      21
005     Eve       18
006     Frank     17
007     Grace     20
008     Heidi     24
009     Ivan      22
010     Judy      19
```

```plaintext
011     Kevin     20
012     Laura     21
013     Mallory   22
014     Nancy     23
015     Oscar     24
```

Aplicando a união Aluno1 ∪ Aluno2, obtemos:

```plaintext
001     Alice     22
002     Bob       19
003     Carol     23
004     Dave      21
005     Eve       18
006     Frank     17
007     Grace     20
008     Heidi     24
009     Ivan      22
010     Judy      19
011     Kevin     20
012     Laura     21
013     Mallory   22
014     Nancy     23
015     Oscar     24
```

### Interseção (∩)

A interseção recebe duas relações e retorna uma relação que contém todas as tuplas que aparecem em ambas as relações de entrada. Observação: as duas relações de entrada devem ter exatamente os mesmos atributos.

#### Exemplo de Interseção

Dadas as relações Aluno1 e Aluno2:

```plaintext
001     Alice     22
002     Bob       19
003     Carol     23
004     Dave      21
005     Eve       18
006     Frank     17
007     Grace     20
008     Heidi     24
009     Ivan      22
010     Judy      19
```

```plaintext
002     Bob       19
003     Carol     23
004     Dave      21
006     Frank     17
007     Grace     20
009     Ivan      22
011     Kevin     20
013     Mallory   22
015     Oscar     24
```

Aplicando a interseção Aluno1 ∩ Aluno2, obtemos:

```plaintext
002     Bob       19
003     Carol     23
004     Dave      21
006     Frank     17
007     Grace     20
009     Ivan      22
```

### Diferença (-)

A diferença recebe duas relações e retorna uma relação que contém todas as tuplas que aparecem na primeira relação, mas não na segunda. Observação: as duas relações de entrada devem ter exatamente os mesmos atributos.

#### Exemplo de Diferença

Dadas as relações Aluno1 e Aluno2:

```plaintext
001     Alice     22
002     Bob       19
003     Carol     23
004     Dave      21
005     Eve       18
006     Frank     17
007     Grace     20
008     Heidi     24
009     Ivan      22
010     Judy      19
```

```plaintext
002     Bob       19
003     Carol     23
004     Dave      21
006     Frank     17
007     Grace     20
009     Ivan      22
011     Kevin     20
013     Mallory   22
015     Oscar     24
```

Aplicando a diferença Aluno1 - Aluno2, obtemos:

```plaintext
001     Alice     22
005     Eve       18
008     Heidi     24
010     Judy      19
```

### Produto Cartesiano (×)

O produto cartesiano recebe duas relações e retorna uma relação que contém todas as combinações possíveis de tuplas das relações de entrada.

#### Exemplo de Produto Cartesiano

Dadas as relações Aluno e Curso:

```plaintext
001     Alice     22
002     Bob       19
003     Carol     23
```

```plaintext
C001    Matemática     4
C002    Física         3
C003    Química        4
```

Aplicando o produto cartesiano Aluno × Curso, obtemos:

```plaintext
001     Alice     22    C001    Matemática     4
001     Alice     22    C002    Física         3
001     Alice     22    C003    Química        4
002     Bob       19    C001    Matemática     4
002     Bob       19    C002    Física         3
002     Bob       19    C003    Química        4
003     Carol     23    C001    Matemática     4
003     Carol     23    C002    Física         3
003     Carol     23    C003    Química        4
```

### Junção (⨝)

A junção recebe duas relações e retorna uma relação que contém todas as tuplas que são uma combinação de duas tuplas, onde, para cada atributo que as duas relações compartilham, os valores desse atributo em ambas as tuplas são iguais.

#### Exemplo de Junção

Dadas as relações Aluno e Curso:

```plaintext
001     Alice     22
002     Bob       19
003     Carol     23
```

```plaintext
001    Matemática     4
002    Física         3
003    Química        4
```

Aplicando a junção Aluno ⨝ Curso usando o ID = Codigo, obtemos:

```plaintext
001     Alice     22    Matemática     4
002     Bob       19    Física         3
003     Carol     23    Química        4
```