package br.com.mvc.service;

import br.com.mvc.dao.GeneroDAO;
import br.com.mvc.dao.LivroDAO;
import br.com.mvc.model.Livro;

import java.util.List;

public class LivroService {

    private final LivroDAO livroDAO = new LivroDAO();
    private final GeneroDAO generoDAO = new GeneroDAO();

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

    /**
     * Regra de salvamento:
     * - título e autor obrigatórios
     * - ISBN único
     * - pelo menos um gênero (é o que liga o livro às recomendações)
     * - sem id -> cadastro novo / com id -> alteração
     */
    public void salvar(Livro livro) {
        if (livro == null) {
            throw new IllegalArgumentException("Livro é obrigatório.");
        }

        this.prepararDados(livro);

        if (livro.getTitulo() == null) {
            throw new IllegalArgumentException("Título do livro é obrigatório.");
        }
        if (livro.getAutor() == null) {
            throw new IllegalArgumentException("Autor do livro é obrigatório.");
        }
        if (livro.getNumPaginas() != null && livro.getNumPaginas() <= 0) {
            throw new IllegalArgumentException("O número de páginas deve ser maior que zero.");
        }
        if (livro.getAnoPublicacao() != null && livro.getAnoPublicacao() < 0) {
            throw new IllegalArgumentException("Ano de publicação inválido.");
        }

        this.validarIsbnUnico(livro);
        List<Long> generos = this.validarGeneros(livro.getGenerosIds());

        if (livro.getId() == null) {
            livro.setId(this.livroDAO.inserir(livro));
        } else {
            if (this.livroDAO.buscarPorId(livro.getId()) == null) {
                throw new IllegalArgumentException("Livro não encontrado para alteração.");
            }
            this.livroDAO.alterar(livro);
        }

        this.livroDAO.salvarGeneros(livro.getId(), generos);
        livro.setGenerosIds(generos);
    }

    // deletar um livro
    public void deletar(Long id) {
        if (id == null) {
            throw new IllegalArgumentException("ID inválido para exclusão.");
        }
        if (this.livroDAO.buscarPorId(id) == null) {
            throw new IllegalArgumentException("Livro não encontrado.");
        }
        this.livroDAO.deletar(id);
    }

    // remove espaços extras e transforma textos vazios em null
    private void prepararDados(Livro livro) {
        livro.setTitulo(this.normalizar(livro.getTitulo()));
        livro.setAutor(this.normalizar(livro.getAutor()));
        livro.setSinopse(this.normalizar(livro.getSinopse()));
        livro.setIsbn(this.normalizar(livro.getIsbn()));
        livro.setEditora(this.normalizar(livro.getEditora()));
        livro.setCapaUrl(this.normalizar(livro.getCapaUrl()));
    }

    // o ISBN não pode se repetir entre livros diferentes
    private void validarIsbnUnico(Livro livro) {
        if (livro.getIsbn() == null) {
            return;
        }
        Livro existente = this.livroDAO.buscarPorIsbn(livro.getIsbn());
        if (existente != null && !existente.getId().equals(livro.getId())) {
            throw new IllegalArgumentException("Já existe um livro com este ISBN.");
        }
    }

    // pelo menos um gênero, sem repetidos e todos existentes
    private List<Long> validarGeneros(List<Long> generosIds) {
        if (generosIds == null || generosIds.isEmpty()) {
            throw new IllegalArgumentException("Selecione pelo menos um gênero para o livro.");
        }

        List<Long> generos = generosIds.stream().distinct().toList();
        for (Long generoId : generos) {
            if (generoId == null || this.generoDAO.buscarPorId(generoId) == null) {
                throw new IllegalArgumentException("Gênero informado não existe.");
            }
        }
        return generos;
    }

    private String normalizar(String valor) {
        if (valor == null) {
            return null;
        }
        String limpo = valor.trim();
        return limpo.isEmpty() ? null : limpo;
    }
}
