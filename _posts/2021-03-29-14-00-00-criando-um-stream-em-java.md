---
title: Criando um Stream em Java
published: true
description: Nesse post apresento como criar um Stream sem ter todos os objetos em mãos.
tags: [Java, Java Stream, Programação Funcional]
cover_image: /assets/images/capas/cartas-vintage.jpg
original: https://dev.to/vepo/criando-um-stream-em-java-2ii9
publish_date: 2021-03-29 14:00:00 +0300
permalink: /posts/criando-um-stream-em-java
---

Esse é um post muito rápido! Eu tinha estudado isso muito tempo atrás, na época que o Java 8 foi lançado, mas hoje tive uma ideia de usar ele.

# Qual é problema a se resolver?

Podemos usar Stream para abstrair um tipo de coleção, com o Stream podemos encapsular o metodo de captura do dado e só expor uma fonte de dados.

# Porque eu decidir usar? 

Estou implementando uma funcionalidade que consome uma lista de produtos de uma API. Como essa lista é paginada e eu preciso usar em alguns lugares, prefiro criar um Stream, assim toda a lógica de percorrer a lista é encapsulada. Se eu retornasse uma lista, a primeira operação só ocorreria quando toda a lista estivesse carregada na memória. Com o Stream, eu terei pequenas listas na memória e quando ela se esgota vai percorrendo as páginas.

# Como implementar?

Vamos abstrair o meu `StoreService`, certo? Vou apresentar ele como uma interface (na verdade ele é, só que usando [MicroProfile RestClient](https://github.com/eclipse/microprofile-rest-client) com [Quarkus](https://quarkus.io/guides/rest-client)):

```java
@Path("/")
@RegisterRestClient
public interface StoreService { 
    @GET
    @Path("/produtos")
    @Consumes(MediaType.APPLICATION_JSON)
    List<Produto> listarProdutos(@QueryParam("limit") int limit,
                                 @QueryParam("offset") int offset)
}
```

Configurado e validado que está funcionando corretamente é hora de começar a construir o Stream. O próximo passo e se perguntar qual é as caracteristicas principais desse Stream. Para isso recomendo ler a documentação do [Spliterator](https://docs.oracle.com/javase/8/docs/api/java/util/Spliterator.html), interface que é o coração de qualquer Stream. Dado as caracteristicas do meu Stream, vou considerar ele imutável, não nulo e com tamanho fixo.

Agora podemos implementar a classe que irá dar vida ao Stream. Para isso devemos basicamente implementar um método, o `tryAdvance`, ele deverá consumir um dos itens da lista de produtos e retornar se há ou não mais elementos. Segue abaixo uma tabela com os detalhes da implmentação por método.

| Método | Escolhas |
|--------|----------|
| `tryAdvance` | Irá consumir elementos da pilha. Se a pilha estiver vazia irá pedir uma nova página, se vier menos elementos que o requisitado, irá setar uma flag dizendo que acabou os elementos. |
| `trySplit` | Sempre retornará `null`, não será possível fazer processamento paralelo. |
| `estimateSize` | Será o tamanho da pilha mais uma página, se a última requisição voltar menos itens que uma página, será apenas o tamanho da pilha. |
| `characteristics` | Irá informar que esse Stream é imutável, com tamanho fixo e não nulo. |


Segue a implementação final:

```java
public class RemoteSpliterator implements Spliterator<Produto> {
    private static final Logger logger = LoggerFactory.getLogger(RemoteSpliterator .class);
    private statica final int LIMITE = 10; // tamanho da página

    private Queue<Produto> produtos;
    private boolean temMais;
    private int offsetAtual;
    private StoreService storeService;

    RemoteSpliterator (StoreService storeService) {
        produtos = new LinkedList<>();
        temMais = true;
        offsetAtual = 0;
        this.storeService = storeService; 
    }

    @Override
    public boolean tryAdvance(Consumer<? super Produto> action) {
        if (produtos.isEmpty()) {
            if (!temMais) {
                return false;
            } else {
                var produtosRemotos= storeService.listarProdutos(token, LIMITE, offsetAtual);
                temMais = produtosRemotos.size() == LIMITE;
                offsetAtual += produtosRemotos.size();
                logger.info("Produdos lidos do servidor: {}", produtosRemotos);
                produtos.addAll(produtosRemotos);
            }
        }

        if (produtos.isEmpty()) {
            return false;
        } else {
            action.accept(produtos.poll());
            return true;
        }
    }

    @Override
    public Spliterator<Produto> trySplit() {
        return null;
    }

    @Override
    public long estimateSize() {
        return temMais ? produtos.size() + LIMITE : produtos.size();
    }

    @Override
    public int characteristics() {
        return Spliterator.IMMUTABLE | Spliterator.SIZED | Spliterator.NONNULL;
    }
}
```

Para finalizar, precisamos apenas criar o Stream, isso pode se feito chamando o método [StreamSupport.stream](https://docs.oracle.com/javase/8/docs/api/java/util/stream/StreamSupport.html#stream-java.util.Spliterator-boolean-) usando o Spliterator criado como primeiro parâmetro e `false` como segundo parâmetro, já que ele não aceita processamento paralelo.

## Porque usei LinkedList?
Porque o acesso não será como em um array, mas em pilha. Apenas adicionarei itens no final a removereis itens do começo. Usar `ArrayList` tem um custo maior para adicionar e remover, enquanto sua vantagem está no acesso a itens que é em `O(1)`.

# Conclusão

Para se criar Streams não precisamos de ter todos os dados em mãos, essa é uma ferramenta poderosa que nos permite transformar qualquer fluxo de dados em uma API poderosa que irá agilizar a execução do seu código. 

Você não precisa resolver tudo em uma lista e depois criar o Stream.