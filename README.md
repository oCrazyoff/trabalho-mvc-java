# Sistema de Recomendação de Leitura

Trabalho prático desenvolvido para a matéria **Aplicações para a Internet** sob a orientação do Professor Patrick.

## 👥 Integrantes do Grupo
* **Walysson** — RA: 5161362
* **Guilherme** — RA: 5160244

---

## 📌 Sobre o Projeto
O projeto é uma aplicação web baseada na arquitetura **MVC (Model-View-Controller)** desenvolvida em **Java**, utilizando **Servlets**, **JSP (JavaServer Pages)**, **JDBC** e persistência em **MySQL**. 

A plataforma permite que os usuários criem uma conta, selecionem seus gêneros literários favoritos e recebam recomendações de livros personalizadas com base em suas preferências.

---

## 🛠️ Tecnologias Utilizadas
* **Linguagem:** Java 17
* **Gerenciador de Dependências:** Apache Maven
* **Servidor Web / Servlet Container:** Apache Tomcat 10.1
* **Banco de Dados:** MySQL 8.0
* **Containerização:** Docker & Docker Compose

---

## 🗄️ Modelagem do Banco de Dados
Em desenvolvimento

---

## 🚀 Como Executar o Projeto com Docker

A maneira mais rápida de rodar a aplicação completa (Banco de Dados + Servidor Tomcat com a aplicação) é utilizando o **Docker Compose**.

### Pré-requisitos
* [Docker](https://www.docker.com/) instalado
* [Maven](https://maven.apache.org/download.cgi) instalado
* [JDK](https://www.oracle.com/java/technologies/downloads/) instalado
* Configure as variáveis de ambiênte

### Passos para execução:
1. Clone o repositório ou baixe os arquivos do projeto para o seu computador.
2. Na raiz do projeto (onde está o arquivo `docker-compose.yml`), execute o comando:

   ```bash
   docker compose up -d
   ```
3. O Docker irá subir o container do MySQL e, em seguida, compilar o projeto Java via Maven, empacotar o arquivo `.war` e executá-lo no Apache Tomcat.
4. Acesse a aplicação no navegador através do endereço:
   ```bash
   http://localhost:8080
   ```
5. Toda alteração deve ser compilada novamente:
   ```bash
   mvn clean package
   ```

---

## 📂 Estrutura de Diretórios
```
.
├── pom.xml
├── Dockerfile
├── docker-compose.yml
└── src
    └── main
        ├── java
        │   └── com
        │       └── leituras
        │           ├── controller
        │           ├── dao
        │           └── model
        └── webapp
            ├── WEB-INF
            │   └── web.xml
            ├── css
            └── *.jsp
```
