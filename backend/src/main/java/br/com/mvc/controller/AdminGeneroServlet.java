package br.com.mvc.controller;

import br.com.mvc.model.Genero;
import br.com.mvc.service.GeneroService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/generos")
public class AdminGeneroServlet extends BaseServlet {

    private static final String LISTA = "/WEB-INF/jsp/admin/generos/lista.jsp";
    private static final String FORM = "/WEB-INF/jsp/admin/generos/form.jsp";

    private final GeneroService generoService = new GeneroService();

    // 1. Função para rotear ações GET de gêneros (listar, novo, editar por ID, excluir por ID)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        switch (this.acao(req)) {
            case "novo" -> this.form(req, resp, null);
            case "editar" -> this.form(req, resp, this.generoService.buscarPorId(this.paramLong(req, "id")));
            case "excluir" -> {
                this.generoService.deletar(this.paramLong(req, "id"));
                this.redirect(req, resp, "/admin/generos");
            }
            default -> {
                req.setAttribute("generos", this.generoService.listarGeneros());
                this.forward(req, resp, LISTA);
            }
        }
    }

    // 2. Função para salvar ou editar o gênero com base nos dados enviados
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Genero genero = this.fromRequest(req);

        try {
            this.generoService.salvar(genero);
            this.redirect(req, resp, "/admin/generos");
        } catch (IllegalArgumentException e) {
            req.setAttribute("erro", e.getMessage());
            this.form(req, resp, genero);
        }
    }

    // metodo para popular o form
    private void form(HttpServletRequest req, HttpServletResponse resp, Genero genero)
            throws ServletException, IOException {
        req.setAttribute("genero", genero);
        this.forward(req, resp, FORM);
    }

    // metodo auxiliar para popular os setter
    private Genero fromRequest(HttpServletRequest req) {
        Genero genero = new Genero();
        genero.setId(this.paramLong(req, "id"));
        genero.setNome(this.param(req, "nome"));
        genero.setDescricao(this.param(req, "descricao"));
        return genero;
    }
}