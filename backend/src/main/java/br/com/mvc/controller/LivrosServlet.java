package br.com.mvc.controller;

import java.io.IOException;
import java.util.List;

import br.com.mvc.model.Livro;
import br.com.mvc.model.Usuario;
import br.com.mvc.service.LivroService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/livros")

public class LivrosServlet extends BaseServlet {

    private final LivroService livroService = new LivroService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. Recupera a sessão atual do usuário
        HttpSession session = req.getSession(false);
        Usuario usuarioLogado = (session != null) ? (Usuario) session.getAttribute("usuarioLogado") : null;

        // 2. Busca todos os livros do usuario
        List<Livro> livros = this.livroService.listaLivros();
        req.setAttribute("livros", livros);

        // 3. Encaminha para o JSP desenhar na tela
        this.forward(req, resp, "/WEB-INF/jsp/comum/livros.jsp");

    }

}
