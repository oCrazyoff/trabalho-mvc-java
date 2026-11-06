package br.com.mvc.dao;

import br.com.mvc.model.Genero;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.HashSet;
import java.util.Set;
import java.util.LinkedHashMap;
import java.util.Map;

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

    // generos mais populares com base nos usuários
    public Map<String, Integer> generosMaisPopulares() {

        String sql = """
                    SELECT g.nome, COUNT(ug.usuario_id) AS total
                    FROM generos g
                    INNER JOIN usuario_generos ug ON ug.genero_id = g.id
                    GROUP BY g.id, g.nome
                    ORDER BY total DESC
                    LIMIT 5
                """;

        Map<String, Integer> dados = new LinkedHashMap<>();

        try (ResultSet rs = super.executar(sql)) {

            while (rs.next()) {

                dados.put(rs.getString("nome"), rs.getInt("total"));

            }

        } catch (SQLException e) {

            throw new RuntimeException("Erro ao buscar gêneros mais populares.", e);

        }

        return dados;

    }

    // quantidade de livros cadastrados em cada genero
    public Map<String, Integer> livrosPorGenero() {

        String sql = """
                    SELECT g.nome, COUNT(lg.livro_id) AS total
                    FROM generos g
                    LEFT JOIN livro_generos lg ON lg.genero_id = g.id
                    GROUP BY g.id, g.nome
                    ORDER BY total DESC
                """;

        Map<String, Integer> dados = new LinkedHashMap<>();

        try (ResultSet rs = super.executar(sql)) {

            while (rs.next()) {

                dados.put(rs.getString("nome"), rs.getInt("total"));

            }

        } catch (SQLException e) {

            throw new RuntimeException("Erro ao buscar quantidade de livros por gênero.", e);

        }

        return dados;

    }

    // Buscar gênero por ID
    public Genero buscarPorId(Long id) {
        String sql = "SELECT id, nome, descricao FROM generos WHERE id = ?";
        try (ResultSet rs = super.executar(sql, id)) {
            if (rs.next()) {
                Genero g = new Genero();
                g.setId(rs.getLong("id"));
                g.setNome(rs.getString("nome"));
                g.setDescricao(rs.getString("descricao"));
                return g;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar gênero por ID.", e);
        }
        return null;
    }

    // Inserir novo gênero
    public void inserir(Genero genero) {
        String sql = "INSERT INTO generos (nome, descricao) VALUES (?, ?)";
        try {
            super.executarUpdate(sql, genero.getNome(), genero.getDescricao());
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir gênero.", e);
        }
    }

    // Alterar gênero existente
    public void alterar(Genero genero) {
        String sql = "UPDATE generos SET nome = ?, descricao = ? WHERE id = ?";
        try {
            super.executarUpdate(sql, genero.getNome(), genero.getDescricao(), genero.getId());
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao alterar gênero.", e);
        }
    }

    // Deletar gênero
    public void deletar(Long id) {
        String sql = "DELETE FROM generos WHERE id = ?";
        try {
            super.executarUpdate(sql, id);
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao deletar gênero.", e);
        }
    }

}
