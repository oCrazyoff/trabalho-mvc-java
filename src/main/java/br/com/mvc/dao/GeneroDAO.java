package br.com.mvc.dao;

import br.com.mvc.model.Genero;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.HashSet;
import java.util.Set;

public class GeneroDAO extends MysqlDAO {

    // listar os generos do usuario
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
            throw new RuntimeException("Erro ao buscar gêneros do usuário.", e);
        }

        return generos;

    }

    // listar todos os generos
    public List<Genero> listarGeneros() {

        String sql = "SELECT id, nome, descricao FROM generos";

        List<Genero> generos = new ArrayList<>();

        try (ResultSet rs = super.executar(sql)) {

            while (rs.next()) {

                Genero g = new Genero();
                g.setId(rs.getLong("id"));
                g.setNome(rs.getString("nome"));
                g.setDescricao(rs.getString("descricao"));

                generos.add(g);

            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar gêneros.", e);
        }

        return generos;

    }

    // retornas os IDs dos generos já favoritos do usuario
    public Set<Long> listarIdsPorUsuario(Long usuarioId) {

        String sql = "SELECT genero_id FROM usuario_generos WHERE usuario_id = ?";
        Set<Long> ids = new HashSet<>();

        try (ResultSet rs = super.executar(sql, usuarioId)) {

            while (rs.next()) {
                ids.add(rs.getLong("genero_id"));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar IDs de gêneros do usuário.", e);
        }

        return ids;
    }

    // verifica se a relação genero usuario ja existe
    public boolean usuarioPossuiGenero(Long usuarioId, Long generoId) {

        String sql = "SELECT 1 FROM usuario_generos WHERE usuario_id = ? AND genero_id = ?";

        try (ResultSet rs = super.executar(sql, usuarioId, generoId)) {

            return rs.next();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao verificar relação gênero-usuário.", e);
        }

    }

    // insere na tabela intermediaria
    public void vincularUsuario(Long usuarioId, Long generoId) {

        String sql = "INSERT INTO usuario_generos (usuario_id, genero_id) VALUES (?, ?)";

        try {

            super.executarUpdate(sql, usuarioId, generoId);

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao vincular gênero ao usuário.", e);
        }

    }

    // deleta da tabela intermediaria
    public void desvincularUsuario(Long usuarioId, Long generoId) {

        String sql = "DELETE FROM usuario_generos WHERE usuario_id = ? AND genero_id = ?";

        try {

            super.executarUpdate(sql, usuarioId, generoId);

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao desvincular gênero do usuário.", e);
        }

    }

}
