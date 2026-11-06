<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout titulo="Gênero - Lumina">
    <div class="container mx-auto max-w-2xl p-4 sm:p-6 lg:p-8">

        <div class="mb-8">
            <a href="${pageContext.request.contextPath}/admin/generos"
            class="inline-flex items-center gap-2 text-sm font-medium text-gray-500 transition hover:text-principal">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="m15 18-6-6 6-6"/>
            </svg>
            Voltar para gêneros
        </a>

        <h1 class="mt-4 text-2xl font-bold tracking-tight text-gray-900 sm:text-3xl">
            <c:choose>
                <c:when test="${not empty genero.id}">Editar gênero</c:when>
                    <c:otherwise>Novo gênero</c:otherwise>
                    </c:choose>
                </h1>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/admin/generos"
            class="space-y-6 rounded-2xl border border-gray-200 bg-white p-5 shadow-sm sm:p-8">

            <input type="hidden" name="id" value="<c:out value='${genero.id}'/>"/>

            <div>
                <label for="nome" class="mb-2 block text-sm font-semibold text-gray-700">
                    Nome do Gênero <span class="text-red-500">*</span>
                </label>
                <input type="text" id="nome" name="nome"
                value="<c:out value='${genero.nome}'/>"
                required maxlength="100"
                placeholder="Ex.: Ficção Científica"
                class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20"/>
            </div>

            <div>
                <label for="descricao" class="mb-2 block text-sm font-semibold text-gray-700">
                    Descrição
                </label>
                <textarea id="descricao" name="descricao" rows="4"
                placeholder="Breve resumo sobre o gênero..."
                class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20"><c:out value="${genero.descricao}"/></textarea>
            </div>

            <div class="flex flex-col-reverse gap-3 border-t border-gray-100 pt-6 sm:flex-row sm:justify-end">
                <a href="${pageContext.request.contextPath}/admin/generos"
                class="inline-flex items-center justify-center rounded-xl border border-gray-200 px-5 py-3 text-sm font-semibold text-gray-600 transition hover:bg-gray-50">
                Cancelar
            </a>
            <button type="submit"
            class="inline-flex items-center justify-center gap-2 rounded-xl bg-principal px-5 py-3 text-sm font-semibold text-white shadow-sm transition hover:bg-principal-hover">
            <c:choose>
                <c:when test="${not empty genero.id}">Salvar alterações</c:when>
                    <c:otherwise>Cadastrar gênero</c:otherwise>
                    </c:choose>
                </button>
            </div>
        </form>
    </div>
</t:layout>