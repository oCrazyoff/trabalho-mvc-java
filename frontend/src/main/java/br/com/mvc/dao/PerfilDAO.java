package br.com.mvc.dao;

import br.com.mvc.model.Perfil;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO = Data Access Object (acesso ao banco)
 *
 * Somente SQL e conversao ResultSet -> {@link Perfil}.
 * Quem decide "quando" chamar cada metodo e o Service / Controller.
 */
public class PerfilDAO extends MysqlDAO {

    public PerfilDAO() {
        super();
    }

    // 1. Função para listar todos os perfis cadastrados
    public List<Perfil> listarTodos() {
        String sql = "SELECT id, nome FROM perfis ORDER BY id";
        List<Perfil> lista = new ArrayList<>();
        try (ResultSet rs = super.executar(sql)) {
            while (rs.next()) {
                lista.add(this.mapear(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar perfis.", e);
        }
        return lista;
    }

    // 2. Função para buscar um perfil com base no ID
    public Perfil buscarPorId(Long id) {
        String sql = "SELECT id, nome FROM perfis WHERE id = ?";
        try (ResultSet rs = super.executar(sql, id)) {
            if (rs.next()) {
                return this.mapear(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar perfil por id.", e);
        }
        return null;
    }

    // 3. Função para buscar um perfil pelo nome
    public Perfil buscarPorNome(String nome) {
        String sql = "SELECT id, nome FROM perfis WHERE nome = ?";
        try (ResultSet rs = super.executar(sql, nome)) {
            if (rs.next()) {
                return this.mapear(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar perfil por nome.", e);
        }
        return null;
    }

    // 4. Função para inserir um novo perfil no banco de dados
    public void inserir(Perfil perfil) {
        String sql = "INSERT INTO perfis (nome) VALUES (?)";
        try {
            super.executarUpdate(sql, perfil.getNome());
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir perfil.", e);
        }
    }

    // 5. Função que edita os dados do perfil com base no ID
    public void alterar(Perfil perfil) {
        String sql = "UPDATE perfis SET nome = ? WHERE id = ?";
        try {
            super.executarUpdate(sql, perfil.getNome(), perfil.getId());
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao alterar perfil.", e);
        }
    }

    // 6. Função para deletar um perfil pelo ID
    public void deletar(Long id) {
        String sql = "DELETE FROM perfis WHERE id = ?";
        try {
            super.executarUpdate(sql, id);
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao deletar perfil.", e);
        }
    }

    // 7. Função auxiliar para converter ResultSet em objeto Perfil
    private Perfil mapear(ResultSet rs) throws SQLException {
        Perfil perfil = new Perfil();
        perfil.setId(rs.getLong("id"));
        perfil.setNome(rs.getString("nome"));
        return perfil;
    }
}
