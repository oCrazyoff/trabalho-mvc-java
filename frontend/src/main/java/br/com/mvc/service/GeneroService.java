package br.com.mvc.service;

import br.com.mvc.config.ApiClient;
import br.com.mvc.model.Genero;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class GeneroService {

    private static final Type LISTA_GENEROS = new TypeToken<List<Genero>>() {
    }.getType();

    // lista apenas os generos do usuario
    public List<Genero> listarPorUsuario(Long usuarioId) {
        if (usuarioId == null)
            return List.of();
        List<Genero> generos = ApiClient.get("/api/usuarios/" + usuarioId + "/generos", LISTA_GENEROS);
        return generos != null ? generos : List.of();
    }

    // lista todos os generos
    public List<Genero> listarGeneros() {
        return ApiClient.get("/api/generos", LISTA_GENEROS);
    }

    // retorna os ids dos generos do usuario (calculado aqui, sem rota extra)
    public Set<Long> listarIdsPorUsuario(Long usuarioId) {
        return this.listarPorUsuario(usuarioId).stream()
                .map(Genero::getId)
                .collect(Collectors.toSet());
    }

    // a regra de "se tem remove, se não tem adiciona" agora fica no backend
    public boolean alternarGeneroUsuario(Long usuarioId, Long generoId) {
        JsonObject resposta = ApiClient.post(
                "/api/usuarios/" + usuarioId + "/generos/" + generoId, null, JsonObject.class);
        return resposta != null && resposta.has("vinculado") && resposta.get("vinculado").getAsBoolean();
    }

    public Genero buscarPorId(Long id) {
        if (id == null)
            return null;
        return ApiClient.get("/api/generos/" + id, Genero.class);
    }

    public void salvar(Genero genero) {
        if (genero.getId() == null) {
            ApiClient.post("/api/generos", genero, null);
        } else {
            ApiClient.put("/api/generos/" + genero.getId(), genero);
        }
    }

    public void deletar(Long id) {
        ApiClient.delete("/api/generos/" + id);
    }
}
