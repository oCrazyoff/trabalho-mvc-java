package br.com.mvc.service;

import br.com.mvc.dao.PerfilDAO;
import br.com.mvc.dao.UsuarioDAO;
import br.com.mvc.model.Usuario;

import java.util.List;

/**
 * SERVICE de Usuario — regras de negocio ficam aqui.
 *
 * Controller so chama estes metodos e decide a view.
 * DAO so executa SQL.
 */
public class UsuarioService {

    private static final int SENHA_MINIMA = 6;

    private final UsuarioDAO usuarioDAO;
    private final PerfilDAO perfilDAO;

    public UsuarioService() {
        this.usuarioDAO = new UsuarioDAO();
        this.perfilDAO = new PerfilDAO();
    }

    /**
     * Regra de autenticacao:
     * - login e senha obrigatorios
     * - so libera acesso se existir usuario com esse login/senha
     */
    public Usuario autenticar(String login, String senha) {
        login = this.normalizar(login);
        senha = this.normalizar(senha);

        if (login == null || senha == null) {
            throw new IllegalArgumentException("Informe login e senha.");
        }

        Usuario usuario = this.usuarioDAO.buscarPorLoginESenha(login, senha);
        if (usuario == null) {
            throw new IllegalArgumentException("Login ou senha invalidos.");
        }
        return usuario;
    }

    // 1. Função para listar todos os usuários
    public List<Usuario> listar() {
        return this.usuarioDAO.listarTodos();
    }

    // 2. Função para buscar o usuário com base no ID
    public Usuario buscarPorId(Long id) {
        if (id == null) {
            return null;
        }
        return this.usuarioDAO.buscarPorId(id);
    }

    /**
     * Regra de salvamento:
     * - sem id -> cadastro novo
     * - com id -> alteracao (usuario precisa existir)
     */
    public void salvar(Usuario usuario) {
        if (usuario == null) {
            throw new IllegalArgumentException("Usuario e obrigatorio.");
        }

        this.prepararDados(usuario);
        this.validarCamposObrigatorios(usuario);
        this.validarSenha(usuario.getSenha());
        this.validarPerfilExistente(usuario.getPerfilId());
        this.validarLoginUnico(usuario);

        if (usuario.getId() == null) {
            this.usuarioDAO.inserir(usuario);
            return;
        }

        if (this.usuarioDAO.buscarPorId(usuario.getId()) == null) {
            throw new IllegalArgumentException("Usuario nao encontrado para alteracao.");
        }
        this.usuarioDAO.alterar(usuario);
    }

    /**
     * Regra de exclusao:
     * - id obrigatorio
     * - usuario precisa existir
     */
    public void deletar(Long id) {
        if (id == null) {
            throw new IllegalArgumentException("Id e obrigatorio para excluir.");
        }
        if (this.usuarioDAO.buscarPorId(id) == null) {
            throw new IllegalArgumentException("Usuario nao encontrado.");
        }
        this.usuarioDAO.deletar(id);
    }

    // 3. Função auxiliar para preparar e normalizar os campos do usuário
    private void prepararDados(Usuario usuario) {
        usuario.setNome(this.normalizar(usuario.getNome()));
        usuario.setLogin(this.normalizar(usuario.getLogin()));
        usuario.setSenha(this.normalizar(usuario.getSenha()));
    }

    // 4. Função auxiliar para validar campos obrigatórios do usuário
    private void validarCamposObrigatorios(Usuario usuario) {
        if (usuario.getNome() == null) {
            throw new IllegalArgumentException("Nome e obrigatorio.");
        }
        if (usuario.getLogin() == null) {
            throw new IllegalArgumentException("Login e obrigatorio.");
        }
        if (usuario.getSenha() == null) {
            throw new IllegalArgumentException("Senha e obrigatoria.");
        }
        if (usuario.getPerfilId() == null) {
            throw new IllegalArgumentException("Perfil e obrigatorio.");
        }
    }

    // 5. Função auxiliar para validar se a senha atende ao tamanho mínimo
    private void validarSenha(String senha) {
        if (senha.length() < SENHA_MINIMA) {
            throw new IllegalArgumentException("Senha deve ter no minimo " + SENHA_MINIMA + " caracteres.");
        }
    }

    // 6. Função auxiliar para verificar se o perfil associado existe
    private void validarPerfilExistente(Long perfilId) {
        if (this.perfilDAO.buscarPorId(perfilId) == null) {
            throw new IllegalArgumentException("Perfil informado nao existe.");
        }
    }

    // 7. Função auxiliar para garantir que o login do usuário seja único
    private void validarLoginUnico(Usuario usuario) {
        Usuario existente = this.usuarioDAO.buscarPorLogin(usuario.getLogin());
        if (existente == null) {
            return;
        }
        // no cadastro, qualquer login repetido e invalido
        if (usuario.getId() == null) {
            throw new IllegalArgumentException("Ja existe um usuario com este login.");
        }
        // na alteracao, so permite se o login for do proprio usuario
        if (!existente.getId().equals(usuario.getId())) {
            throw new IllegalArgumentException("Ja existe um usuario com este login.");
        }
    }

    // 8. Função auxiliar para normalizar dados (remover espaços vazios)
    private String normalizar(String valor) {
        if (valor == null) {
            return null;
        }
        String limpo = valor.trim();
        return limpo.isEmpty() ? null : limpo;
    }
}
