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

O Tailwind CSS é compilado a partir dos arquivos do frontend pelo script `build` definido no `package.json` de cada projeto. O CSS deve ser gerado antes da criação do arquivo `.war` pelo Maven.

---

## 🧩 Organização em Front e Backend

O repositório está dividido em dois projetos, cada um executado em seu próprio container Tomcat:

- **`backend/`** — será adaptado para uma **API REST** (Controller → Service → DAO) que retorna JSON;
- **`front/`** — será adaptado para consumir a API: os controllers requisitam o backend e usam o JSON retornado para montar as páginas JSP.

> Neste momento, as duas pastas ainda contêm a versão monolítica do sistema (a mesma do release anterior) e ambas acessam o mesmo banco MySQL. A adaptação para API será feita nas próximas etapas.

---

## 🗄️ Banco de Dados

O banco de dados já está modelado e sua definição está disponível no arquivo [`backend/init.sql`](backend/init.sql). O script cria o banco `mvc_java`, suas tabelas, índices, chaves estrangeiras e dados iniciais.

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

2. Compile o **backend** (CSS do Tailwind + arquivo `.war`):

   ```bash
   cd backend
   npm install
   npm run build
   mvn clean package
   cd ..
   ```

   O arquivo será gerado em `backend/deploy/mvc.war`.

3. Compile o **front**:

   ```bash
   cd front
   npm install
   npm run build
   mvn clean package
   cd ..
   ```

   O arquivo será gerado em `front/deploy/mvc.war`.

4. Suba os containers do MySQL, dos dois Tomcats (front e backend) e do phpMyAdmin:

   ```bash
   docker compose up -d
   ```

5. Acesse as aplicações no navegador:

   | Serviço | Endereço |
   |---|---|
   | Front | http://localhost:8080/mvc |
   | Backend | http://localhost:8081/mvc |
   | phpMyAdmin | http://localhost:8082 |

   No phpMyAdmin, utilize `mysql` como servidor, `mvc_user` como usuário e `mvc123` como senha. O banco utilizado pela aplicação é `mvc_java`.

### Recompilação após alterações

Sempre que houver alterações no frontend, nas páginas JSP ou no código Java, execute dentro da pasta do projeto alterado (`backend/` ou `front/`):

```bash
npm run build
mvn clean package
```

Não é necessário reiniciar os containers após as alterações: o Tomcat recarrega automaticamente o WAR atualizado gerado em `deploy/mvc.war` de cada projeto.

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
├── docker-compose.yml               # Serviços MySQL, Tomcat (front e backend) e phpMyAdmin
├── README.md
├── backend/                         # Projeto do backend (futura API REST)
│   ├── init.sql                     # Modelo, estrutura e dados iniciais do banco
│   ├── pom.xml                      # Configuração do Maven
│   ├── package.json                 # Dependências e scripts do frontend CSS
│   ├── package-lock.json
│   ├── deploy/                      # Arquivo WAR gerado pelo Maven
│   └── src/main/                    # Estrutura descrita abaixo
└── front/                           # Projeto do front (futuro consumidor da API)
    ├── pom.xml
    ├── package.json
    ├── package-lock.json
    ├── deploy/
    └── src/main/
```

Estrutura interna de cada projeto (`src/main`):

```text
src/main
├── java/br/com/mvc
│   ├── config       # Configurações e conexão com o banco
│   ├── controller   # Servlets e controle das requisições
│   ├── dao          # Acesso e operações no banco de dados
│   ├── filter       # Filtros de autenticação e autorização
│   ├── model        # Entidades do domínio
│   └── service      # Regras de negócio
└── webapp
    ├── WEB-INF
    │   ├── jsp
    │   │   ├── admin            # Telas administrativas (generos, livros, usuarios)
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
