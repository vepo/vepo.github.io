---
layout: "tutorial"
title: Como criar um serviço usando SOAP em Java
published: false
description: |
    Aprenda passo a passo como criar, implementar e consumir serviços SOAP em 
    Java com exemplos reais de código e explicações detalhadas.
tags: [Java, SOAP, Web Services, XML, JAX-WS, Tutorial]
publish_date: 2025-12-16 11:00:00 -0300
permalink: /tutorial/como-criar-um-servico-usando-soap
cover_image: /assets/images/capas/chaplin-modern-times.webp
---

### Introdução

SOAP, ou Simple Object Access Protocol, é uma implementação _Remote Procedure Call_ (RPC) que permite a implementação de Serviços Web usando HTTP e XML.

Olá, desenvolvedores! Hoje vamos mergulhar no mundo dos **SOAP Web Services** usando Java. Se você precisa integrar sistemas legados, trabalhar com protocolos padronizados ou simplesmente entender como funcionam os serviços web "tradicionais", este tutorial é para você!

## 📋 O que é SOAP?

**SOAP** (Simple Object Access Protocol) é um protocolo de comunicação baseado em XML para troca de informações estruturadas em serviços web. Diferente do REST (que é mais leve e flexível), o SOAP é:

- **Padronizado**: Segue especificações rigorosas
- **Independente de linguagem**: Funciona com qualquer linguagem
- **Seguro**: Suporta WS-Security, WS-ReliableMessaging, etc.
- **Baseado em contrato**: Usa WSDL (Web Services Description Language)

## 🚀 Vamos Criar Nosso Primeiro Serviço SOAP

### Pré-requisitos:
- Java 11+
- Maven ou Gradle
- IDE de sua preferência (IntelliJ, Eclipse, VS Code)

### 1. Dependências Maven

```xml
<dependency>
    <groupId>jakarta.xml.ws</groupId>
    <artifactId>jakarta.xml.ws-api</artifactId>
    <version>4.0.0</version>
</dependency>
<dependency>
    <groupId>com.sun.xml.ws</groupId>
    <artifactId>jaxws-ri</artifactId>
    <version>4.0.1</version>
    <type>pom</type>
</dependency>
<dependency>
    <groupId>jakarta.jws</groupId>
    <artifactId>jakarta.jws-api</artifactId>
    <version>3.0.0</version>
</dependency>
```

### 2. Estrutura do Projeto

Vamos criar um sistema simples de **Pub/Sub (Publicador/Assinante)** onde clientes podem se inscrever em tópicos e receber mensagens.

```java
package dev.vepo.rpc;

public class SoapDemo {
    // Configuração básica
    private static final int PORT = 5503;
    
    // Vamos entender cada parte!
}
```

### 3. Definindo os Data Types (Tipos de Dados)

SOAP é fortemente tipado. Precisamos definir todas as estruturas de dados:

```java
// Requisição de inscrição
@XmlRootElement(name = "SubscribeRequest", namespace = "http://rpc.vepo.dev/")
public static class SubscribeRequest {
    private String clientId;
    private String topic;
    private OffsetReset offsetReset; // ENUM: LATEST ou EARLIEST
    
    // Getters e Setters (omitted for brevity)
}

// Mensagem com headers
@XmlRootElement(name = "Message", namespace = "http://rpc.vepo.dev/")
public static class Message {
    private String key;
    private byte[] value;
    private HeadersMap headers;
    private int offset;
    
    @Override
    public String toString() {
        return "Message{key='" + key + "', offset=" + offset + "}";
    }
}
```

**💡 Dica:** As anotações `@XmlRootElement` e `@XmlType` são do JAXB (Java Architecture for XML Binding) e são essenciais para a serialização/deserialização XML no SOAP.

### 4. Criando a Interface do Serviço

```java
@WebService(
    name = "PubSubService",
    targetNamespace = "http://rpc.vepo.dev/"
)
public interface PubSubService {
    @WebMethod(operationName = "Subscribe")
    MessageStream subscribe(SubscribeRequest request);
}
```

**📌 Explicação:**
- `@WebService`: Define que é um endpoint SOAP
- `@WebMethod`: Especifica a operação disponível
- `targetNamespace`: Namespace XML para evitar conflitos

### 5. Implementando o Serviço

