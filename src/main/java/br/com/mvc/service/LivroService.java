package br.com.mvc.service;

import br.com.mvc.dao.LivroDAO;
import br.com.mvc.model.Livro;
import java.util.List;

public class LivroService {

    private final LivroDAO livroDAO = new LivroDAO();

    public List<Livro> listarRecomendados(Long usuarioId) {

        if (usuarioId == null) {

            return List.of();

        }

        return this.livroDAO.listarRecomendados(usuarioId);

    }

    public List<Livro> listaLivros() {

        return this.livroDAO.listaLivros();

    }
}
