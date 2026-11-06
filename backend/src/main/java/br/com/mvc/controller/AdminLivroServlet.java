package br.com.mvc.controller;

import br.com.mvc.model.Livro;
import br.com.mvc.service.LivroService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/livros")
public class AdminLivroServlet extends BaseServlet {

    private static final String LISTA = "/WEB-INF/jsp/admin/livros/lista.jsp";
    private static final String FORM = "/WEB-INF/jsp/admin/livros/form.jsp";

    private final LivroService livroService = new LivroService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        switch (this.acao(req)) {
            case "novo" -> this.form(req, resp, null);

            case "editar" -> this.form(req, resp, this.livroService.buscarPorId(this.paramLong(req, "id")));

            case "excluir" -> {
                this.livroService.deletar(this.paramLong(req, "id"));
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

    // metodo form para popular o formulario
    private void form(HttpServletRequest req, HttpServletResponse resp, Livro livro)
            throws ServletException, IOException {
        req.setAttribute("livro", livro);
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

        String ano = this.param(req, "anoPublicacao");
        if (ano != null && !ano.isBlank()) {
            livro.setAnoPublicacao(Integer.valueOf(ano));
        }

        String paginas = this.param(req, "numPaginas");
        if (paginas != null && !paginas.isBlank()) {
            livro.setNumPaginas(Integer.valueOf(paginas));
        }

        livro.setCapaUrl(this.param(req, "capaUrl"));
        return livro;
    }
}