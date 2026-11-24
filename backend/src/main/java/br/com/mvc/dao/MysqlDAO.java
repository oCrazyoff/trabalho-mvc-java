package br.com.mvc.dao;

import br.com.mvc.config.MysqlSingleton;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Classe base dos DAOs que usam MySQL.
 *
 * Guarda referencia ao {@link MysqlSingleton} (uma conexao reutilizada).
 * Os DAOs filhos usam executar() para SELECT, executarUpdate() para UPDATE/DELETE
 * e executarInsert() quando precisam do ID gerado.
 */
public class MysqlDAO {

    protected final MysqlSingleton banco;

    public MysqlDAO() {
        this.banco = MysqlSingleton.getInstance();
    }

    protected ResultSet executar(String sql, Object... parametros) throws SQLException {
        return this.banco.executar(sql, parametros);
    }

    protected int executarUpdate(String sql, Object... parametros) throws SQLException {
        return this.banco.executarUpdate(sql, parametros);
    }

    protected Long executarInsert(String sql, Object... parametros) throws SQLException {
        return this.banco.executarInsert(sql, parametros);
    }
}
