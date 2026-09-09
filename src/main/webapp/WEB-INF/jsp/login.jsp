<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout titulo="Login - Lumina">
    <div class="p-20 flex items-center justify-center h-dvh w-full bg-gray-100 shadow-lg">
        <div class="bg-principal text-white p-10 flex flex-col gap-5 items-center justify-center rounded-s-xl h-full w-1/2">
            <h1 class="text-2xl font-bold">Sistema de Recomendação de Livros</h1>
            <p class="text-white/80">Entre com login e senha para acessar o sistema.</p>

            <img class="bg-white p-2 w-50 h-50 object-cover rounded-xl" src="${pageContext.request.contextPath}/images/logo.png" alt="Logo do sistema">

        </div>

        <div class="bg-white rounded-r-xl p-10 flex flex-col gap-5 justify-center h-full w-1/2">
            <h2 class="text-2xl font-bold">Acesso ao Lumina</h2>
            <p class="text-gray-600">
                Descubra novas histórias, encontre livros que combinam com você e transforme cada leitura em uma nova experiência.
            </p>

            <form class="flex flex-col gap-5" method="post" action="${pageContext.request.contextPath}/login">

                <c:if test="${not empty erro}">
                    <div class="bg-red-100 border border-red-500 text-red-700 px-4 py-3 rounded-lg" role="alert">
                        ${erro}
                    </div>
                </c:if>

                <div class="flex flex-col gap-2">
                    <label for="login">Login</label>
                    <input class="border border-gray-300 rounded-lg p-2" type="text" id="login" name="login" required autofocus>
                </div>

                <div class="flex flex-col gap-2">
                    <label for="senha">Senha</label>
                    <input class="border border-gray-300 rounded-lg p-2" type="password" id="senha" name="senha" required>
                </div>

                <button type="submit" class="bg-principal text-white p-2 rounded-lg flex items-center justify-center gap-2 hover:bg-principal-hover transition-colors cursor-pointer">Entrar <i data-lucide="move-right"></i></button>
            </form>

            <p>Ainda não possui cadastro? <a class="text-principal hover:underline" href="#">Crie sua conta!</a></p>
        </div>
    </div>
</t:layout>