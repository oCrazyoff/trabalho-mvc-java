package br.com.mvc.service;

import br.com.mvc.config.ApiClient;
import br.com.mvc.model.Dashboard;

public class DashboardService {

    // uma única chamada traz todos os dados do painel
    public Dashboard carregar() {
        Dashboard dashboard = ApiClient.get("/api/dashboard", Dashboard.class);
        return dashboard != null ? dashboard : new Dashboard();
    }
}
