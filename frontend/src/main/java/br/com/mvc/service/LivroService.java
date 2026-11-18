package br.com.mvc.service;

import br.com.mvc.config.ApiClient;
import br.com.mvc.model.Livro;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.List;

public class LivroService {

    // Necessário para o Gson saber que é uma List<Livro> (e não uma lista genérica)
    private static final Type LISTA_LIVROS = new TypeToken<List<Livro>>() {
    }.getType();

    public List<Livro> listarRecomendados(Long usuarioId) {
        if (usuarioId == null)
            return List.of();
        return ApiClient.get("/api/usuarios/" + usuarioId + "/recomendados", LISTA_LIVROS);
    }

    public List<Livro> listaLivros() {
        return ApiClient.get("/api/livros", LISTA_LIVROS);
    }

    public Livro buscarPorId(Long id) {
        if (id == null)
            return null;
        return ApiClient.get("/api/livros/" + id, Livro.class);
    }

    public void salvar(Livro livro) {
        if (livro.getId() == null) {
            ApiClient.post("/api/livros", livro, null);
        } else {
            ApiClient.put("/api/livros/" + livro.getId(), livro);
        }
    }

    public void deletar(Long id) {
        ApiClient.delete("/api/livros/" + id);
    }
}
