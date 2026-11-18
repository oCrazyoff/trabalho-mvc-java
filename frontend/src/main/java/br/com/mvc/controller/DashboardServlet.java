package br.com.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import br.com.mvc.service.DashboardService;
import br.com.mvc.model.Dashboard;

import java.io.IOException;

@WebServlet("/admin/dashboard")

public class DashboardServlet extends BaseServlet {

    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // busca todos os dados do painel em uma única requisição à API
        Dashboard dashboard = this.dashboardService.carregar();

        // cards
        req.setAttribute("totalLivros", dashboard.getTotalLivros());
        req.setAttribute("totalGeneros", dashboard.getTotalGeneros());
        req.setAttribute("totalUsuarios", dashboard.getTotalUsuarios());
        req.setAttribute("livroMaisRecomendado", dashboard.getLivroMaisRecomendado());

        // gráficos
        req.setAttribute("generosMaisPopulares", dashboard.getGenerosMaisPopulares());
        req.setAttribute("livrosPorGenero", dashboard.getLivrosPorGenero());

        this.forward(req, resp, "/WEB-INF/jsp/admin/dashboard.jsp");
    }

}
