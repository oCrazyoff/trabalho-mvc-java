package br.com.mvc.service;

import br.com.mvc.config.ApiClient;
import br.com.mvc.model.LoginResposta;
import br.com.mvc.model.Usuario;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.List;

public class UsuarioService {

    private static final Type LISTA_USUARIOS = new TypeToken<List<Usuario>>() {
    }.getType();

    // envia login e senha e recebe o token + dados do usuário
    public LoginResposta autenticar(String login, String senha) {
        Usuario credenciais = new Usuario();
        credenciais.setLogin(login);
        credenciais.setSenha(senha);

        LoginResposta resposta = ApiClient.post("/api/login", credenciais, LoginResposta.class);
        if (resposta == null || resposta.getToken() == null) {
            throw new IllegalArgumentException("Não foi possível autenticar. Tente novamente.");
        }
        return resposta;
    }

    // cadastro público de leitor: a API cria o usuário e já devolve o token
    public LoginResposta cadastrar(Usuario usuario) {
        LoginResposta resposta = ApiClient.post("/api/cadastro", usuario, LoginResposta.class);
        if (resposta == null || resposta.getToken() == null) {
            throw new IllegalArgumentException("Não foi possível concluir o cadastro. Tente novamente.");
        }
        return resposta;
    }

    public List<Usuario> listar() {
        return ApiClient.get("/api/usuarios", LISTA_USUARIOS);
    }

    public Usuario buscarPorId(Long id) {
        if (id == null)
            return null;
        return ApiClient.get("/api/usuarios/" + id, Usuario.class);
    }

    public void salvar(Usuario usuario) {
        if (usuario.getId() == null) {
            ApiClient.post("/api/usuarios", usuario, null);
        } else {
            ApiClient.put("/api/usuarios/" + usuario.getId(), usuario);
        }
    }

    public void deletar(Long id) {
        ApiClient.delete("/api/usuarios/" + id);
    }
}
