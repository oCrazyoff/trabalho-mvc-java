package br.com.mvc.controller;

import br.com.mvc.service.GeneroService;
import br.com.mvc.service.LivroService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

@WebServlet("/api/usuarios/*")
public class UsuarioServlet extends BaseServlet {

    private final GeneroService generoService = new GeneroService();
    private final LivroService livroService = new LivroService();

    // GET /api/usuarios/{id}/generos -> gêneros favoritos
    // GET /api/usuarios/{id}/recomendados -> livros recomendados
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] partes = this.caminho(req);

        if (partes.length == 2) {
            Long usuarioId = this.id(partes[0]);
            this.exigirProprioUsuario(req, usuarioId);

            if (partes[1].equals("generos")) {
                this.json(resp, 200, this.generoService.listarPorUsuario(usuarioId));
                return;
            }

            if (partes[1].equals("recomendados")) {
                this.json(resp, 200, this.livroService.listarRecomendados(usuarioId));
                return;
            }
        }

        this.erro(resp, 404, "Rota não encontrada.");
    }

    // POST /api/usuarios/{id}/generos/{generoId} -> marca ou desmarca o gênero
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] partes = this.caminho(req);

        if (partes.length == 3 && partes[1].equals("generos")) {
            Long usuarioId = this.id(partes[0]);
            Long generoId = this.id(partes[2]);
            this.exigirProprioUsuario(req, usuarioId);

            boolean vinculado = this.generoService.alternarGeneroUsuario(usuarioId, generoId);
            this.json(resp, 200, Map.of("vinculado", vinculado));
            return;
        }

        this.erro(resp, 404, "Rota não encontrada.");
    }

    // o usuário só acessa os próprios dados, exceto o admin
    private void exigirProprioUsuario(HttpServletRequest req, Long usuarioId) {
        Long perfilId = (Long) req.getAttribute("perfilId");
        boolean isAdmin = perfilId != null && perfilId == 1L;

        if (!isAdmin && !usuarioId.equals(this.usuarioLogadoId(req))) {
            throw new SecurityException("Você não pode acessar dados de outro usuário.");
        }
    }
}
