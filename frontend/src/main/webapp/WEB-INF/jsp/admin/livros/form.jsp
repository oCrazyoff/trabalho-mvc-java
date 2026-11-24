
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout titulo="Livro - Lumina">
    <div class="container mx-auto max-w-3xl p-4 sm:p-6 lg:p-8">

        <%-- Mensagem de erro de validação da API --%>
        <c:if test="${not empty erro}">
            <div class="mb-6 rounded-xl bg-red-50 p-4 text-sm font-medium text-red-700 border border-red-200">
                <c:out value="${erro}"/>
            </div>
        </c:if>

        <div class="mb-8">
            <a href="${pageContext.request.contextPath}/admin/livros"
            class="inline-flex items-center gap-2 text-sm font-medium text-gray-500 transition hover:text-principal">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4"
            fill="none" viewBox="0 0 24 24"
            stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round"
            d="m15 18-6-6 6-6"/>
        </svg>
        Voltar para livros
    </a>

    <h1 class="mt-4 text-2xl font-bold tracking-tight text-gray-900 sm:text-3xl">
        <c:choose>
            <c:when test="${not empty livro.id}">Editar livro</c:when>
                <c:otherwise>Novo livro</c:otherwise>
                </c:choose>
            </h1>
            <p class="mt-2 text-gray-500">
                Preencha as informações do livro para salvar no acervo.
            </p>
        </div>

        <form method="post"
        action="${pageContext.request.contextPath}/admin/livros"
        class="space-y-6 rounded-2xl border border-gray-200 bg-white p-5 shadow-sm sm:p-8">

        <input type="hidden" name="id" value="<c:out value='${livro.id}'/>"/>

        <div>
            <label for="titulo" class="mb-2 block text-sm font-semibold text-gray-700">
                Título <span class="text-red-500">*</span>
            </label>
            <input type="text" id="titulo" name="titulo"
            value="<c:out value='${livro.titulo}'/>"
            required maxlength="200"
            placeholder="Ex.: O Chamado de Cthulhu"
            class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20"/>
        </div>

        <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
            <div>
                <label for="autor" class="mb-2 block text-sm font-semibold text-gray-700">
                    Autor <span class="text-red-500">*</span>
                </label>
                <input type="text" id="autor" name="autor"
                value="<c:out value='${livro.autor}'/>"
                required maxlength="150"
                placeholder="Nome do autor"
                class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20"/>
            </div>

            <div>
                <label for="editora" class="mb-2 block text-sm font-semibold text-gray-700">
                    Editora
                </label>
                <input type="text" id="editora" name="editora"
                value="<c:out value='${livro.editora}'/>"
                maxlength="150"
                placeholder="Nome da editora"
                class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20"/>
            </div>

            <div>
                <label for="anoPublicacao" class="mb-2 block text-sm font-semibold text-gray-700">
                    Ano de publicação
                </label>
                <input type="number" id="ano" name="anoPublicacao"
                value="<c:out value='${livro.anoPublicacao}'/>"
                min="0" max="2100" step="1"
                placeholder="Ex.: 1928"
                class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20"/>
            </div>

            <div>
                <label for="capaUrl" class="mb-2 block text-sm font-semibold text-gray-700">
                    URL da capa
                </label>
                <input type="url" id="capa" name="capaUrl"
                value="<c:out value='${livro.capaUrl}'/>"
                placeholder="https://..."
                class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20"/>
            </div>

            <div>
                <label for="isbn" class="mb-2 block text-sm font-semibold text-gray-700">
                    ISBN
                </label>
                <input type="text" id="isbn" name="isbn"
                value="<c:out value='${livro.isbn}'/>"
                maxlength="20"
                placeholder="Ex.: 9788535914849"
                class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20"/>
            </div>

            <div>
                <label for="numPaginas" class="mb-2 block text-sm font-semibold text-gray-700">
                    Número de páginas
                </label>
                <input type="number" id="numPaginas" name="numPaginas"
                value="<c:out value='${livro.numPaginas}'/>"
                min="1" step="1"
                placeholder="Ex.: 320"
                class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20"/>
            </div>
        </div>

        <div>
            <label for="sinopse" class="mb-2 block text-sm font-semibold text-gray-700">
                Sinopse
            </label>
            <textarea id="sinopse" name="sinopse" rows="4"
            placeholder="Um breve resumo da história..."
            class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20"><c:out value="${livro.sinopse}"/></textarea>
        </div>

        <%-- Gêneros do livro: usados nas recomendações --%>
        <fieldset>
            <legend class="mb-2 block text-sm font-semibold text-gray-700">
                Gêneros <span class="text-red-500">*</span>
            </legend>
            <p class="mb-3 text-xs text-gray-400">
                O livro será recomendado para quem tiver algum destes gêneros como favorito.
            </p>

            <div class="grid grid-cols-1 gap-3 sm:grid-cols-2">
                <c:forEach items="${generos}" var="g">
                    <c:set var="marcado" value="${not empty livro.generosIds and livro.generosIds.contains(g.id)}" />
                    <label class="flex cursor-pointer items-center gap-3 rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-sm text-gray-700 transition hover:border-principal has-[:checked]:border-principal has-[:checked]:bg-principal/5">
                        <input type="checkbox" name="generosIds" value="${g.id}"
                        ${marcado ? 'checked' : ''}
                        class="h-4 w-4 rounded border-gray-300 accent-principal"/>
                        <c:out value="${g.nome}"/>
                    </label>
                </c:forEach>
            </div>

            <c:if test="${empty generos}">
                <p class="text-sm text-gray-500">
                    Nenhum gênero cadastrado.
                    <a href="${pageContext.request.contextPath}/admin/generos?acao=novo" class="font-semibold text-principal hover:underline">Cadastre um gênero</a>
                    antes de cadastrar livros.
                </p>
            </c:if>
        </fieldset>

        <div class="flex flex-col-reverse gap-3 border-t border-gray-100 pt-6 sm:flex-row sm:justify-end">
            <a href="${pageContext.request.contextPath}/admin/livros"
            class="inline-flex items-center justify-center rounded-xl border border-gray-200 px-5 py-3 text-sm font-semibold text-gray-600 transition hover:bg-gray-50">
            Cancelar
        </a>

        <button type="submit"
        class="inline-flex items-center justify-center gap-2 rounded-xl bg-principal px-5 py-3 text-sm font-semibold text-white shadow-sm transition hover:bg-principal-hover focus:outline-none focus:ring-2 focus:ring-principal focus:ring-offset-2">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5"
        fill="none" viewBox="0 0 24 24"
        stroke="currentColor" stroke-width="2">
        <path stroke-linecap="round" stroke-linejoin="round"
        d="m5 12 4 4L19 6"/>
    </svg>
    <c:choose>
        <c:when test="${not empty livro.id}">Salvar alterações</c:when>
            <c:otherwise>Cadastrar livro</c:otherwise>
            </c:choose>
        </button>
    </div>
</form>
</div>
</t:layout>