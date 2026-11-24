package br.com.mvc.dao;

import br.com.mvc.model.Livro;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LivroDAO extends MysqlDAO {

    private static final String COLUNAS = "l.id, l.titulo, l.autor, l.sinopse, l.isbn, l.editora, "
            + "l.ano_publicacao, l.numero_paginas, l.capa_url";

    // lista os livros recomendados pelo usuario ID
    public List<Livro> listarRecomendados(Long usuarioId) {

        String sql = "SELECT DISTINCT " + COLUNAS + " "
                + "FROM livros l "
                + "INNER JOIN livro_generos lg ON lg.livro_id = l.id "
                + "INNER JOIN usuario_generos ug ON ug.genero_id = lg.genero_id "
                + "WHERE ug.usuario_id = ? "
                + "ORDER BY l.titulo";

        List<Livro> livros = new ArrayList<>();

        try (ResultSet rs = super.executar(sql, usuarioId)) {
            while (rs.next()) {
                livros.add(this.mapear(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar livros recomendados.", e);
        }

        return livros;
    }

    // listar todos os livros
    public List<Livro> listaLivros() {

        String sql = "SELECT " + COLUNAS + " FROM livros l ORDER BY l.titulo";

        List<Livro> livros = new ArrayList<>();

        try (ResultSet rs = super.executar(sql)) {
            while (rs.next()) {
                livros.add(this.mapear(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar livros.", e);
        }

        return livros;
    }

    // lista o livro mais recomendado
    public Livro livroMaisRecomendado() {

        String sql = "SELECT " + COLUNAS + ", COUNT(DISTINCT ug.usuario_id) AS total_recomendacoes "
                + "FROM livros l "
                + "INNER JOIN livro_generos lg ON lg.livro_id = l.id "
                + "INNER JOIN usuario_generos ug ON ug.genero_id = lg.genero_id "
                + "GROUP BY " + COLUNAS + " "
                + "ORDER BY total_recomendacoes DESC "
                + "LIMIT 1";

        try (ResultSet rs = super.executar(sql)) {
            if (rs.next()) {
                return this.mapear(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar o livro mais recomendado.", e);
        }

        // caso não tenha livros recomendados ainda
        return null;
    }

    // buscar livro pelo ID (com os gêneros)
    public Livro buscarPorId(Long id) {
        String sql = "SELECT " + COLUNAS + " FROM livros l WHERE l.id = ?";

        Livro livro = null;
        try (ResultSet rs = super.executar(sql, id)) {
            if (rs.next()) {
                livro = this.mapear(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar livro por id.", e);
        }

        if (livro != null) {
            livro.setGenerosIds(this.listarGenerosIds(livro.getId()));
        }
        return livro;
    }

    // buscar livro pelo ISBN
    public Livro buscarPorIsbn(String isbn) {
        String sql = "SELECT " + COLUNAS + " FROM livros l WHERE l.isbn = ?";
        try (ResultSet rs = super.executar(sql, isbn)) {
            if (rs.next()) {
                return this.mapear(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar livro por ISBN.", e);
        }
        return null;
    }

    // cadastrar um novo livro e retornar o ID gerado
    public Long inserir(Livro livro) {
        String sql = "INSERT INTO livros (titulo, autor, sinopse, isbn, editora, ano_publicacao, numero_paginas, capa_url) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            return super.executarInsert(sql,
                    livro.getTitulo(),
                    livro.getAutor(),
                    livro.getSinopse(),
                    livro.getIsbn(),
                    livro.getEditora(),
                    livro.getAnoPublicacao(),
                    livro.getNumPaginas(),
                    livro.getCapaUrl());
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir livro.", e);
        }
    }

    // editar um livro
    public void alterar(Livro livro) {
        String sql = "UPDATE livros SET titulo = ?, autor = ?, sinopse = ?, isbn = ?, editora = ?, "
                + "ano_publicacao = ?, numero_paginas = ?, capa_url = ? WHERE id = ?";
        try {
            super.executarUpdate(sql,
                    livro.getTitulo(),
                    livro.getAutor(),
                    livro.getSinopse(),
                    livro.getIsbn(),
                    livro.getEditora(),
                    livro.getAnoPublicacao(),
                    livro.getNumPaginas(),
                    livro.getCapaUrl(),
                    livro.getId());
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao alterar livro.", e);
        }
    }

    // deletar um livro
    public void deletar(Long id) {
        String sql = "DELETE FROM livros WHERE id = ?";
        try {
            super.executarUpdate(sql, id);
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao deletar livro.", e);
        }
    }

    // IDs dos gêneros vinculados ao livro
    public List<Long> listarGenerosIds(Long livroId) {
        String sql = "SELECT genero_id FROM livro_generos WHERE livro_id = ? ORDER BY genero_id";
        List<Long> ids = new ArrayList<>();
        try (ResultSet rs = super.executar(sql, livroId)) {
            while (rs.next()) {
                ids.add(rs.getLong("genero_id"));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar gêneros do livro.", e);
        }
        return ids;
    }

    // substitui os gêneros do livro na tabela intermediária
    public void salvarGeneros(Long livroId, List<Long> generosIds) {
        try {
            super.executarUpdate("DELETE FROM livro_generos WHERE livro_id = ?", livroId);
            for (Long generoId : generosIds) {
                super.executarUpdate("INSERT INTO livro_generos (livro_id, genero_id) VALUES (?, ?)",
                        livroId, generoId);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao salvar gêneros do livro.", e);
        }
    }

    // converte a linha do ResultSet em Livro
    private Livro mapear(ResultSet rs) throws SQLException {
        Livro livro = new Livro();
        livro.setId(rs.getLong("id"));
        livro.setTitulo(rs.getString("titulo"));
        livro.setAutor(rs.getString("autor"));
        livro.setSinopse(rs.getString("sinopse"));
        livro.setIsbn(rs.getString("isbn"));
        livro.setEditora(rs.getString("editora"));
        livro.setAnoPublicacao(rs.getObject("ano_publicacao", Integer.class));
        livro.setNumPaginas(rs.getObject("numero_paginas", Integer.class));
        livro.setCapaUrl(rs.getString("capa_url"));
        return livro;
    }

}
