package br.com.mvc.dao;

import br.com.mvc.model.Livro;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.com.mvc.model.Livro;

public class LivroDAO extends MysqlDAO {

    public List<Livro> listarRecomendados(Long usuarioId) {

        // lista os livros recomendados pelo usuario ID
        String sql = "SELECT DISTINCT l.id, l.titulo, l.autor, l.sinopse, l.isbn, l.editora, l.ano_publicacao, l.numero_paginas, l.capa_url "
                + "FROM livros l "
                + "INNER JOIN livro_generos lg ON lg.livro_id = l.id "
                + "INNER JOIN usuario_generos ug ON ug.genero_id = lg.genero_id "
                + "WHERE ug.usuario_id = ? "
                + "ORDER BY l.titulo";

        List<Livro> livros = new ArrayList<>();

        try (ResultSet rs = super.executar(sql, usuarioId)) {

            while (rs.next()) {
                Livro livro = new Livro();

                livro.setId(rs.getLong("id"));
                livro.setTitulo(rs.getString("titulo"));
                livro.setAutor(rs.getString("autor"));
                livro.setSinopse(rs.getString("sinopse"));
                livro.setIsbn(rs.getString("isbn"));
                livro.setEditora(rs.getString("editora"));
                livro.setAnoPublicacao(rs.getInt("ano_publicacao"));
                livro.setNumPaginas(rs.getInt("numero_paginas"));
                livro.setCapaUrl(rs.getString("capa_url"));

                livros.add(livro);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar livros recomendados.", e);
        }

        return livros;

    }

    // listar todos os livros
    public List<Livro> listaLivros() {

        String sql = "SELECT id, titulo, autor, sinopse, isbn, editora, ano_publicacao, numero_paginas, capa_url FROM livros";

        List<Livro> livros = new ArrayList<>();

        try (ResultSet rs = super.executar(sql)) {

            while (rs.next()) {
                Livro livro = new Livro();

                livro.setId(rs.getLong("id"));
                livro.setTitulo(rs.getString("titulo"));
                livro.setAutor(rs.getString("autor"));
                livro.setSinopse(rs.getString("sinopse"));
                livro.setIsbn(rs.getString("isbn"));
                livro.setEditora(rs.getString("editora"));
                livro.setAnoPublicacao(rs.getInt("ano_publicacao"));
                livro.setNumPaginas(rs.getInt("numero_paginas"));
                livro.setCapaUrl(rs.getString("capa_url"));

                livros.add(livro);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar livros.", e);
        }

        return livros;

    }

    // lista o livro mais recomendado
    public Livro livroMaisRecomendado() {

        String sql = "SELECT l.id, l.titulo, l.autor, l.sinopse, l.isbn, l.editora, l.ano_publicacao, l.numero_paginas, l.capa_url, "
                + "COUNT(DISTINCT ug.usuario_id) AS total_recomendacoes "
                + "FROM livros l "
                + "INNER JOIN livro_generos lg ON lg.livro_id = l.id "
                + "INNER JOIN usuario_generos ug ON ug.genero_id = lg.genero_id "
                + "GROUP BY l.id, l.titulo, l.autor, l.sinopse, l.isbn, l.editora, l.ano_publicacao, l.numero_paginas, l.capa_url "
                + "ORDER BY total_recomendacoes DESC "
                + "LIMIT 1";

        try (ResultSet rs = super.executar(sql)) {

            if (rs.next()) {

                Livro livro = new Livro();

                livro.setId(rs.getLong("id"));
                livro.setTitulo(rs.getString("titulo"));
                livro.setAutor(rs.getString("autor"));
                livro.setSinopse(rs.getString("sinopse"));
                livro.setIsbn(rs.getString("isbn"));
                livro.setEditora(rs.getString("editora"));
                livro.setAnoPublicacao(rs.getInt("ano_publicacao"));
                livro.setNumPaginas(rs.getInt("numero_paginas"));
                livro.setCapaUrl(rs.getString("capa_url"));

                return livro;
            }

        } catch (SQLException e) {

            throw new RuntimeException("Erro ao buscar o livro mais recomendado.", e);

        }

        // caso não tenha livros recomendados ainda
        return null;

    }

    // buscar livro pelo ID
    public Livro buscarPorId(Long id) {
        String sql = "SELECT id, titulo, autor, sinopse, isbn, editora, ano_publicacao, numero_paginas, capa_url FROM livros WHERE id = ?";
        try (ResultSet rs = super.executar(sql, id)) {
            if (rs.next()) {
                Livro livro = new Livro();
                livro.setId(rs.getLong("id"));
                livro.setTitulo(rs.getString("titulo"));
                livro.setAutor(rs.getString("autor"));
                livro.setSinopse(rs.getString("sinopse"));
                livro.setIsbn(rs.getString("isbn"));
                livro.setEditora(rs.getString("editora"));
                livro.setAnoPublicacao(rs.getInt("ano_publicacao"));
                livro.setNumPaginas(rs.getInt("numero_paginas"));
                livro.setCapaUrl(rs.getString("capa_url"));
                return livro;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar livro por id.", e);
        }
        return null;
    }

    // cadastrar um novo livro
    public void inserir(Livro livro) {
        String sql = "INSERT INTO livros (titulo, autor, sinopse, isbn, editora, ano_publicacao, numero_paginas, capa_url) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            super.executarUpdate(sql,
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

}