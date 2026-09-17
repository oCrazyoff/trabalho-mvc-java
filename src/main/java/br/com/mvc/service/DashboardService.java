package br.com.mvc.service;

import java.util.List;

import br.com.mvc.dao.GeneroDAO;
import br.com.mvc.dao.LivroDAO;
import br.com.mvc.dao.UsuarioDAO;
import br.com.mvc.model.Livro;
import java.util.Map;

public class DashboardService {

    private final LivroDAO livroDAO = new LivroDAO();
    private final GeneroDAO generoDAO = new GeneroDAO();
    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    // retorna a quantidade de livros cadastrados
    public int totalLivros() {
        return this.livroDAO.listaLivros().size();
    }

    // retorna a quantidade de generos cadastrados
    public int totalGeneros() {
        return this.generoDAO.listarGeneros().size();
    }

    // retorna a quantidade de usuarios cadastrados
    public int totalUsuarios() {
        return this.usuarioDAO.listarTodos().size();
    }

    // lista o livro mais recomendado
    public Livro maisRecomendado() {
        return this.livroDAO.livroMaisRecomendado();
    }

    // Retorna os dados para o gráfico de gêneros mais populares
    public Map<String, Integer> generosMaisPopulares() {
        return this.generoDAO.generosMaisPopulares();
    }

    // Retorna os dados para o gráfico de livros por gênero
    public Map<String, Integer> livrosPorGenero() {
        return this.generoDAO.livrosPorGenero();
    }
}
