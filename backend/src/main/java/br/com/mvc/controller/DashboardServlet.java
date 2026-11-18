package br.com.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import br.com.mvc.service.DashboardService;

import java.io.IOException;

@WebServlet("/admin/dashboard")

public class DashboardServlet extends BaseServlet {

    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // pega as informações dos cards
        req.setAttribute("totalLivros", dashboardService.totalLivros());
        req.setAttribute("totalGeneros", dashboardService.totalGeneros());
        req.setAttribute("totalUsuarios", dashboardService.totalUsuarios());
        req.setAttribute("livroMaisRecomendado", dashboardService.maisRecomendado());

        // Dados dos Gráficos
        req.setAttribute("generosMaisPopulares", dashboardService.generosMaisPopulares());
        req.setAttribute("livrosPorGenero", dashboardService.livrosPorGenero());

        // passa para a view
        this.forward(req, resp, "/WEB-INF/jsp/admin/dashboard.jsp");
    }

}
