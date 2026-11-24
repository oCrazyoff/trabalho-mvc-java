package br.com.mvc.controller;

import br.com.mvc.model.Livro;
import br.com.mvc.service.GeneroService;
import br.com.mvc.service.LivroService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/livros")
public class AdminLivroServlet extends BaseServlet {

    private static final String LISTA = "/WEB-INF/jsp/admin/livros/lista.jsp";
    private static final String FORM = "/WEB-INF/jsp/admin/livros/form.jsp";

    private final LivroService livroService = new LivroService();
    private final GeneroService generoService = new GeneroService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        switch (this.acao(req)) {
            case "novo" -> this.form(req, resp, null);

            case "editar" -> this.form(req, resp, this.livroService.buscarPorId(this.paramLong(req, "id")));

            case "excluir" -> {
                try {
                    this.livroService.deletar(this.paramLong(req, "id"));
                } catch (IllegalArgumentException e) {
                    req.setAttribute("erro", e.getMessage());
                    req.setAttribute("livros", this.livroService.listaLivros());
                    this.forward(req, resp, LISTA);
                    return;
                }
                this.redirect(req, resp, "/admin/livros");
            }

            default -> {
                req.setAttribute("livros", this.livroService.listaLivros());
                this.forward(req, resp, LISTA);
            }
        }
    }

    @Override
    // quando o usuario quiser cadastrar um livro
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Livro livro = this.fromRequest(req);

        try {
            this.livroService.salvar(livro);
            this.redirect(req, resp, "/admin/livros");
        } catch (IllegalArgumentException e) {
            req.setAttribute("erro", e.getMessage());
            this.form(req, resp, livro);
        }
    }

    // metodo form para popular o formulario (com a lista de gêneros para marcar)
    private void form(HttpServletRequest req, HttpServletResponse resp, Livro livro)
            throws ServletException, IOException {
        req.setAttribute("livro", livro);
        req.setAttribute("generos", this.generoService.listarGeneros());
        this.forward(req, resp, FORM);
    }

    // metodo auxiliar para popular os setters
    private Livro fromRequest(HttpServletRequest req) {
        Livro livro = new Livro();
        livro.setId(this.paramLong(req, "id"));
        livro.setTitulo(this.param(req, "titulo"));
        livro.setAutor(this.param(req, "autor"));
        livro.setSinopse(this.param(req, "sinopse"));
        livro.setIsbn(this.param(req, "isbn"));
        livro.setEditora(this.param(req, "editora"));
        livro.setAnoPublicacao(this.paramInteger(req, "anoPublicacao"));
        livro.setNumPaginas(this.paramInteger(req, "numPaginas"));
        livro.setCapaUrl(this.param(req, "capaUrl"));

        // checkboxes de gêneros: vários valores com o mesmo nome
        List<Long> generosIds = new ArrayList<>();
        String[] marcados = req.getParameterValues("generosIds");
        if (marcados != null) {
            for (String valor : marcados) {
                try {
                    generosIds.add(Long.valueOf(valor));
                } catch (NumberFormatException e) {
                    // ignora valores inválidos
                }
            }
        }
        livro.setGenerosIds(generosIds);

        return livro;
    }

    // converte o parâmetro para Integer (null se vazio ou inválido)
    private Integer paramInteger(HttpServletRequest req, String nome) {
        String valor = this.param(req, nome);
        if (valor == null || valor.isBlank()) {
            return null;
        }
        try {
            return Integer.valueOf(valor.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
