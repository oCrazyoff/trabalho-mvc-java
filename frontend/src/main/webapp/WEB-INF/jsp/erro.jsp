<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%-- Código de status enviado pelo Tomcat quando ocorre um erro (configurado no web.xml) --%>
<c:set var="status" value="${requestScope['jakarta.servlet.error.status_code']}" />
<c:if test="${empty status}">
    <c:set var="status" value="500" />
</c:if>

<%-- Título e mensagem de acordo com o tipo de erro --%>
<c:choose>
    <c:when test="${status == 400}">
        <c:set var="tituloErro" value="Requisição inválida" />
        <c:set var="mensagemErro" value="Os dados enviados não puderam ser processados. Verifique as informações e tente novamente." />
    </c:when>
    <c:when test="${status == 401}">
        <c:set var="tituloErro" value="Acesso não autorizado" />
        <c:set var="mensagemErro" value="Você precisa estar autenticado para acessar esta página. Faça login para continuar." />
    </c:when>
    <c:when test="${status == 403}">
        <c:set var="tituloErro" value="Acesso negado" />
        <c:set var="mensagemErro" value="Você não tem permissão para acessar esta página." />
    </c:when>
    <c:when test="${status == 404}">
        <c:set var="tituloErro" value="Página não encontrada" />
        <c:set var="mensagemErro" value="A página que você procura não existe ou foi removida." />
    </c:when>
    <c:when test="${status == 405}">
        <c:set var="tituloErro" value="Método não permitido" />
        <c:set var="mensagemErro" value="Esta ação não é permitida para a página solicitada." />
    </c:when>
    <c:when test="${status == 503}">
        <c:set var="tituloErro" value="Serviço indisponível" />
        <c:set var="mensagemErro" value="O serviço está temporariamente indisponível. Tente novamente em alguns instantes." />
    </c:when>
    <c:otherwise>
        <c:set var="tituloErro" value="Erro interno" />
        <c:set var="mensagemErro" value="Ocorreu um erro inesperado ao processar sua solicitação. Tente novamente mais tarde." />
    </c:otherwise>
</c:choose>

<t:layout titulo="Erro ${status} - Lumina">

    <main class="min-h-screen bg-gray-50 flex items-center justify-center px-4 py-8 sm:px-6 lg:px-8">

        <div class="relative w-full max-w-lg overflow-hidden bg-white rounded-3xl
                    shadow-xl shadow-gray-200/60 border border-gray-100
                    px-6 py-10 sm:px-10 sm:py-12 text-center">

            <%-- Elementos decorativos --%>
            <div class="absolute top-0 right-0 w-40 h-40 rounded-full bg-principal/5
                        -translate-y-1/2 translate-x-1/2">
            </div>
            <div class="absolute bottom-0 left-0 w-32 h-32 rounded-full bg-principal/5
                        translate-y-1/2 -translate-x-1/2">
            </div>

            <div class="relative z-10 flex flex-col items-center">

                <img src="${pageContext.request.contextPath}/images/logo.png"
                     alt="Logo Lumina"
                     class="w-16 h-16 object-contain rounded-xl bg-principal/10 p-2 mb-6">

                <span class="text-xs sm:text-sm font-semibold uppercase tracking-[0.2em] text-gray-400">
                    Erro
                </span>

                <p class="text-7xl sm:text-8xl font-bold tracking-tight text-principal leading-none mt-2">
                    <c:out value="${status}" />
                </p>

                <div class="w-12 h-1 bg-principal/30 rounded-full my-6"></div>

                <h1 class="text-2xl sm:text-3xl font-bold text-gray-900">
                    <c:out value="${tituloErro}" />
                </h1>

                <p class="mt-3 text-sm sm:text-base text-gray-500 leading-relaxed max-w-sm">
                    <c:out value="${mensagemErro}" />
                </p>

                <a href="${pageContext.request.contextPath}/login"
                   class="mt-8 inline-flex items-center justify-center gap-2 w-full sm:w-auto
                          rounded-xl bg-principal px-6 py-3 text-sm font-semibold text-white
                          shadow-lg shadow-principal/20 transition
                          hover:bg-principal-hover focus:outline-none focus:ring-2 focus:ring-principal/30">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="none" viewBox="0 0 24 24"
                         stroke="currentColor" stroke-width="2" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
                    </svg>
                    Voltar para o login
                </a>

            </div>
        </div>

    </main>

</t:layout>
