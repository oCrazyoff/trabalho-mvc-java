package br.com.mvc.config;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import java.io.IOException;
import java.lang.reflect.Type;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;

public class ApiClient {

    private static final String BASE_URL = System.getenv().getOrDefault("BACKEND_URL", "http://localhost:8082/mvc");

    private static final HttpClient HTTP = HttpClient.newHttpClient();
    private static final Gson GSON = new Gson();

    // token da requisição atual (preenchido pelo TokenFilter)
    private static final ThreadLocal<String> TOKEN = new ThreadLocal<>();

    public static void definirToken(String token) {
        TOKEN.set(token);
    }

    public static void limparToken() {
        TOKEN.remove();
    }

    public static <T> T get(String caminho, Type tipo) {
        return enviar("GET", caminho, null, tipo);
    }

    public static <T> T post(String caminho, Object corpo, Type tipo) {
        return enviar("POST", caminho, corpo, tipo);
    }

    public static void put(String caminho, Object corpo) {
        enviar("PUT", caminho, corpo, null);
    }

    public static void delete(String caminho) {
        enviar("DELETE", caminho, null, null);
    }

    private static <T> T enviar(String metodo, String caminho, Object corpo, Type tipo) {
        // monta a requisição e transforma em JSON
        HttpRequest.BodyPublisher body = (corpo == null)
                ? HttpRequest.BodyPublishers.noBody()
                : HttpRequest.BodyPublishers.ofString(GSON.toJson(corpo), StandardCharsets.UTF_8);

        // pega o token
        String token = TOKEN.get();

        // monta o cabeçalho
        HttpRequest.Builder builder = HttpRequest.newBuilder(URI.create(BASE_URL + caminho))
                .header("Content-Type", "application/json; charset=UTF-8")
                .header("Accept", "application/json")
                .method(metodo, body);

        // se tiver token adiciona no cabeçalho
        if (token != null) {
            builder.header("Authorization", "Bearer " + token);
        }

        try {
            // envia a requisição e recebe a resposta
            HttpResponse<String> resp = HTTP.send(builder.build(),
                    HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));
            int status = resp.statusCode();

            // lida com todos codigos de erro

            // 401 com token = sessão vencida; sem token = login inválido
            if (status == 401) {
                if (token != null) {
                    throw new SessaoExpiradaException();
                }
                throw new IllegalArgumentException(lerErro(resp.body()));
            }

            if (status == 404) {
                return null;
            }

            if (status >= 400 && status < 500) {
                throw new IllegalArgumentException(lerErro(resp.body()));
            }

            if (status >= 500) {
                throw new RuntimeException("Erro no servidor da API: " + lerErro(resp.body()));
            }

            if (tipo == null || resp.body() == null || resp.body().isBlank()) {
                return null;
            }

            // transforma em objeto
            return GSON.fromJson(resp.body(), tipo);

        } catch (IOException e) {
            throw new RuntimeException("Não foi possível conectar à API em " + BASE_URL, e);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new RuntimeException("Requisição à API interrompida.", e);
        }
    }

    // lê a mensagem do JSON de erro: {"erro": "..."}
    private static String lerErro(String body) {
        try {
            return GSON.fromJson(body, JsonObject.class).get("erro").getAsString();
        } catch (Exception e) {
            return "Erro inesperado na API.";
        }
    }
}
