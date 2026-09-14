package br.com.mvc.controller;

import br.com.mvc.model.Usuario;
import br.com.mvc.service.UsuarioService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Controller de Login.
 * Ponte entre rota (/login), {@link UsuarioService} e a view.
 * Sem regra de negocio: so chama o service e encaminha o resultado.
 */
@WebServlet("/login")
public class LoginServlet extends BaseServlet {

    private static final String VIEW = "/WEB-INF/jsp/login.jsp";

    private final UsuarioService usuarioService = new UsuarioService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("usuarioLogado") != null) {

            // 1. Recupera o usuário que está guardado na sessão (com cast):
            Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
            // 2. Agora sim verifica o perfil:
            boolean isAdmin = (usuario.getPerfilId() != null && usuario.getPerfilId() == 1);
            if (isAdmin) {
                this.redirect(req, resp, "/dashboard");
            } else {
                this.redirect(req, resp, "/inicio");
            }

            if (isAdmin) {
                this.redirect(req, resp, "/dashboard");
            } else {
                this.redirect(req, resp, "/inicio");
            }

            return;
        }

        this.forward(req, resp, VIEW);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        try {
            Usuario usuario = this.usuarioService.autenticar(
                    this.param(req, "login"),
                    this.param(req, "senha"));

            req.getSession(true).setAttribute("usuarioLogado", usuario);

            // verificando se é admin ou não
            boolean isAdmin = (usuario.getPerfilId() != null && usuario.getPerfilId() == 1);

            if (isAdmin) {
                this.redirect(req, resp, "/dashboard");
            } else {
                this.redirect(req, resp, "/inicio");
            }

        } catch (IllegalArgumentException e) {
            req.setAttribute("erro", e.getMessage());
            this.forward(req, resp, VIEW);
        }
    }
}
