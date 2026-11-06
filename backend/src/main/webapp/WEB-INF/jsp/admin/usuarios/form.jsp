<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout titulo="Usuário - Lumina">
    <div class="container mx-auto max-w-2xl p-4 sm:p-6 lg:p-8">

        <%-- Mensagem de erro de validação do Service --%>
        <c:if test="${not empty erro}">
            <div class="mb-6 rounded-xl bg-red-50 p-4 text-sm font-medium text-red-700 border border-red-200">
                <c:out value="${erro}"/>
            </div>
        </c:if>

        <div class="mb-8">
            <a href="${pageContext.request.contextPath}/admin/usuarios"
            class="inline-flex items-center gap-2 text-sm font-medium text-gray-500 transition hover:text-principal">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="m15 18-6-6 6-6"/>
            </svg>
            Voltar para usuários
        </a>

        <h1 class="mt-4 text-2xl font-bold tracking-tight text-gray-900 sm:text-3xl">
            <c:choose>
                <c:when test="${not empty usuario.id}">Editar usuário</c:when>
                    <c:otherwise>Novo usuário</c:otherwise>
                    </c:choose>
                </h1>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/admin/usuarios"
            class="space-y-6 rounded-2xl border border-gray-200 bg-white p-5 shadow-sm sm:p-8">

            <input type="hidden" name="id" value="<c:out value='${usuario.id}'/>"/>

            <div>
                <label for="nome" class="mb-2 block text-sm font-semibold text-gray-700">
                    Nome Completo <span class="text-red-500">*</span>
                </label>
                <input type="text" id="nome" name="nome"
                value="<c:out value='${usuario.nome}'/>"
                required maxlength="150"
                placeholder="Ex.: João da Silva"
                class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20"/>
            </div>

            <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
                <div>
                    <label for="login" class="mb-2 block text-sm font-semibold text-gray-700">
                        Login de Acesso <span class="text-red-500">*</span>
                    </label>
                    <input type="text" id="login" name="login"
                    value="<c:out value='${usuario.login}'/>"
                    required maxlength="100"
                    placeholder="Ex.: joao.silva"
                    class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20"/>
                </div>

                <div>
                    <label for="senha" class="mb-2 block text-sm font-semibold text-gray-700">
                        Senha <span class="text-red-500">*</span>
                    </label>
                    <input type="password" id="senha" name="senha"
                    value="<c:out value='${usuario.senha}'/>"
                    required minlength="6" maxlength="255"
                    placeholder="Mínimo 6 caracteres"
                    class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20"/>
                </div>
            </div>

            <%-- Select de Perfis: Administrador (1) ou Comum (2) --%>
            <div>
                <label for="perfilId" class="mb-2 block text-sm font-semibold text-gray-700">
                    Tipo de Perfil <span class="text-red-500">*</span>
                </label>
                <select id="perfilId" name="perfilId" required
                class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-3 text-gray-900 outline-none transition focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20">
                <option value="2" ${usuario.perfilId == 2 ? 'selected' : ''}>Comum (Leitor)</option>
                <option value="1" ${usuario.perfilId == 1 ? 'selected' : ''}>Administrador</option>
            </select>
            <p class="mt-2 text-xs text-gray-400">
                Administradores têm acesso ao painel de controle e gerenciamento.
            </p>
        </div>

        <div class="flex flex-col-reverse gap-3 border-t border-gray-100 pt-6 sm:flex-row sm:justify-end">
            <a href="${pageContext.request.contextPath}/admin/usuarios"
            class="inline-flex items-center justify-center rounded-xl border border-gray-200 px-5 py-3 text-sm font-semibold text-gray-600 transition hover:bg-gray-50">
            Cancelar
        </a>
        <button type="submit"
        class="inline-flex items-center justify-center gap-2 rounded-xl bg-principal px-5 py-3 text-sm font-semibold text-white shadow-sm transition hover:bg-principal-hover">
        <c:choose>
            <c:when test="${not empty usuario.id}">Salvar alterações</c:when>
                <c:otherwise>Cadastrar usuário</c:otherwise>
                </c:choose>
            </button>
        </div>
    </form>
</div>
</t:layout>