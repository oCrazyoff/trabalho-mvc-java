package br.com.mvc.model;

import java.util.Map;

public class Dashboard {

    private int totalLivros;
    private int totalGeneros;
    private int totalUsuarios;
    private Livro livroMaisRecomendado;
    private Map<String, Integer> generosMaisPopulares;
    private Map<String, Integer> livrosPorGenero;

    public int getTotalLivros() {
        return totalLivros;
    }

    public int getTotalGeneros() {
        return totalGeneros;
    }

    public int getTotalUsuarios() {
        return totalUsuarios;
    }

    public Livro getLivroMaisRecomendado() {
        return livroMaisRecomendado;
    }

    public Map<String, Integer> getGenerosMaisPopulares() {
        return generosMaisPopulares;
    }

    public Map<String, Integer> getLivrosPorGenero() {
        return livrosPorGenero;
    }
}
