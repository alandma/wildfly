# WildFly/JBoss

Criação de wildfly para rodar apps Java em modo padrão `standalone` todas as configurações do wildfly estão no arquivo `standalone.xml` e podem ser alteradas, conforme a necessidade do projeto.

O arquivo atual (standalone.xml) foi adicionado a configuração e os drivers para conectar a um banco de dados postgresql (`configs/org`).

A versão do JDK(Jboss base), Wildfly e Maven devem ser definidos com os seguintes _**args**_:

> **BASE_TAG**:  
Versão da base para o wildfly, isso ira definir o JDK base.
Para mais informações, ou versão desejada, consultar o dockerhub da [base JDK](https://hub.docker.com/r/jboss/base-jdk/tags).

> **WILDFLY_VERSION**:  
Define a versão do wildfly, verifique sempre qual JDK é necessario para cada versão do Wildfly.
Para mais informações, ou versão desejada, consultar as [versões do WildFly](https://docs.wildfly.org/).

> **MAVEN_TAG**: Versão que o Dockerfile vai utilizar para executar o container.
Para mais informações, ou versão desejada, consultar o dockerhub do [maven](https://hub.docker.com/_/maven?tab=tags).

## Pasta "deploys"
Se for efetuar a compilação direto de uma IDE, direcione os arquivos de _deploy_ para essa pasta e siga as instruções de [Via IDE](#Via-IDE)

Os arquivos adicionados à esta pasta (war|ear) serão adicionados a pasta `deployments` do wildfly.

## Pasta "configs"
Nessa pasta ficará o "standalone.xml", para configuração conforme desejado.

Tambem contem os arquivos de configuração de banco de dados que o wildfly irá conectar.

# Rodando o deploy
Há duas formas de efetuar o `deploy` do projeto a primeira é via o proprio `compose` (_docker-compose.yml_), através do serviço `app-build` (_comentado por padrão_).

## app-build

```bash
docker-compose up --build app-build
```
O `serviço` pega o codigo e envia via o `volumes` para o container executar de acordo com o que foi definido no `backend-build.dev.sh`, atualmente o conteudo dele é somente de exemplo.

O resultado é "armazenado" no volume `deploy-target`, dessa forma quando o serviço `wildly` for executar, vai utilizar esse volume para subir a app compilada.

## Via IDE
Outra forma é compilar a app via a IDE de preferência (VSCode, NetBeans, Eclipse e etc) o `Dockerfile` irá executar copiar (`COPY`, linha **26**) os seus arquivos compilados.

Assim, pode executar o serviço [`wildFly`](#Rodando-o-WildFly) sem o `app-build`.

# Rodando o WildFly
Após compilar o codigo rode o WildFly e acompanhe o log.

```bash
docker-compose up --build wildfly
```
## Adicionando usuario do console

O wildfly proporciona um console para administração, configuração e deploy através dele, mas para isso será necessario criar um usuario, que não é ativo/criado por padrão.

execute o script `add-user.sh` e siga as instruções.
```bash
./add-user.sh
```

# Remover containers

Para remover todos os containers do projeto, inclusive volumes e images, execute o comando abaixo.
```bash
docker-compose down -v --rmi local --remove-orphans
```
_Desta forma poderá executar novamente com "tudo limpo"._

#### Referencias
- https://hub.docker.com/r/jboss/wildfly
- https://hub.docker.com/r/jboss/base-jdk/
- https://hub.docker.com/_/maven/
- https://docs.wildfly.org/
- https://www.wildfly.org/downloads/
- https://docs.docker.com/compose/compose-file/compose-file-v3/
- https://docs.docker.com/engine/reference/builder/
- https://hub.docker.com/_/maven/
- https://maven.apache.org/ref/current/maven-embedder/cli.html
- https://docs.docker.com/compose/reference/up/
- https://docs.docker.com/compose/reference/down/
