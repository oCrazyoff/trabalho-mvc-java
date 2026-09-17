package br.com.mvc.service;

import br.com.mvc.dao.GeneroDAO;
import br.com.mvc.model.Genero;
import java.util.List;
import java.util.Set;

public class GeneroService {

    private final GeneroDAO generoDAO = new GeneroDAO();

    // lista apenas os generos do usuario
    public List<Genero> listarPorUsuario(Long usuarioId) {

        if (usuarioId == null) {

            return List.of();

        }

        return this.generoDAO.listarPorUsuario(usuarioId);

    }

    // lista todos os generos
    public List<Genero> listarGeneros() {

        return this.generoDAO.listarGeneros();

    }

    // retorna todos os ids de generos vinculado ao usuario
    public Set<Long> listarIdsPorUsuario(Long usuarioId) {
        if (usuarioId == null) {
            return Set.of();
        }

        return this.generoDAO.listarIdsPorUsuario(usuarioId);

    }

    /**
     * Alterna o estado: se o gênero estiver salvo, remove. Se não estiver,
     * adiciona.
     * 
     * return true se foi vinculado (marcado), false se foi desvinculado
     * (desmarcado).
     */

    public boolean alternarGeneroUsuario(Long usuarioId, Long generoId) {

        if (usuarioId == null || generoId == null) {
            throw new IllegalArgumentException("Usuário e gênero devem ser informados.");
        }

        if (this.generoDAO.usuarioPossuiGenero(usuarioId, generoId)) {

            this.generoDAO.desvincularUsuario(usuarioId, generoId);
            return false;

        } else {

            this.generoDAO.vincularUsuario(usuarioId, generoId);
            return true;

        }
    }

    // buscar por id
    public Genero buscarPorId(Long id) {
        if (id == null)
            return null;
        return this.generoDAO.buscarPorId(id);
    }

    // cadastrar um genero
    public void salvar(Genero genero) {
        if (genero == null) {
            throw new IllegalArgumentException("Gênero é obrigatório.");
        }
        if (genero.getNome() == null || genero.getNome().isBlank()) {
            throw new IllegalArgumentException("O nome do gênero é obrigatório.");
        }

        if (genero.getId() == null) {
            this.generoDAO.inserir(genero);
        } else {
            this.generoDAO.alterar(genero);
        }
    }

    // deletar um genero
    public void deletar(Long id) {
        if (id == null) {
            throw new IllegalArgumentException("ID inválido para exclusão.");
        }
        this.generoDAO.deletar(id);
    }

}
