package br.com.mvc.controller;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

public abstract class BaseServlet extends HttpServlet {

    protected static final Gson GSON = new Gson();

    // configura a resposta como JSON e converte exceções em códigos HTTP
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");

        try {
            super.service(req, resp);
        } catch (SecurityException e) {
            this.erro(resp, 403, e.getMessage());
        } catch (JsonSyntaxException e) {
            this.erro(resp, 400, "JSON inválido.");
        } catch (IllegalArgumentException e) {
            this.erro(resp, 400, e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            this.erro(resp, 500, "Erro interno no servidor.");
        }
    }

    // converte o JSON do corpo da requisição em objeto
    protected <T> T lerJson(HttpServletRequest req, Class<T> tipo) throws IOException {
        T objeto = GSON.fromJson(req.getReader(), tipo);
        if (objeto == null) {
            throw new IllegalArgumentException("Corpo da requisição vazio.");
        }
        return objeto;
    }

    // escreve o objeto como JSON na resposta
    protected void json(HttpServletResponse resp, int status, Object corpo) throws IOException {
        resp.setStatus(status);
        if (corpo != null) {
            resp.getWriter().write(GSON.toJson(corpo));
        }
    }

    // resposta de erro padrão: {"erro": "mensagem"}
    protected void erro(HttpServletResponse resp, int status, String mensagem) throws IOException {
        this.json(resp, status, Map.of("erro", mensagem != null ? mensagem : "Erro."));
    }

    // "/api/livros/5" -> ["5"]
    protected String[] caminho(HttpServletRequest req) {
        String info = req.getPathInfo();
        if (info == null || info.equals("/")) {
            return new String[0];
        }
        return info.substring(1).split("/");
    }

    // converte um trecho da URL em ID
    protected Long id(String valor) {
        try {
            return Long.valueOf(valor);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("ID inválido.");
        }
    }

    // ID obrigatório na URL (PUT e DELETE)
    protected Long idObrigatorio(HttpServletRequest req) {
        String[] partes = this.caminho(req);
        if (partes.length == 0) {
            throw new IllegalArgumentException("Informe o ID na URL.");
        }
        return this.id(partes[0]);
    }

    // ID do usuário que veio no token
    protected Long usuarioLogadoId(HttpServletRequest req) {
        return (Long) req.getAttribute("usuarioId");
    }

    // bloqueia quem não é administrador
    protected void exigirAdmin(HttpServletRequest req) {
        Long perfilId = (Long) req.getAttribute("perfilId");
        if (perfilId == null || perfilId != 1L) {
            throw new SecurityException("Acesso restrito a administradores.");
        }
    }
}
