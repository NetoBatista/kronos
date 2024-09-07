# Kronos

É uma aplicação de rastreamento de logs que permite acompanhar os registros e a saúde das suas aplicações.

## Tecnologias

É utilizado C# com .NET 8 nas aplicações frontend e backend.

**Frontend:**
* Blazor WebAssembly
* SimpleAutoMapper

**Backend:**
* EntityFrameworkCore
* PostgreSQL
* SimpleAutoMapper
* Azure ServiceBus

## Como executar

O projeto pode ser executado hospedado em algum serviço de nuvem (AWS ou Azure) ou localmente, mesmo para aplicações em produção. Para a hospedagem local, é necessário configurar o Service Bus nas suas aplicações. Sobre o Service Bus, consulte [saiba mais sobre Service Bus](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview) e [preços do serviço](https://azure.microsoft.com/en-us/pricing/details/service-bus/?msockid=2475d1f678b7690d2f2fc50479e668ce).

A pasta raiz contém um `docker-compose.yml`. Basta executar o comando `docker compose up -d` e todas as dependências necessárias serão instaladas e iniciadas automaticamente. Depois, acesse `http://localhost:8005`.

**O que será instalado:**
* Postgres na porta **54321**
* Kronos server na porta **8006**
* Kronos client na porta **8005**

As portas podem ser alteradas no arquivo `docker-compose.yml` conforme a sua necessidade. No entanto, é necessário ajustar o `Dockerfile` dentro do projeto `client` para informar a nova porta do servidor, caso a porta do servidor seja alterada no arquivo `docker-compose.yml`.

Caso necessário, você pode ajustar a url do banco de dados do servidor diretamente no arquivo `docker-compose.yml` na variável `CONNECTION_STRING`.

## Opcional

Há algumas configurações adicionais que podem ser realizadas no projeto `server`, como a configuração da variável de conexão do banco de dados e a configuração para utilização do Azure Service Bus.

Essas configurações estão contidas nos arquivos `appsettings.json` e `appsettings.Development.json`.

* **Database**
    * **ConnectionString** é a URL do banco de dados que o serviço utilizará. Por padrão, será `Host=localhost;Database=kronos;Username=postgres;Password=Senha123!`
* **Queue**
    * **ServiceBus**
        * **ConnectionString** é a string de conexão do serviço, que será fornecida na plataforma da Azure.
        * **Name** é o nome da fila que será utilizada.

*Observação: caso seja configurado a connection string na varíavel ambiente `CONNECTION_STRING`, a configuração do banco de dados no appsettings.json será igorada*

## Preview
https://github.com/user-attachments/assets/e409e819-238d-4a3d-bce4-900ca38aff7a

