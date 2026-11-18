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

O Tailwind CSS é compilado pelo script `build` definido no `package.json` de cada projeto. O CSS deve ser gerado antes da criação do arquivo `.war` pelo Maven.

---

## 🧩 Arquitetura: frontend e backend

O projeto está sendo migrado de um monólito para uma **API REST**. Para isso, o código foi dividido em dois projetos, que **neste momento ainda são cópias idênticas do monólito**:

| Projeto | Pasta | Container | URL local | Papel futuro |
|---|---|---|---|---|
| Frontend | [`frontend/`](frontend/) | `mvc-java-frontend` | http://localhost:8080/mvc | Interface web (JSP), consumindo a API |
| Backend | [`backend/`](backend/) | `mvc-java-backend` | http://localhost:8082/mvc | API REST com acesso ao banco |

Cada projeto tem seu próprio `pom.xml`, `package.json` e `src/`, e gera seu próprio `deploy/mvc.war`. Cada um roda em um container Tomcat separado.

Os containers estão na mesma rede Docker (`mvc-network`). De dentro do frontend, o backend é acessado pelo nome do serviço: `http://backend:8080/mvc`. Esse endereço já está disponível no frontend pela variável de ambiente `BACKEND_URL`.

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

2. Em **cada** projeto (`frontend/` e `backend/`), instale as dependências, compile o CSS do Tailwind e gere o `.war`:

   ```bash
   cd frontend
   npm install
   npm run build
   mvn clean package

   cd ../backend
   npm install
   npm run build
   mvn clean package

   cd ..
   ```

   Os arquivos serão gerados em `frontend/deploy/mvc.war` e `backend/deploy/mvc.war`.

3. Na raiz do repositório, suba os containers do MySQL, frontend, backend e phpMyAdmin:

   ```bash
   docker compose up -d
   ```

4. Acesse as aplicações no navegador:

   ```text
   Frontend: http://localhost:8080/mvc
   Backend:  http://localhost:8082/mvc
   ```

5. Para acessar o phpMyAdmin:

   ```text
   http://localhost:8081
   ```

   Utilize `mysql` como servidor, `mvc_user` como usuário e `mvc123` como senha. O banco utilizado pela aplicação é `mvc_java`.

### Recompilação após alterações

Sempre que houver alterações em um dos projetos, execute dentro da pasta dele (`frontend/` ou `backend/`):

```bash
npm run build
mvn clean package
```

Não é necessário reiniciar os containers após as alterações. O Tomcat detecta o novo `deploy/mvc.war` do projeto e faz o redeploy automaticamente.

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
├── docker-compose.yml               # Serviços MySQL, frontend, backend e phpMyAdmin
├── init.sql                         # Modelo, estrutura e dados iniciais do banco (compartilhado)
├── frontend/                        # Projeto da interface web
│   ├── pom.xml                      # Configuração do Maven
│   ├── package.json                 # Dependências e scripts do Tailwind
│   ├── deploy/                      # WAR gerado pelo Maven (montado no container do frontend)
│   └── src/                         # Estrutura descrita abaixo
└── backend/                         # Projeto da API REST
    ├── pom.xml
    ├── package.json
    ├── deploy/                      # WAR gerado pelo Maven (montado no container do backend)
    └── src/                         # Estrutura descrita abaixo
```

Estrutura do `src/` (hoje igual nos dois projetos):

```text
src
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
