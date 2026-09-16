package br.com.mvc.service;

import br.com.mvc.dao.GeneroDAO;
import br.com.mvc.model.Genero;
import java.util.List;

public class GeneroService {

    private final GeneroDAO generoDAO = new GeneroDAO();

    public List<Genero> listarPorUsuario(Long usuarioId) {

        if (usuarioId == null) {

            return List.of();

        }

        return this.generoDAO.listarPorUsuario(usuarioId);

    }

}
