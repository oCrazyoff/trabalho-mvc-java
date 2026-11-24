package br.com.mvc.controller;

import br.com.mvc.service.DashboardService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/api/dashboard")
public class DashboardServlet extends BaseServlet {

    private final DashboardService dashboardService = new DashboardService();

    // GET /api/dashboard -> todos os dados do painel (admin)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.exigirAdmin(req);

        Map<String, Object> dados = new LinkedHashMap<>();

        // cards
        dados.put("totalLivros", this.dashboardService.totalLivros());
        dados.put("totalGeneros", this.dashboardService.totalGeneros());
        dados.put("totalUsuarios", this.dashboardService.totalUsuarios());
        dados.put("livroMaisRecomendado", this.dashboardService.maisRecomendado());

        // gráficos
        dados.put("generosMaisPopulares", this.dashboardService.generosMaisPopulares());
        dados.put("livrosPorGenero", this.dashboardService.livrosPorGenero());

        this.json(resp, 200, dados);
    }
}
