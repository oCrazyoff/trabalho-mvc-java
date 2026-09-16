package br.com.mvc.controller;

import br.com.mvc.model.Genero;
import br.com.mvc.model.Usuario;
import br.com.mvc.model.Livro;
import br.com.mvc.service.LivroService;
import br.com.mvc.service.GeneroService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/inicio")

public class InicioServlet extends BaseServlet {

    private final GeneroService generoService = new GeneroService();
    private final LivroService livroService = new LivroService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. Recupera a sessão atual do usuário
        HttpSession session = req.getSession(false);
        Usuario usuarioLogado = (session != null) ? (Usuario) session.getAttribute("usuarioLogado") : null;

        // 2. Se o usuário estiver logado, busca os gêneros dele
        if (usuarioLogado != null) {

            List<Genero> generos = this.generoService.listarPorUsuario(usuarioLogado.getId());
            req.setAttribute("generos", generos);

            List<Livro> recomendados = this.livroService.listarRecomendados(usuarioLogado.getId());
            req.setAttribute("livrosRecomendados", recomendados);

        }

        // 3. Encaminha para o JSP desenhar na tela
        this.forward(req, resp, "/WEB-INF/jsp/comum/inicio.jsp");
    }

}
