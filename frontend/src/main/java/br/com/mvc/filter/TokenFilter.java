package br.com.mvc.filter;

import br.com.mvc.config.ApiClient;
import br.com.mvc.config.SessaoExpiradaException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class TokenFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // 1. pega o token da sessão para o ApiClient usar nesta requisição
        String token = (session != null) ? (String) session.getAttribute("token") : null;
        ApiClient.definirToken(token);

        try {
            chain.doFilter(request, response);
        } catch (SessaoExpiradaException e) {
            // 2. token vencido: encerra a sessão e volta para o login
            if (session != null) {
                session.invalidate();
            }
            resp.sendRedirect(req.getContextPath() + "/login");
        } finally {
            // 3. limpa o token, pois o Tomcat reaproveita as threads
            ApiClient.limparToken();
        }
    }
}
