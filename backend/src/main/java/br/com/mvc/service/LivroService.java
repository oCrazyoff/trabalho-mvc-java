package br.com.mvc.service;

import br.com.mvc.dao.LivroDAO;
import br.com.mvc.model.Livro;
import java.util.List;

public class LivroService {

    private final LivroDAO livroDAO = new LivroDAO();

    // listar os livros recomendados para um usuario
    public List<Livro> listarRecomendados(Long usuarioId) {

        if (usuarioId == null) {

            return List.of();

        }

        return this.livroDAO.listarRecomendados(usuarioId);

    }

    // listar todos os livros
    public List<Livro> listaLivros() {

        return this.livroDAO.listaLivros();

    }

    // buscar livro pelo ID
    public Livro buscarPorId(Long id) {
        if (id == null)
            return null;
        return this.livroDAO.buscarPorId(id);
    }

    // cadastrar um novo livro
    public void salvar(Livro livro) {
        if (livro == null) {
            throw new IllegalArgumentException("Livro é obrigatório.");
        }
        if (livro.getTitulo() == null || livro.getTitulo().isBlank()) {
            throw new IllegalArgumentException("Título do livro é obrigatório.");
        }
        if (livro.getAutor() == null || livro.getAutor().isBlank()) {
            throw new IllegalArgumentException("Autor do livro é obrigatório.");
        }
        if (livro.getId() == null) {
            this.livroDAO.inserir(livro);
        } else {
            this.livroDAO.alterar(livro);
        }
    }

    // deletar um livro
    public void deletar(Long id) {
        if (id == null) {
            throw new IllegalArgumentException("ID inválido para exclusão.");
        }
        this.livroDAO.deletar(id);
    }
}
