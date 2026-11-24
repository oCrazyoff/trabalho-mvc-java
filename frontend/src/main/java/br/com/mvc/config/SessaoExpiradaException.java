package br.com.mvc.config;

public class SessaoExpiradaException extends RuntimeException {

    public SessaoExpiradaException() {
        super("Sua sessão expirou. Faça login novamente.");
    }
}
