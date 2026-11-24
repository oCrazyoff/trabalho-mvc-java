package br.com.mvc.config;

import br.com.mvc.model.Usuario;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.auth0.jwt.interfaces.JWTVerifier;

import java.time.Instant;
import java.time.temporal.ChronoUnit;

public class JwtUtil {

    private static final String SEGREDO = System.getenv().getOrDefault("JWT_SECRET",
            "segredo-apenas-para-desenvolvimento-local");
    private static final String EMISSOR = "lumina-api";
    private static final long HORAS_VALIDADE = 2;

    private static final Algorithm ALGORITMO = Algorithm.HMAC256(SEGREDO);
    private static final JWTVerifier VERIFICADOR = JWT.require(ALGORITMO).withIssuer(EMISSOR).build();

    // gera o token com id, nome e perfil do usuário
    public static String gerarToken(Usuario usuario) {
        Instant agora = Instant.now();
        return JWT.create()
                .withIssuer(EMISSOR)
                .withSubject(String.valueOf(usuario.getId()))
                .withClaim("nome", usuario.getNome())
                .withClaim("perfilId", usuario.getPerfilId())
                .withIssuedAt(agora)
                .withExpiresAt(agora.plus(HORAS_VALIDADE, ChronoUnit.HOURS))
                .sign(ALGORITMO);
    }

    // confere assinatura, emissor e validade do token
    public static DecodedJWT validar(String token) throws JWTVerificationException {
        return VERIFICADOR.verify(token);
    }
}
