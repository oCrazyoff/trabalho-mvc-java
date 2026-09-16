package br.com.mvc.dao;

import br.com.mvc.model.Livro;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.com.mvc.model.Livro;

public class LivroDAO extends MysqlDAO {

    public List<Livro> listarRecomendados(Long usuarioId) {

        // DISTINCT evita que o mesmo livro se repita caso ele tenha mais de uma
        // categoria em comum
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

}