```java
@WebService(
    serviceName = "PubSubService",
    portName = "PubSubServicePort",
    targetNamespace = "http://rpc.vepo.dev/",
    endpointInterface = "dev.vepo.rpc.SoapDemo$PubSubService"
)
public static class PubSubServiceImpl implements PubSubService {
    
    @Override
    public MessageStream subscribe(SubscribeRequest request) {
        System.out.println("[SOAP Server] Requisição recebida! " + request);
        
        // Lógica de negócio aqui
        MessageStream stream = new MessageStream();
        
        // Simulando mensagens
        for (int i = 1; i <= 3; i++) {
            Message msg = new Message();
            msg.setKey("A" + i);
            msg.setOffset(i);
            msg.setValue(("VALUE " + i).getBytes());
            
            HeadersMap headers = new HeadersMap();
            headers.addEntry("app-id", "soap-demo");
            headers.addEntry("timestamp", String.valueOf(System.currentTimeMillis()));
            msg.setHeaders(headers);
            
            stream.getMessages().add(msg);
        }
        
        return stream;
    }
}
```

### 6. Inicializando o Servidor

```java
// No bloco estático (executa quando a classe é carregada)
static {
    System.out.println("[SOAP Server] Inicializando na porta " + PORT);
    
    String address = "http://localhost:" + PORT + "/ws/pubsub";
    Endpoint endpoint = Endpoint.publish(address, new PubSubServiceImpl());
    
    if (endpoint.isPublished()) {
        System.out.println("✅ Servidor SOAP iniciado: " + address);
        System.out.println("📄 WSDL disponível: " + address + "?wsdl");
        
        // Graceful shutdown
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            System.out.println("🛑 Desligando servidor...");
            endpoint.stop();
        }));
    }
}
```

### 7. Criando o Cliente SOAP

Agora a parte mais interessante: como consumir nosso serviço!

```java
public static void start() {
    System.out.println("\n=== CLIENTE SOAP ===\n");
    
    try {
        // 1. Criar cliente usando WSDL
        URL wsdlUrl = new URL("http://localhost:" + PORT + "/ws/pubsub?wsdl");
        QName serviceName = new QName("http://rpc.vepo.dev/", "PubSubService");
        QName portName = new QName("http://rpc.vepo.dev/", "PubSubServicePort");
        
        Service service = Service.create(wsdlUrl, serviceName);
        PubSubService client = service.getPort(portName, PubSubService.class);
        
        System.out.println("✅ Cliente SOAP criado");
        
        // 2. Preparar requisição
        SubscribeRequest request = new SubscribeRequest();
        request.setClientId("meu-cliente-123");
        request.setTopic("notificacoes");
        request.setOffsetReset(OffsetReset.EARLIEST);
        
        // 3. Chamar serviço (síncrono)
        System.out.println("📤 Enviando requisição...");
        long startTime = System.currentTimeMillis();
        
        MessageStream response = client.subscribe(request);
        
        System.out.println("📥 Resposta em " + 
            (System.currentTimeMillis() - startTime) + "ms");
        
        // 4. Processar resposta
        System.out.println("\n📊 Estatísticas:");
        System.out.println("   Mensagens recebidas: " + response.getMessages().size());
        
        for (Message msg : response.getMessages()) {
            System.out.println("\n   🔹 " + msg.getKey() + 
                " (offset: " + msg.getOffset() + ")");
            
            if (msg.getValue() != null) {
                System.out.println("   Conteúdo: " + new String(msg.getValue()));
            }
            
            if (msg.getHeaders() != null) {
                System.out.println("   Headers:");
                for (HeaderEntry header : msg.getHeaders().getEntries()) {
                    System.out.println("     " + header.getKey() + ": " + header.getValue());
                }
            }
        }
        
    } catch (Exception e) {
        System.err.println("❌ Erro: " + e.getMessage());
        e.printStackTrace();
    }
}
```

### 8. Executando o Projeto

Crie uma classe principal:

```java
public class Main {
    public static void main(String[] args) throws Exception {
        // O servidor inicia automaticamente (bloco estático)
        
        // Aguardar servidor inicializar
        Thread.sleep(2000);
        
        // Executar demonstração do cliente
        SoapDemo.start();
        
        // Manter servidor rodando
        System.out.println("\n🎯 Servidor SOAP está ativo!");
        System.out.println("Pressione Ctrl+C para encerrar.");
        
        // Manter thread principal viva
        Thread.currentThread().join();
    }
}
```

## 🔍 Analisando o WSDL Gerado

Acesse `http://localhost:5503/ws/pubsub?wsdl` e você verá algo como:

