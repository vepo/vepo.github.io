---
title: Anatomia do Protocolo HTTP
permalink: /posts/anatomia-protocolo-http
published: false
description: Existem Padrões de Projetos para APIs REST? Fui procurar uma resposta para essa pergunta
tags: [API, REST, Design Patterns, Arquitetura de Software]
cover_image: /assets/images/biblioteca.jpg
series: Backend Roadmap
publish_date: 2020-11-30 09:14:00 +0300
---

# Anatomia do Protocolo HTTP

## Introdução

**HyperText Transfer Protocol** (HTTP) é um protocolo no nível da aplicação para sistemas de informação distribuídos e colaborativos. É um protocolo genérico e _stateless_ que pode ser extendido pela aplicação. O protocolo permite a negociação do formato do dado entre cliente e servidor, permitindo que sistemas sejam implementados indepentemente.

| RFCs | Título | Data |
| ---- | ------ | ---- |
| [2616](https://tools.ietf.org/html/rfc2616) | Hypertext Transfer Protocol -- HTTP/1.1 | Junho 1999 |
| [2817](https://tools.ietf.org/html/rfc2817) | Upgrading to TLS Within HTTP/1.1 | Maio 2000 |
| [5785](https://tools.ietf.org/html/rfc5785) | Defining Well-Known Uniform Resource Identifiers (URIs) | Abril 2010 |
| [6266](https://tools.ietf.org/html/rfc6266) | Use of the Content-Disposition Header Field in the Hypertext Transfer Protocol (HTTP) | Junho 2011 |
| [6585](https://tools.ietf.org/html/rfc6585) | Additional HTTP Status Codes | Abril 2012 |
| [7168](https://tools.ietf.org/html/rfc7168) | The Hyper Text Coffee Pot Control Protocol for Tea Efflux Appliances (HTCPCP-TEA) | 1º Abril de 2014 |
| [7230](https://tools.ietf.org/html/rfc7230) | Hypertext Transfer Protocol (HTTP/1.1): Message Syntax and Routing | Junho 2014 |
| [7231](https://tools.ietf.org/html/rfc7231) | Hypertext Transfer Protocol (HTTP/1.1): Semantics and Content | Junho 2014 |
| [7232](https://tools.ietf.org/html/rfc7232) | Hypertext Transfer Protocol (HTTP/1.1): Conditional Requests | Junho 2014 |
| [7233](https://tools.ietf.org/html/rfc7233) | Hypertext Transfer Protocol (HTTP/1.1): Range Requests | Junho 2014 |
| [7234](https://tools.ietf.org/html/rfc7234) | Hypertext Transfer Protocol (HTTP/1.1): Caching | Junho 2014 |
| [7235](https://tools.ietf.org/html/rfc7235) | Hypertext Transfer Protocol (HTTP/1.1): Authentication | Junho 2014 |
| [7540](https://tools.ietf.org/html/rfc7540) | Hypertext Transfer Protocol Version 2 (HTTP/2) | Maio 2015 |
| [8740](https://tools.ietf.org/html/rfc8740) | Using TLS 1.3 with HTTP/2 | Fevereiro 2020 |
| [Draft](https://datatracker.ietf.org/doc/html/draft-ietf-quic-http-32) | Hypertext Transfer Protocol Version 3 (HTTP/3) | Outubro 2020 |

Apesar de todas as RFCS serem relativamente recentes, o HTTP tem sido usado pela World-Wide Web desde 1990, sendo o formato HTTP/1.1 o mais conhecido. As atualizações propostas pelas versões mais recentes não alteraram a estrutura do protocolo, somente a codificação das mensagens trocadas. Os itens da sua estrutura, como Métodos, Caminhos, Cabeçalhos e Corpo da Mensagem, continuam existindo.

A grande vantagem do HTTP/1.1 é que o mesmo é um protocolo humanamente legivel. Você pode abrir uma sessão telnet escrever uma requisição HTTP com uma linha.

```
$ telnet www.w3.org 80
Trying 128.30.52.100...
Connected to www.w3.org.
Escape character is '^]'.
GET http://www.w3.org/pub/WWW/TheProject.html HTTP/1.1

HTTP/1.1 400 Bad Request
date: Wed, 02 Dec 2020 17:59:53 GMT
last-modified: Thu, 04 Jun 2020 15:34:04 GMT
etag: "420-5a743dfdcf300"
accept-ranges: bytes
content-length: 1056
vary: upgrade-insecure-requests
content-type: text/html; charset=iso-8859-1
x-backend: www-mirrors

<!DOCTYPE html>
<html lang="en">
<head>
<title>Error 400 - Bad Request</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://www.w3.org/StyleSheets/base">
<style>
body { line-height: 1.4; }
</style>
</head>
<body>
<h1><a href="https://www.w3.org/"><img src=
"https://www.w3.org/Icons/w3c_home" alt="W3C" width="72" /></a>
<span class=h1text>Sorry, Bad Request</span></h1>
<hr>

<p><strong>The request could not be understood by the server due to malformed
syntax.</strong></p>

<p>This could mean one of the following:</p>

<ul>
<li>Your web browser may be malfunctioning.</li>
<li>Your internet connection may be unreliable.</li>
</ul>

<p>If you still have a question, please consult the <a href=
"https://www.w3.org/Help/Webmaster">Webmaster FAQ</a> or to find the
information you are looking for please start on the <a href=
"https://www.w3.org/">W3C Home page</a> or the <a href=
"https://www.w3.org/Help/search">W3C search page</a>.</p>

<hr>
<address><a href="https://www.w3.org/Help/Webmaster">Webmaster</a></address>
</body>
</html>


Connection closed by foreign host.
```

## Histórico

Inicialmente o HTTP era usado somente para visualização de conteúdo nos navegadores. As páginas Web tinham poucas funcionalidades e seu conteúdo era renderizado pelo servidor. Depois os navegadores começaram a ter mais funcionalidades graças ao Javascript. Com o advento de uma linguagem a ser executado no navegador, era possível alterar a [DOM](https://developer.mozilla.org/pt-BR/docs/DOM/Referencia_do_DOM/Introdu%C3%A7%C3%A3o), esta é o modo de acesso de todos elementos da UI via código. Cada elemento HTML era um Objeto Javascript, podendo ser alterado. Isso deu vida ao que chamamos Web 2.0, as páginas estaticas evoluiram para um versão mais interativa. Cada usuário poderia ter contas de acesso e o conteúdo da página atualizava de acordo com a iteração do usuário, as vezes sem fazer requisição HTTP. Vale lembrar que nessa época uma Requisição HTTP as vezes era muito demorada. 

Tudo isso impulsionou a requisição [AJAX](https://developer.mozilla.org/pt-BR/docs/Web/Guide/AJAX), onde dentro de um código Javascript era feito uma requisição HTTP, não estamos falando de [REST](https://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm), muitas vezes era feita uma requisição de uma outra página HTML ou de um XML, ou era acessado um serviço via [SOAP](https://www.w3.org/TR/soap12/). Só pra lembrar, os navegadores tinham suporte a [SOAP](https://developer.mozilla.org/en-US/docs/Archive/Mozilla/Firefox/SOAP_in_Gecko-based_Browsers), mas muitas vezes ele era feito diretamente por AJAX, porque o grande problema da época era a compatibilidade dos navegadores.

Paralelo ao crescimento das funcionalidades do lado do cliente, surgiu os Smartphones. Ambos de início eram muito rudimentares. As apliações Web, se é que podemos chamar assim, era construida basicamente usando jQuery. A grande vantagem do jQuery era criar uma fachada para acesso ao navegador, tentando assim diminuir a dor de portar uma aplicação em todos os navegadores do mercado. Assim estas aplicações foram evoluindo até surgirem as primeiras [Single-Page Applications](https://en.wikipedia.org/wiki/Single-page_application#History) (SPA) e os primeiros frameworks Frontend.

As principais forças para o crescimento das APIs foram as SPAs e os aplicativos Mobile. Os microserviços acabaram se popularizando na mesma época, mas grande parte das APIs são feitas para serem consumida como serviços a serem exibidos diretamente para usuários.

# Elementos do Protocolo

O Protocolo HTTP é de certa forma simples, por ser stateless, não há vários estados ou tipos de requisição. Podemos resumir o protocolo na análise simples de uma requisição. Vamos começar vendo os elementos proposto na versão 1.1, para depois vermos o que foi adicionado nas versões mais recentes.

Podemos dizer que uma Requisição HTTP terá:

| Elemento | Descrição |
| -------- | --------- |
| Método | Indica o que deve ser feito ao recurso. Os métodos existente são: `OPTIONS`,  `GET`, `HEAD`, `POST`, `PUT`, `DELETE`, `TRACE` e `CONNECT`. |
| URI | Indica para qual recurso a Requisição deve ser aplicada. |
| Cabeçalho | Informações adicionais a Requisição passada pelo cliente. Atuam como modificadores da requisição. Os cabeçalhos definido pelo protocolo são: `Accept`, `Accept-Charset`, `Accept-Encoding`, `Accept-Language`, `Authorization`, `Expect`, `From`, `Host`, `If-Match`, `If-Modified-Since`, `If-None-Match`, `If-Range`, `If-Unmodified-Since`, `Max-Forwards`, `Proxy-Authorization`, `Range`, `Referer`, `TE` e `User-Agent`. |
| Corpo | Entidade associada a Requisição. Só existe na requisição associada aos métodos: `POST` e `PUT`. |
