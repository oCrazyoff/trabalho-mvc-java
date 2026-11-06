package br.com.mvc.dao;

import br.com.mvc.model.Perfil;
import br.com.mvc.model.Usuario;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO = Data Access Object (acesso ao banco)
 *
 * Somente SQL e conversao ResultSet -> {@link Usuario}.
 * Quem decide "quando" chamar cada metodo e o Service / Controller.
 */
public class UsuarioDAO extends MysqlDAO {

    public UsuarioDAO() {
        super();
    }

    // 1. Função para autenticar usuário buscando por login e senha
    public Usuario buscarPorLoginESenha(String login, String senha) {
        String sql = "SELECT u.id, u.nome, u.login, u.senha, u.perfil_id, p.nome AS perfil_nome "
                + "FROM usuarios u "
                + "INNER JOIN perfis p ON p.id = u.perfil_id "
                + "WHERE u.login = ? AND u.senha = ?";
        try (ResultSet rs = super.executar(sql, login, senha)) {
            if (rs.next()) {
                return this.mapearComPerfil(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar usuario.", e);
        }
        return null;
    }

    // 2. Função para listar todos os usuários cadastrados com seus perfis
    public List<Usuario> listarTodos() {
        String sql = "SELECT u.id, u.nome, u.login, u.senha, u.perfil_id, p.nome AS perfil_nome "
                + "FROM usuarios u "
                + "INNER JOIN perfis p ON p.id = u.perfil_id "
                + "ORDER BY u.nome";
        List<Usuario> lista = new ArrayList<>();
        try (ResultSet rs = super.executar(sql)) {
            while (rs.next()) {
                lista.add(this.mapearComPerfil(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar usuarios.", e);
        }
        return lista;
    }

    // 3. Função para buscar o usuário com base no ID
    public Usuario buscarPorId(Long id) {
        String sql = "SELECT u.id, u.nome, u.login, u.senha, u.perfil_id, p.nome AS perfil_nome "
                + "FROM usuarios u "
                + "INNER JOIN perfis p ON p.id = u.perfil_id "
                + "WHERE u.id = ?";
        try (ResultSet rs = super.executar(sql, id)) {
            if (rs.next()) {
                return this.mapearComPerfil(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar por id.", e);
        }
        return null;
    }

    // 4. Função para buscar usuário pelo login
    public Usuario buscarPorLogin(String login) {
        String sql = "SELECT u.id, u.nome, u.login, u.senha, u.perfil_id, p.nome AS perfil_nome "
                + "FROM usuarios u "
                + "INNER JOIN perfis p ON p.id = u.perfil_id "
                + "WHERE u.login = ?";
        try (ResultSet rs = super.executar(sql, login)) {
            if (rs.next()) {
                return this.mapearComPerfil(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar por login.", e);
        }
        return null;
    }

    // 5. Função que conta a quantidade de usuários associados a um perfil
    public int contarPorPerfil(Long perfilId) {
        String sql = "SELECT COUNT(*) AS total FROM usuarios WHERE perfil_id = ?";
        try (ResultSet rs = super.executar(sql, perfilId)) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao contar usuarios por perfil.", e);
        }
        return 0;
    }

    // 6. Função para cadastrar um novo usuário no banco de dados
    public void inserir(Usuario usuario) {
        String sql = "INSERT INTO usuarios (nome, login, senha, perfil_id) VALUES (?, ?, ?, ?)";
        try {
            super.executarUpdate(
                    sql,
                    usuario.getNome(),
                    usuario.getLogin(),
                    usuario.getSenha(),
                    usuario.getPerfilId());
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir.", e);
        }
    }

    // 7. Função que edita o usuário com base no ID
    public void alterar(Usuario usuario) {
        String sql = "UPDATE usuarios SET nome = ?, login = ?, senha = ?, perfil_id = ? WHERE id = ?";
        try {
            super.executarUpdate(
                    sql,
                    usuario.getNome(),
                    usuario.getLogin(),
                    usuario.getSenha(),
                    usuario.getPerfilId(),
                    usuario.getId());
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao alterar.", e);
        }
    }

    // 8. Função para deletar um usuário com base no ID
    public void deletar(Long id) {
        String sql = "DELETE FROM usuarios WHERE id = ?";
        try {
            super.executarUpdate(sql, id);
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao deletar.", e);
        }
    }

    // 9. Função auxiliar para mapear ResultSet para o objeto Usuario com o Perfil
    private Usuario mapearComPerfil(ResultSet rs) throws SQLException {
        Usuario usuario = new Usuario();
        usuario.setId(rs.getLong("id"));
        usuario.setNome(rs.getString("nome"));
        usuario.setLogin(rs.getString("login"));
        usuario.setSenha(rs.getString("senha"));
        usuario.setPerfilId(rs.getLong("perfil_id"));

        Perfil perfil = new Perfil();
        perfil.setId(rs.getLong("perfil_id"));
        perfil.setNome(rs.getString("perfil_nome"));
        usuario.setPerfil(perfil);

        return usuario;
    }
}
