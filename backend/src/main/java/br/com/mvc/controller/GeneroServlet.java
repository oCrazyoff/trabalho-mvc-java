package br.com.mvc.controller;

import br.com.mvc.model.Genero;
import br.com.mvc.service.GeneroService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/api/generos/*")
public class GeneroServlet extends BaseServlet {

    private final GeneroService generoService = new GeneroService();

    // GET /api/generos -> lista
    // GET /api/generos/{id} -> um gênero
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] partes = this.caminho(req);

        if (partes.length == 0) {
            this.json(resp, 200, this.generoService.listarGeneros());
            return;
        }

        Genero genero = this.generoService.buscarPorId(this.id(partes[0]));
        if (genero == null) {
            this.erro(resp, 404, "Gênero não encontrado.");
            return;
        }
        this.json(resp, 200, genero);
    }

    // POST /api/generos -> cadastra (admin)
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.exigirAdmin(req);
        Genero genero = this.lerJson(req, Genero.class);
        genero.setId(null);
        this.generoService.salvar(genero);
        this.json(resp, 201, genero);
    }

    // PUT /api/generos/{id} -> altera (admin)
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.exigirAdmin(req);
        Long id = this.idObrigatorio(req);
        Genero genero = this.lerJson(req, Genero.class);
        genero.setId(id);
        this.generoService.salvar(genero);
        this.json(resp, 200, genero);
    }

    // DELETE /api/generos/{id} -> exclui (admin)
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.exigirAdmin(req);
        this.generoService.deletar(this.idObrigatorio(req));
        resp.setStatus(204);
    }
}
