package br.com.mvc.controller;

import java.io.IOException;
import java.util.List;

import br.com.mvc.model.Genero;
import br.com.mvc.model.Usuario;
import br.com.mvc.service.GeneroService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/generos")

public class GenerosServlet extends BaseServlet {

    private final GeneroService generoService = new GeneroService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. Recupera a sessão atual do usuário
        HttpSession session = req.getSession(false);
        Usuario usuarioLogado = (session != null) ? (Usuario) session.getAttribute("usuarioLogado") : null;

        // 2. Se o usuário estiver logado, busca todos os generos
        if (usuarioLogado != null) {

            List<Genero> generos = this.generoService.listarGeneros();
            req.setAttribute("generos", generos);

        }

        // 3. Encaminha para o JSP desenhar na tela
        this.forward(req, resp, "/WEB-INF/jsp/comum/generos.jsp");

    }

}
