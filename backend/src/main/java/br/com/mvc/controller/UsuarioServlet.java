package br.com.mvc.controller;

import br.com.mvc.model.Usuario;
import br.com.mvc.service.GeneroService;
import br.com.mvc.service.LivroService;
import br.com.mvc.service.UsuarioService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/api/usuarios/*")
public class UsuarioServlet extends BaseServlet {

    private final UsuarioService usuarioService = new UsuarioService();
    private final GeneroService generoService = new GeneroService();
    private final LivroService livroService = new LivroService();

    // GET /api/usuarios -> lista (admin)
    // GET /api/usuarios/{id} -> um usuário
    // GET /api/usuarios/{id}/generos -> gêneros favoritos
    // GET /api/usuarios/{id}/recomendados -> livros recomendados
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] partes = this.caminho(req);

        if (partes.length == 0) {
            this.exigirAdmin(req);
            List<Usuario> usuarios = this.usuarioService.listar();
            usuarios.forEach(u -> u.setSenha(null));
            this.json(resp, 200, usuarios);
            return;
        }

        Long usuarioId = this.id(partes[0]);
        this.exigirProprioUsuario(req, usuarioId);

        if (partes.length == 1) {
            Usuario usuario = this.usuarioService.buscarPorId(usuarioId);
            if (usuario == null) {
                this.erro(resp, 404, "Usuário não encontrado.");
                return;
            }
            usuario.setSenha(null);
            this.json(resp, 200, usuario);
            return;
        }

        if (partes.length == 2 && partes[1].equals("generos")) {
            this.json(resp, 200, this.generoService.listarPorUsuario(usuarioId));
            return;
        }

        if (partes.length == 2 && partes[1].equals("recomendados")) {
            this.json(resp, 200, this.livroService.listarRecomendados(usuarioId));
            return;
        }

        this.erro(resp, 404, "Rota não encontrada.");
    }

    // POST /api/usuarios -> cadastra (admin)
    // POST /api/usuarios/{id}/generos/{generoId} -> marca ou desmarca o gênero
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] partes = this.caminho(req);

        if (partes.length == 0) {
            this.exigirAdmin(req);
            Usuario usuario = this.lerJson(req, Usuario.class);
            usuario.setId(null);
            this.usuarioService.salvar(usuario);
            usuario.setSenha(null);
            this.json(resp, 201, usuario);
            return;
        }

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

    // PUT /api/usuarios/{id} -> altera (admin); senha vazia mantém a atual
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.exigirAdmin(req);
        Long id = this.idObrigatorio(req);

        Usuario usuario = this.lerJson(req, Usuario.class);
        usuario.setId(id);

        if (usuario.getSenha() == null || usuario.getSenha().isBlank()) {
            Usuario atual = this.usuarioService.buscarPorId(id);
            if (atual == null) {
                this.erro(resp, 404, "Usuário não encontrado.");
                return;
            }
            usuario.setSenha(atual.getSenha());
        }

        this.usuarioService.salvar(usuario);
        usuario.setSenha(null);
        this.json(resp, 200, usuario);
    }

    // DELETE /api/usuarios/{id} -> exclui (admin)
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.exigirAdmin(req);
        Long id = this.idObrigatorio(req);

        if (id.equals(this.usuarioLogadoId(req))) {
            throw new IllegalArgumentException("Você não pode excluir o próprio usuário.");
        }

        this.usuarioService.deletar(id);
        resp.setStatus(204);
    }

    // o usuário só acessa os próprios dados, exceto o admin
    private void exigirProprioUsuario(HttpServletRequest req, Long usuarioId) {
        if (!this.isAdmin(req) && !usuarioId.equals(this.usuarioLogadoId(req))) {
            throw new SecurityException("Você não pode acessar dados de outro usuário.");
        }
    }
}
