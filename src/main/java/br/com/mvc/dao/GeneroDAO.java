package br.com.mvc.dao;

import br.com.mvc.model.Genero;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GeneroDAO extends MysqlDAO {

    public List<Genero> listarPorUsuario(Long usuarioId) {

        String sql = "SELECT g.id, g.nome, g.descricao "
                + "FROM generos g "
                + "INNER JOIN usuario_generos ug ON ug.genero_id = g.id "
                + "WHERE ug.usuario_id = ? "
                + "ORDER BY g.nome";

        List<Genero> generos = new ArrayList<>();

        try (ResultSet rs = super.executar(sql, usuarioId)) {

            while (rs.next()) {

                Genero g = new Genero();
                g.setId(rs.getLong("id"));
                g.setNome(rs.getString("nome"));
                g.setDescricao(rs.getString("descricao"));

                generos.add(g);

            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar categorias do usuário.", e);
        }

        return generos;

    }

}
