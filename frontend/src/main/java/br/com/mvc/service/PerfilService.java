package br.com.mvc.service;

import br.com.mvc.config.ApiClient;
import br.com.mvc.model.Perfil;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.List;

public class PerfilService {

    private static final Type LISTA_PERFIS = new TypeToken<List<Perfil>>() {
    }.getType();

    public List<Perfil> listar() {
        return ApiClient.get("/api/perfis", LISTA_PERFIS);
    }

    public Perfil buscarPorId(Long id) {
        if (id == null)
            return null;
        return ApiClient.get("/api/perfis/" + id, Perfil.class);
    }

    public void salvar(Perfil perfil) {
        if (perfil.getId() == null) {
            ApiClient.post("/api/perfis", perfil, null);
        } else {
            ApiClient.put("/api/perfis/" + perfil.getId(), perfil);
        }
    }

    public void deletar(Long id) {
        ApiClient.delete("/api/perfis/" + id);
    }
}
