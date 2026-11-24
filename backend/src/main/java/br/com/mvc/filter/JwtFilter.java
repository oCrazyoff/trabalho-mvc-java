package br.com.mvc.filter;

import br.com.mvc.config.JwtUtil;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.google.gson.Gson;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;
import java.util.Set;

@WebFilter("/api/*")
public class JwtFilter implements Filter {

    private static final Gson GSON = new Gson();

    // rotas que funcionam sem token
    private static final Set<String> ROTAS_PUBLICAS = Set.of("/api/login", "/api/cadastro");

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        // 1. Rotas públicas (sem token)
        String rota = req.getRequestURI().substring(req.getContextPath().length());
        if (ROTAS_PUBLICAS.contains(rota)) {
            chain.doFilter(request, response);
            return;
        }

        // 2. Lê o header "Authorization: Bearer <token>"
        String header = req.getHeader("Authorization");
        if (header == null || !header.startsWith("Bearer ")) {
            this.negar(resp, "Token não informado.");
            return;
        }

        // 3. Valida o token e guarda quem é o usuário para o servlet usar
        try {
            DecodedJWT jwt = JwtUtil.validar(header.substring(7));
            req.setAttribute("usuarioId", Long.valueOf(jwt.getSubject()));
            req.setAttribute("perfilId", jwt.getClaim("perfilId").asLong());
        } catch (JWTVerificationException e) {
            this.negar(resp, "Token inválido ou expirado.");
            return;
        }

        chain.doFilter(request, response);
    }

    // Resposta 401 no mesmo formato de erro da API
    private void negar(HttpServletResponse resp, String mensagem) throws IOException {
        resp.setStatus(401);
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.getWriter().write(GSON.toJson(Map.of("erro", mensagem)));
    }
}
