<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout titulo="Usuários - Lumina">
    <div class="container mx-auto max-w-7xl p-4 sm:p-6 lg:p-8">

        <%-- Mensagem de erro ao tentar excluir --%>
        <c:if test="${not empty erro}">
            <div class="mb-6 rounded-xl border border-red-200 bg-red-50 p-4 text-sm font-medium text-red-700">
                <c:out value="${erro}"/>
            </div>
        </c:if>

        <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
            <div>
                <span class="text-sm font-semibold uppercase tracking-wider text-principal">
                    Administração
                </span>
                <h1 class="mt-2 text-2xl font-bold tracking-tight text-gray-900 sm:text-3xl">
                    Usuários do Sistema
                </h1>
                <p class="mt-2 text-gray-500">
                    Gerencie os usuários e seus níveis de permissão.
                </p>
            </div>

            <a href="${pageContext.request.contextPath}/admin/usuarios?acao=novo"
            class="inline-flex items-center justify-center gap-2 rounded-xl bg-principal px-5 py-3 text-sm font-semibold text-white shadow-sm transition hover:bg-principal-hover focus:outline-none focus:ring-2 focus:ring-principal">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 5v14m-7-7h14"/>
            </svg>
            Novo Usuário
        </a>
    </div>

    <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm">
        <div class="border-b border-gray-100 px-5 py-4 sm:px-6">
            <h2 class="font-semibold text-gray-900">Usuários cadastrados</h2>
        </div>

        <c:choose>
            <c:when test="${not empty usuarios}">
                <div class="overflow-x-auto">
                    <table class="w-full min-w-[640px] divide-y divide-gray-100 text-left">
                        <thead class="bg-gray-50">
                            <tr class="text-xs font-semibold uppercase tracking-wider text-gray-500">
                                <th scope="col" class="px-5 py-4">Nome</th>
                                <th scope="col" class="px-5 py-4">Login</th>
                                <th scope="col" class="px-5 py-4">Perfil</th>
                                <th scope="col" class="px-5 py-4 text-right">Ações</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            <c:forEach var="u" items="${usuarios}">
                                <tr class="transition hover:bg-gray-50/70">
                                    <td class="px-5 py-4 font-semibold text-gray-900">
                                        <c:out value="${u.nome}"/>
                                    </td>
                                    <td class="px-5 py-4 text-sm text-gray-600">
                                        <c:out value="${u.login}"/>
                                    </td>
                                    <td class="px-5 py-4 text-sm">
                                        <span class="inline-flex items-center rounded-full px-2.5 py-1 text-xs font-semibold ${u.perfilId == 1 ? 'bg-purple-100 text-purple-700' : 'bg-blue-100 text-blue-700'}">
                                            <c:out value="${not empty u.perfil ? u.perfil.nome : (u.perfilId == 1 ? 'Administrador' : 'Comum')}"/>
                                        </span>
                                    </td>
                                    <td class="px-5 py-4 text-right">
                                        <div class="flex items-center justify-end gap-2">
                                            <a href="${pageContext.request.contextPath}/admin/usuarios?acao=editar&id=${u.id}"
                                            class="inline-flex items-center gap-1.5 rounded-lg border border-principal/20 px-3 py-2 text-sm font-medium text-principal transition hover:bg-principal/10 focus:outline-none focus:ring-2 focus:ring-principal"
                                            aria-label="Editar usuário">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 2.651 2.651M4 20l4.5-1 11.013-11.013a1.875 1.875 0 0 0-2.652-2.652L5.848 16.348 4 20Z"/>
                                            </svg>
                                            Editar
                                        </a>

                                        <a href="${pageContext.request.contextPath}/admin/usuarios?acao=excluir&id=${u.id}"
                                        onclick="return confirm('Deseja excluir o usuário ${u.nome}?')"
                                        class="inline-flex items-center gap-1.5 rounded-lg border border-red-200 px-3 py-2 text-sm font-medium text-red-600 transition hover:bg-red-50 focus:outline-none focus:ring-2 focus:ring-red-400"
                                        aria-label="Excluir usuário">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M6 7h12m-10 0 .7 13h6.6L16 7M9 7V4h6v3m-5 3v6m4-6v6"/>
                                        </svg>
                                        Excluir
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:when>
    <c:otherwise>
        <div class="py-12 text-center text-gray-500">
            Nenhum usuário cadastrado.
        </div>
    </c:otherwise>
</c:choose>
</div>

</div>
</t:layout>