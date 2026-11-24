package br.com.mvc.controller;

import br.com.mvc.model.Livro;
import br.com.mvc.service.LivroService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/api/livros/*")
public class LivroServlet extends BaseServlet {

    private final LivroService livroService = new LivroService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] partes = this.caminho(req);

        if (partes.length == 0) {
            this.json(resp, 200, this.livroService.listaLivros());
            return;
        }

        Livro livro = this.livroService.buscarPorId(this.id(partes[0]));
        if (livro == null) {
            this.erro(resp, 404, "Livro não encontrado.");
            return;
        }
        this.json(resp, 200, livro);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.exigirAdmin(req);
        Livro livro = this.lerJson(req, Livro.class);
        livro.setId(null);
        this.livroService.salvar(livro);
        this.json(resp, 201, livro);
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.exigirAdmin(req);
        Long id = this.idObrigatorio(req);
        Livro livro = this.lerJson(req, Livro.class);
        livro.setId(id);
        this.livroService.salvar(livro);
        this.json(resp, 200, livro);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.exigirAdmin(req);
        this.livroService.deletar(this.idObrigatorio(req));
        resp.setStatus(204);
    }
}
