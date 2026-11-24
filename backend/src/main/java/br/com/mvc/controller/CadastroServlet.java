package br.com.mvc.controller;

import br.com.mvc.model.Usuario;
import br.com.mvc.service.UsuarioService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/api/cadastro")
public class CadastroServlet extends BaseServlet {

    private static final Long PERFIL_COMUM = 2L;

    private final UsuarioService usuarioService = new UsuarioService();

    // POST /api/cadastro (rota pública) -> cria um leitor e já devolve o token
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Usuario usuario = this.lerJson(req, Usuario.class);

        // o perfil é sempre definido aqui, nunca pelo cliente
        usuario.setId(null);
        usuario.setPerfilId(PERFIL_COMUM);

        this.usuarioService.salvar(usuario);

        Usuario cadastrado = this.usuarioService.autenticar(usuario.getLogin(), usuario.getSenha());
        this.responderComToken(resp, 201, cadastrado);
    }
}
