# Sistema de Recomendação de Leitura

Trabalho prático desenvolvido para a disciplina **Aplicações para a Internet**, sob a orientação do Professor Patrick.

## 👥 Integrantes do Grupo

- **Walysson** — RA: 5161362
- **Guilherme** — RA: 5160244

---

## 📌 Sobre o Projeto

O projeto é uma aplicação web de recomendação de livros desenvolvida em **Java** com **Servlets**, **JSP (JavaServer Pages)** e **JDBC**. Ele é dividido em dois projetos: uma **API REST** (backend), que concentra as regras de negócio e o acesso ao banco, e uma **interface web em JSP** (frontend), que consome essa API.

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
- **Formato de troca de dados:** JSON, com [Gson](https://github.com/google/gson)
- **Autenticação da API:** JWT (JSON Web Token), com [java-jwt](https://github.com/auth0/java-jwt)
- **Interface:** JSP, JSTL, CSS e [Tailwind CSS](https://tailwindcss.com/)
- **Gerenciador de dependências do frontend:** npm
- **Persistência:** JDBC
- **Banco de dados:** MySQL 8.4
- **Servidor web / Servlet container:** Apache Tomcat 10.1
- **Containerização:** Docker e Docker Compose
- **Administração do banco:** phpMyAdmin

O Tailwind CSS é usado apenas no frontend e é compilado pelo script `build` definido em `frontend/package.json`. O CSS deve ser gerado antes da criação do arquivo `.war` pelo Maven.

---

## 🧩 Arquitetura: frontend e backend

| Projeto | Pasta | Container | URL local | Responsabilidade |
|---|---|---|---|---|
| Frontend | [`frontend/`](frontend/) | `mvc-java-frontend` | http://localhost:8080/mvc | Telas em JSP, sessão do usuário e chamadas à API |
| Backend | [`backend/`](backend/) | `mvc-java-backend` | http://localhost:8082/mvc/api | API REST: recebe e devolve JSON, aplica as regras de negócio e acessa o MySQL |

```text
Navegador ──HTML──▶ Frontend (JSP) ──JSON + JWT──▶ Backend (API REST) ──JDBC──▶ MySQL
```

- **Frontend:** os *controllers* (servlets) leem os formulários e chamam os *services*. Os services não acessam o banco: eles fazem requisições HTTP à API por meio da classe `ApiClient`. O resultado é exibido nas páginas JSP.
- **Backend:** os servlets recebem JSON, chamam os *services* (regras de negócio), que usam os *DAOs* (SQL), e devolvem JSON. O backend não tem telas.
- Os containers estão na mesma rede Docker (`mvc-network`). O frontend acessa a API pelo endereço `http://backend:8080/mvc`, definido na variável de ambiente `BACKEND_URL`.

### Autenticação com JWT

1. O frontend envia login e senha para `POST /api/login`.
2. A API confere os dados e devolve um **token JWT** assinado, junto com os dados do usuário (sem a senha).
3. O frontend guarda o token na sessão e o envia em todas as requisições seguintes, no cabeçalho `Authorization: Bearer <token>`.
4. No backend, o filtro `JwtFilter` valida o token antes de qualquer rota `/api/*`, exceto `/api/login` e `/api/cadastro`. O token informa o ID e o perfil do usuário, usados para as permissões.
5. O token expira em 2 horas. Quando isso acontece, o frontend encerra a sessão e redireciona para o login.

A chave de assinatura do token é definida pela variável de ambiente `JWT_SECRET` do serviço `backend` no `docker-compose.yml`.

### Rotas da API

Todas as rotas começam com `http://localhost:8082/mvc`. Os erros sempre são devolvidos no formato `{"erro": "mensagem"}`.

| Método | Rota | Acesso | Descrição |
|---|---|---|---|
| POST | `/api/login` | Público | Autentica e devolve `{token, usuario}` |
| POST | `/api/cadastro` | Público | Cria um usuário leitor e devolve `{token, usuario}` |
| GET | `/api/livros` | Logado | Lista os livros |
| GET | `/api/livros/{id}` | Logado | Busca um livro (com os IDs dos gêneros) |
| POST | `/api/livros` | Admin | Cadastra um livro |
| PUT | `/api/livros/{id}` | Admin | Altera um livro |
| DELETE | `/api/livros/{id}` | Admin | Exclui um livro |
| GET | `/api/generos` | Logado | Lista os gêneros |
| GET | `/api/generos/{id}` | Logado | Busca um gênero |
| POST | `/api/generos` | Admin | Cadastra um gênero |
| PUT | `/api/generos/{id}` | Admin | Altera um gênero |
| DELETE | `/api/generos/{id}` | Admin | Exclui um gênero |
| GET | `/api/usuarios` | Admin | Lista os usuários |
| GET | `/api/usuarios/{id}` | Próprio usuário ou admin | Busca um usuário |
| POST | `/api/usuarios` | Admin | Cadastra um usuário (com qualquer perfil) |
| PUT | `/api/usuarios/{id}` | Admin | Altera um usuário (senha vazia mantém a atual) |
| DELETE | `/api/usuarios/{id}` | Admin | Exclui um usuário (não permite excluir a si mesmo) |
| GET | `/api/usuarios/{id}/generos` | Próprio usuário ou admin | Gêneros favoritos do usuário |
| POST | `/api/usuarios/{id}/generos/{generoId}` | Próprio usuário ou admin | Marca ou desmarca um gênero favorito |
| GET | `/api/usuarios/{id}/recomendados` | Próprio usuário ou admin | Livros recomendados para o usuário |
| GET | `/api/dashboard` | Admin | Totais e dados dos gráficos do painel |

**Códigos de resposta:** `200` sucesso · `201` criado · `204` excluído · `400` dados inválidos · `401` sem token, token inválido ou login incorreto · `403` sem permissão · `404` não encontrado · `500` erro interno.

Exemplo de uso (Git Bash):

```bash
# login: copie o "token" da resposta
curl -X POST http://localhost:8082/mvc/api/login \
     -H "Content-Type: application/json" -d '{"login":"admin","senha":"123456"}'

# listar livros com o token
curl http://localhost:8082/mvc/api/livros -H "Authorization: Bearer SEU_TOKEN"
```

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

As recomendações são calculadas a partir dessas duas tabelas: um livro é recomendado a um usuário quando possui pelo menos um gênero marcado como favorito por ele. Por isso, todo livro precisa ter ao menos um gênero.

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

2. Gere o `.war` do backend (API):

   ```bash
   cd backend
   mvn clean package
   cd ..
   ```

3. Gere o `.war` do frontend, compilando antes o CSS do Tailwind:

   ```bash
   cd frontend
   npm install
   npm run build
   mvn clean package
   cd ..
   ```

   Os arquivos serão gerados em `backend/deploy/mvc.war` e `frontend/deploy/mvc.war`.

4. Na raiz do repositório, suba os containers do MySQL, backend, frontend e phpMyAdmin:

   ```bash
   docker compose up -d
   ```

5. Acesse no navegador:

   ```text
   Aplicação (frontend): http://localhost:8080/mvc
   API (backend):        http://localhost:8082/mvc/api
   ```

6. Para acessar o phpMyAdmin:

   ```text
   http://localhost:8081
   ```

   Utilize `mysql` como servidor, `mvc_user` como usuário e `mvc123` como senha. O banco utilizado pela aplicação é `mvc_java`.

### Recompilação após alterações

- **Backend:** dentro de `backend/`, execute `mvn clean package`.
- **Frontend:** dentro de `frontend/`, execute `npm run build` e depois `mvn clean package`.

Não é necessário reiniciar os containers após as alterações. O Tomcat detecta o novo `deploy/mvc.war` do projeto e faz o redeploy automaticamente. A exceção é quando o `docker-compose.yml` muda (por exemplo, o `JWT_SECRET`): nesse caso, execute `docker compose up -d` para recriar o container.

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
├── docker-compose.yml               # Serviços MySQL, backend, frontend e phpMyAdmin
├── init.sql                         # Modelo, estrutura e dados iniciais do banco
├── backend/                         # API REST
│   ├── pom.xml                      # Dependências: Servlet, MySQL, Gson e java-jwt
│   ├── deploy/                      # WAR gerado pelo Maven (montado no container do backend)
│   └── src/main/java/br/com/mvc
│       ├── config                   # Conexão com o banco (MysqlSingleton) e geração/validação do JWT
│       ├── controller               # Servlets da API: recebem e devolvem JSON
│       ├── dao                      # Acesso e operações no banco de dados (SQL)
│       ├── filter                   # JwtFilter: exige um token válido nas rotas /api/*
│       ├── model                    # Entidades do domínio
│       └── service                  # Regras de negócio
└── frontend/                        # Interface web
    ├── pom.xml                      # Dependências: Servlet, JSTL e Gson
    ├── package.json                 # Dependências e scripts do Tailwind
    ├── deploy/                      # WAR gerado pelo Maven (montado no container do frontend)
    └── src/main
        ├── java/br/com/mvc
        │   ├── config               # ApiClient (chamadas HTTP à API) e exceção de sessão expirada
        │   ├── controller           # Servlets das telas: leem formulários e encaminham para os JSPs
        │   ├── filter               # Login obrigatório, acesso de admin e envio do token à API
        │   ├── model                # Objetos recebidos e enviados à API
        │   └── service              # Chamam as rotas da API
        └── webapp
            ├── WEB-INF
            │   ├── jsp
            │   │   ├── admin        # Telas administrativas (dashboard, livros, gêneros, usuários)
            │   │   ├── comum        # Telas para usuários comuns
            │   │   ├── cadastro.jsp
            │   │   ├── erro.jsp     # Página única de erros (404, 500, ...)
            │   │   ├── login.jsp
            │   │   └── welcome.jsp
            │   ├── tags             # Tags reutilizáveis, incluindo o layout
            │   └── web.xml          # Configuração da aplicação e das páginas de erro
            ├── css                  # Folhas de estilo, incluindo o CSS compilado do Tailwind
            ├── images               # Logos e imagens da aplicação
            └── index.jsp            # Página inicial
```

---

## 🔐 Usuários para teste

Os usuários abaixo são inseridos pelo script `init.sql`:

| Perfil | Login | Senha |
|---|---|---|
| Administrador | `admin` | `123456` |
| Comum | `joao` | `123456` |

> As credenciais são destinadas apenas ao ambiente de desenvolvimento.
