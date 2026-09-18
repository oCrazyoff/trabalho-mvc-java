# Sistema de Recomendação de Leitura

Trabalho prático desenvolvido para a disciplina **Aplicações para a Internet**, sob a orientação do Professor Patrick.

## 👥 Integrantes do Grupo

- **Walysson** — RA: 5161362
- **Guilherme** — RA: 5160244

---

## 📌 Sobre o Projeto

O projeto é uma aplicação web de recomendação de livros baseada na arquitetura **MVC (Model-View-Controller)**, desenvolvida em **Java** com **Servlets**, **JSP (JavaServer Pages)** e **JDBC**.

A plataforma permite:

- autenticação de usuários;
- cadastro de novos usuários;
- gerenciamento de livros e gêneros literários;
- seleção de gêneros favoritos;
- consulta de livros por gênero;
- recomendações baseadas nas preferências dos usuários;
- gerenciamento administrativo de livros, gêneros e usuários.

---

## 🛠️ Tecnologias Utilizadas

- **Linguagem:** Java 17
- **Gerenciador de dependências:** Apache Maven
- **API Web:** Jakarta Servlet 6.0
- **Interface:** JSP, JSTL, CSS e [Tailwind CSS](https://tailwindcss.com/)
- **Gerenciador de dependências do frontend:** npm
- **Persistência:** JDBC
- **Banco de dados:** MySQL 8.4
- **Servidor web / Servlet container:** Apache Tomcat 10.1
- **Containerização:** Docker e Docker Compose
- **Administração do banco:** phpMyAdmin

O Tailwind CSS é compilado a partir dos arquivos do frontend pelo script `build` definido no `package.json`. O CSS deve ser gerado antes da criação do arquivo `.war` pelo Maven.

---

## 🗄️ Banco de Dados

O banco de dados já está modelado e sua definição está disponível no arquivo [`init.sql`](init.sql). O script cria o banco `mvc_java`, suas tabelas, índices, chaves estrangeiras e dados iniciais.

### Principais tabelas

- `usuarios`: armazena os usuários do sistema e seus perfis de acesso;
- `perfis`: define os perfis **Administrador** e **Comum**;
- `livros`: armazena os dados bibliográficos dos livros;
- `generos`: contém os gêneros literários disponíveis;
- `usuario_generos`: relaciona usuários aos seus gêneros favoritos;
- `livro_generos`: relaciona livros aos seus respectivos gêneros.

As tabelas `usuario_generos` e `livro_generos` representam relacionamentos muitos-para-muitos. O banco também possui restrições de unicidade para nomes de gêneros, ISBNs e logins de usuários, além de chaves estrangeiras para garantir a integridade dos relacionamentos.

> O arquivo `init.sql` é executado automaticamente pelo container do MySQL na primeira inicialização do volume do banco.

---

## 🚀 Como Executar o Projeto com Docker

### Pré-requisitos

- [Docker](https://www.docker.com/) instalado;
- [Node.js e npm](https://nodejs.org/) instalados;
- [Maven](https://maven.apache.org/download.cgi) instalado;
- [JDK 17](https://www.oracle.com/java/technologies/downloads/) ou superior instalado.

### Passos para execução

1. Clone o repositório:

   ```bash
   git clone https://github.com/oCrazyoff/trabalho-mvc-java.git
   cd trabalho-mvc-java
   ```

2. Instale as dependências do frontend:

   ```bash
   npm install
   ```

3. Compile os arquivos CSS do Tailwind:

   ```bash
   npm run build
   ```

4. Compile e empacote a aplicação como `.war`:

   ```bash
   mvn clean package
   ```

   O arquivo será gerado em `deploy/mvc.war`.

5. Suba os containers do MySQL, Tomcat e phpMyAdmin:

   ```bash
   docker compose up -d
   ```

6. Acesse a aplicação no navegador:

   ```text
   http://localhost:8080/mvc
   ```

7. Para acessar o phpMyAdmin:

   ```text
   http://localhost:8081
   ```

   Utilize `mysql` como servidor, `mvc_user` como usuário e `mvc123` como senha. O banco utilizado pela aplicação é `mvc_java`.

### Recompilação após alterações

Sempre que houver alterações no frontend, nas páginas JSP ou no código Java, execute:

```bash
npm run build
mvn clean package
```

Não é necessário executar `docker compose restart tomcat` após as alterações. Basta gerar novamente o CSS com `npm run build` e empacotar a aplicação com `mvn clean package`. O arquivo WAR atualizado será gerado em `deploy/mvc.war`.

### Encerrando os containers

```bash
docker compose down
```

Para remover também os dados persistidos do banco, use:

```bash
docker compose down -v
```

> O script `init.sql` é executado automaticamente apenas quando o volume `mysql_data` é criado. Para recriar o banco a partir do script, remova o volume com `docker compose down -v` antes de subir os containers novamente.

---

## 📂 Estrutura de Diretórios

```text
.
├── pom.xml                          # Configuração do Maven
├── package.json                     # Dependências e scripts do frontend CSS
├── package-lock.json
├── docker-compose.yml               # Serviços MySQL, Tomcat e phpMyAdmin
├── init.sql                         # Modelo, estrutura e dados iniciais do banco
├── deploy/                          # Arquivo WAR gerado pelo Maven
└── src
    └── main
        ├── java
        │   └── br
        │       └── com
        │           └── mvc
        │               ├── config       # Configurações e conexão com o banco
        │               ├── controller   # Servlets e controle das requisições
        │               ├── dao          # Acesso e operações no banco de dados
        │               ├── filter       # Filtros de autenticação e autorização
        │               ├── model        # Entidades do domínio
        │               └── service      # Regras de negócio
        └── webapp
            ├── WEB-INF
            │   ├── jsp
            │   │   ├── admin           # Telas administrativas
            │   │   │   ├── generos
            │   │   │   ├── livros
            │   │   │   └── usuarios
            │   │   ├── comum            # Telas para usuários comuns
            │   │   ├── cadastro.jsp
            │   │   ├── login.jsp
            │   │   └── welcome.jsp
            │   ├── tags                 # Tags reutilizáveis, incluindo o layout
            │   └── web.xml              # Configuração da aplicação web
            ├── css                      # Folhas de estilo, incluindo o CSS compilado do Tailwind
            ├── images                   # Logos e imagens da aplicação
            └── index.jsp                # Página inicial
```

---

## 🔐 Usuários para teste

Os usuários abaixo são inseridos pelo script `init.sql`:

| Perfil | Login | Senha |
|---|---|---|
| Administrador | `admin` | `123456` |
| Comum | `joao` | `123456` |

> As credenciais são destinadas apenas ao ambiente de desenvolvimento.
