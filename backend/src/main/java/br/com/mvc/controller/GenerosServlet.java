package br.com.mvc.controller;

import java.io.IOException;
import java.util.List;
import java.util.Set;
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

    // GET
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. Recupera a sessão atual do usuário
        HttpSession session = req.getSession(false);
        Usuario usuarioLogado = (session != null) ? (Usuario) session.getAttribute("usuarioLogado") : null;

        // 2. Busca todos os generos
        List<Genero> generos = this.generoService.listarGeneros();
        Set<Long> generosSalvosIds = this.generoService.listarIdsPorUsuario(usuarioLogado.getId());

        req.setAttribute("generos", generos);
        req.setAttribute("generosSalvosIds", generosSalvosIds);

        // 3. Encaminha para o JSP desenhar na tela
        this.forward(req, resp, "/WEB-INF/jsp/comum/generos.jsp");

    }

    // POST
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Usuario usuarioLogado = (session != null) ? (Usuario) session.getAttribute("usuarioLogado") : null;

        Long generoId = this.paramLong(req, "generoId");

        if (generoId != null) {

            this.generoService.alternarGeneroUsuario(usuarioLogado.getId(), generoId);

        }

        // redireciona de volta para recarregar a lista
        this.redirect(req, resp, "/generos");
    }

}
