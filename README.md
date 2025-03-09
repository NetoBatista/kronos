# Kronos
É uma aplicação de rastreamento de logs que permite acompanhar os registros e a saúde das suas aplicações.

## Tecnologias
**Frontend:**
* FlutterWeb

**Backend:**
* EntityFrameworkCore
* PostgreSQL
* SimpleAutoMapper
* Azure ServiceBus

## Como executar

O projeto pode ser executado hospedado em algum serviço de nuvem (AWS ou Azure) ou localmente, mesmo para aplicações em produção. 

Pode ser necessário configurar o Service Bus nas suas aplicações. Sobre o Service Bus, consulte [saiba mais sobre Service Bus](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview) e [preços do serviço](https://azure.microsoft.com/en-us/pricing/details/service-bus/?msockid=2475d1f678b7690d2f2fc50479e668ce).

A pasta raiz contém um `docker-compose.yml`. Basta executar o comando `docker compose up -d` e todas as dependências necessárias serão instaladas e iniciadas automaticamente. Depois, acesse `http://localhost:8001`.

**O que será instalado:**
* Postgres na porta **54321**
* Servidor na porta **5001**
* Cliente na porta **8001**

As portas podem ser alteradas no arquivo `docker-compose.yml` conforme a sua necessidade.

Caso necessário, você pode ajustar a url do banco de dados do servidor diretamente no arquivo `docker-compose.yml` na variável `CONNECTION_STRING`.

## Opcional

Há algumas configurações adicionais que podem ser realizadas no projeto `Kronos/Kronos` onde é inicializado o servidor, como a configuração da variável de conexão do banco de dados e a configuração para utilização do Azure Service Bus.

Essas configurações estão contidas nos arquivos `appsettings.json` e `appsettings.Development.json`.

* **Database**
    * **ConnectionString** é a URL do banco de dados que o serviço utilizará. Por padrão, será `Host=localhost;Database=kronos;Username=postgres;Password=Senha123!`
* **Queue**
    * **ServiceBus**
        * **ConnectionString** é a string de conexão do serviço, que será fornecida na plataforma da Azure.
        * **Name** é o nome da fila que será utilizada.

*Observação: caso seja configurado a connection string na varíavel ambiente `CONNECTION_STRING`, a configuração do banco de dados no appsettings.json será igorada*