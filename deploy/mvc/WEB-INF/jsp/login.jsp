<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout titulo="Login - Sistema de Recomendação de Livros">
    <div class="login-page">
        <div class="card login-card">
            <h1>Sistema de Recomendação de Livros</h1>
            <p>Entre com login e senha para acessar o sistema.</p>

            <c:if test="${not empty erro}">
                <div class="alert alert-erro">${erro}</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/login">
                <div class="form-group">
                    <label for="login">Login</label>
                    <input type="text" id="login" name="login" required autofocus>
                </div>
                <div class="form-group">
                    <label for="senha">Senha</label>
                    <input type="password" id="senha" name="senha" required>
                </div>
                <div class="actions">
                    <button type="submit" class="btn">Entrar</button>
                </div>
            </form>
        </div>
    </div>
</t:layout>