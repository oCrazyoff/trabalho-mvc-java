package br.com.mvc.controller;

import br.com.mvc.model.Usuario;
import br.com.mvc.service.UsuarioService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/cadastro")
public class CadastroServlet extends BaseServlet {

    private static final String VIEW = "/WEB-INF/jsp/cadastro.jsp";
    private final UsuarioService usuarioService = new UsuarioService();

    // 1. Função para exibir a página de formulário de cadastro
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Se já estiver logado, redireciona para o início
        if (req.getSession(false) != null && req.getSession(false).getAttribute("usuarioLogado") != null) {
            this.redirect(req, resp, "/inicio");
            return;
        }

        this.forward(req, resp, VIEW);
    }

    // 2. Função para processar o cadastro e efetuar login automático do novo usuário
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        Usuario usuario = new Usuario();
        usuario.setNome(this.param(req, "nome"));
        usuario.setLogin(this.param(req, "login"));
        usuario.setSenha(this.param(req, "senha"));

        // Perfil fixado no backend: 2 = Comum (Leitor)
        usuario.setPerfilId(2L);

        try {
            // Valida se login já existe, senha mínima de 6 dígitos, etc.
            this.usuarioService.salvar(usuario);

            // Busca o usuário recém-criado no banco
            Usuario usuarioLogado = this.usuarioService.autenticar(usuario.getLogin(), usuario.getSenha());

            // Opção: Já inicia a sessão do usuário recém-cadastrado e manda pro início
            req.getSession(true).setAttribute("usuarioLogado", usuarioLogado);
            this.redirect(req, resp, "/inicio");

        } catch (IllegalArgumentException e) {
            // Em caso de erro (ex: login repetido, senha curta), volta pra tela com a
            // mensagem
            req.setAttribute("erro", e.getMessage());
            req.setAttribute("usuario", usuario);
            this.forward(req, resp, VIEW);
        }
    }
}