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

}