```xml
<definitions 
    targetNamespace="http://rpc.vepo.dev/"
    name="PubSubService">
    
    <types>
        <!-- Nossas classes definidas como XML Schema -->
        <xsd:schema>
            <xsd:element name="SubscribeRequest" type="tns:SubscribeRequest"/>
            <xsd:element name="MessageStream" type="tns:MessageStream"/>
        </xsd:schema>
    </types>
    
    <message name="Subscribe">
        <part name="parameters" element="tns:SubscribeRequest"/>
    </message>
    
    <portType name="PubSubService">
        <operation name="Subscribe">
            <input message="tns:Subscribe"/>
            <output message="tns:SubscribeResponse"/>
        </operation>
    </portType>
    
    <!-- Binding, service, etc. -->
</definitions>
```

## 🧪 Testando com SoapUI

1. Instale o [SoapUI](https://www.soapui.org/)
2. Crie um novo projeto SOAP
3. Use a URL do WSDL: `http://localhost:5503/ws/pubsub?wsdl`
4. Execute a operação `Subscribe` com este XML:

```xml
<soapenv:Envelope 
    xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:rpc="http://rpc.vepo.dev/">
    
    <soapenv:Header/>
    <soapenv:Body>
        <rpc:SubscribeRequest>
            <clientId>test-client</clientId>
            <topic>demo-topic</topic>
            <offsetReset>EARLIEST</offsetReset>
        </rpc:SubscribeRequest>
    </soapenv:Body>
</soapenv:Envelope>
```

## ⚠️ Armadilhas Comuns e Soluções

### 1. **Namespace conflitos**
```java
// SEMPRE defina namespace nas anotações
@XmlRootElement(name = "Message", namespace = "http://rpc.vepo.dev/")
```

### 2. **QName incorreto**
```java
// O QName deve bater exatamente com o WSDL
QName serviceName = new QName("http://rpc.vepo.dev/", "PubSubService");
// namespaceURI   , localPart
```

### 3. **Serialização de tipos complexos**
```java
// Coleções precisam de getters/setters
public class HeadersMap {
    private List<HeaderEntry> entries = new ArrayList<>();
    
    // Getter é ESSENCIAL para JAXB
    public List<HeaderEntry> getEntries() { return entries; }
}
```

### 4. **Timeout em produção**
```java
// Configure timeout no cliente
BindingProvider bp = (BindingProvider) client;
bp.getRequestContext().put("com.sun.xml.ws.request.timeout", 5000);
bp.getRequestContext().put("com.sun.xml.ws.connect.timeout", 3000);
```

## 🚀 Próximos Passos

1. **Segurança**: Adicione autenticação com WS-Security
2. **Logging**: Implemente handlers para logging SOAP
3. **Monitoramento**: Adicione métricas com Micrometer
4. **Testes**: Crie testes com JUnit e SoapUI
5. **Produção**: Use container (Tomcat, Jetty) em vez de `Endpoint.publish()`

## 📊 SOAP vs REST: Quando Usar?

| Critério | SOAP | REST |
|----------|------|------|
| **Protocolo** | Qualquer (HTTP, SMTP, etc) | Apenas HTTP |
| **Formato** | XML apenas | JSON, XML, texto, etc |
| **Padrões** | WS-*, WSDL, SOAP | HTTP verbs, HATEOAS |
| **Performance** | Mais lento (XML verbose) | Mais rápido |
| **Uso ideal** | Sistemas legados, bancos, alta segurança | APIs web, mobile, IoT |

## 🎯 Conclusão

SOAP ainda é relevante em muitos cenários, especialmente em:
- **Sistemas bancários e financeiros**
- **Integração com sistemas legados**
- **Ambientes corporativos com padrões rígidos**
- **Quando segurança e transações são críticas**

O código completo está disponível no [GitHub](link-do-repositorio). Experimente, modifique e compartilhe suas descobertas!

**💬 Discussão:** Você já trabalhou com SOAP? Quais foram os maiores desafios? Compartilhe nos comentários!

---

**📚 Recursos Adicionais:**
- [Java EE 8 Tutorial - Web Services](https://javaee.github.io/tutorial/webservices.html)
- [JAX-WS Documentation](https://javaee.github.io/metro-jax-ws/)
- [SOAP 1.2 Specification](https://www.w3.org/TR/soap12/)

**🔗 Tags:** #Java #SOAP #WebServices #Tutorial #Programming #Backend #Integration

---

**Sobre o autor:** Desenvolvedor Java com experiência em sistemas distribuídos e integração de sistemas. Acompanhe mais conteúdos como este no meu [blog](link-do-blog) e [Twitter](link-twitter).

*Gostou do tutorial? Deixe um comentário ou compartilhe com seus colegas!* 🚀