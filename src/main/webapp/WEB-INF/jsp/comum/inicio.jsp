<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout titulo="Início - Lumina">
    <div class="container mx-auto p-6">
        <h1 class="text-2xl font-bold text-gray-800">Bem-vindo(a), ${usuarioLogado.nome}!</h1>
        <p class="text-gray-600 mt-2">Esta é a sua página inicial de livros e recomendações.</p>
    </div>
</t:layout>