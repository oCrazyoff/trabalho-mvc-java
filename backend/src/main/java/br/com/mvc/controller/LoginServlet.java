package br.com.mvc.controller;

import br.com.mvc.config.JwtUtil;
import br.com.mvc.model.Usuario;
import br.com.mvc.service.UsuarioService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/api/login")
public class LoginServlet extends BaseServlet {

    private final UsuarioService usuarioService = new UsuarioService();

    // POST /api/login -> devolve o token e os dados do usuário
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Usuario credenciais = this.lerJson(req, Usuario.class);

        Usuario usuario;
        try {
            usuario = this.usuarioService.autenticar(credenciais.getLogin(), credenciais.getSenha());
        } catch (IllegalArgumentException e) {
            this.erro(resp, 401, e.getMessage());
            return;
        }

        String token = JwtUtil.gerarToken(usuario);
        usuario.setSenha(null);

        Map<String, Object> corpo = new LinkedHashMap<>();
        corpo.put("token", token);
        corpo.put("usuario", usuario);
        this.json(resp, 200, corpo);
    }
}
