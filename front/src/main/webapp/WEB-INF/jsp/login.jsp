
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout titulo="Login - Lumina">

    <main class="min-h-screen bg-gray-50 flex items-center justify-center
                 px-4 py-8 sm:px-6 lg:px-8">

        <div class="w-full max-w-5xl grid grid-cols-1 md:grid-cols-2
                    bg-white rounded-3xl overflow-hidden
                    shadow-xl shadow-gray-200/60 border border-gray-100">


            <%-- Painel de apresentação --%>
            <section class="relative bg-principal text-white
                            flex flex-col items-center justify-center
                            text-center px-6 py-10 sm:p-12
                            md:min-h-[600px]">

                <%-- Elementos decorativos --%>
                <div class="absolute top-0 right-0 w-48 h-48
                            rounded-full bg-white/5 -translate-y-1/2 translate-x-1/2">
                </div>

                <div class="absolute bottom-0 left-0 w-36 h-36
                            rounded-full bg-white/5 translate-y-1/2 -translate-x-1/2">
                </div>


                <div class="relative z-10 flex flex-col items-center">

                    <div class="bg-white/15 border border-white/20
                                rounded-2xl p-2 mb-6">

                        <img
                            src="${pageContext.request.contextPath}/images/logo.png"
                            alt="Logo Lumina"
                            class="w-20 h-20 sm:w-24 sm:h-24
                                   object-contain rounded-xl bg-white p-2">

                    </div>

                    <span class="text-xs sm:text-sm font-semibold
                                 uppercase tracking-[0.2em] text-white/70">
                        Bem-vindo ao
                    </span>

                    <h1 class="text-4xl sm:text-5xl font-bold
                               tracking-tight mt-2">
                        Lumina
                    </h1>

                    <div class="w-12 h-1 bg-white/50 rounded-full my-6">
                    </div>

                    <h2 class="text-xl sm:text-2xl font-semibold
                               leading-snug max-w-sm">
                        Sua próxima história começa aqui.
                    </h2>

                    <p class="text-sm sm:text-base text-white/80
                              leading-relaxed mt-4 max-w-sm">
                        Descubra livros que combinam com você
                        e encontre novas histórias para se apaixonar.
                    </p>

                </div>


                <div class="relative z-10 mt-8 md:mt-auto md:pt-10">
                    <p class="text-xs text-white/60">
                        Explore. Descubra. Leia.
                    </p>
                </div>

            </section>


            <%-- Formulário de acesso --%>
            <section class="flex flex-col justify-center
                            px-6 py-10 sm:px-10 md:px-12 lg:px-14">

                <div class="mb-8">

                    <span class="text-xs font-bold text-principal
                                 uppercase tracking-widest">
                        Acesse sua conta
                    </span>

                    <h2 class="text-3xl font-bold text-gray-900 mt-2">
                        Olá novamente!
                    </h2>

                    <p class="text-sm text-gray-500 mt-3 leading-relaxed">
                        Entre com seus dados para continuar explorando
                        sua biblioteca.
                    </p>

                </div>


                <form
                    class="flex flex-col gap-5"
                    method="post"
                    action="${pageContext.request.contextPath}/login">

                    <%-- Mensagem de erro --%>
                    <c:if test="${not empty erro}">

                        <div class="flex items-start gap-3
                                    bg-red-50 border border-red-200
                                    text-red-700 rounded-xl p-4"
                             role="alert">

                            <svg xmlns="http://www.w3.org/2000/svg"
                                 width="20" height="20"
                                 viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor"
                                 stroke-width="2"
                                 stroke-linecap="round"
                                 stroke-linejoin="round"
                                 class="shrink-0 mt-0.5">

                                <circle cx="12" cy="12" r="10"/>
                                <path d="M12 8v4"/>
                                <path d="M12 16h.01"/>

                            </svg>

                            <div>
                                <p class="text-sm font-semibold">
                                    Não foi possível entrar
                                </p>

                                <p class="text-sm mt-1">
                                    <c:out value="${erro}"/>
                                </p>
                            </div>

                        </div>

                    </c:if>


                    <%-- Campo de login --%>
                    <div class="flex flex-col gap-2">

                        <label for="login"
                               class="text-sm font-semibold text-gray-700">
                            Login
                        </label>

                        <div class="relative">

                            <div class="absolute inset-y-0 left-0
                                        flex items-center pl-4
                                        pointer-events-none text-gray-400">

                                <svg xmlns="http://www.w3.org/2000/svg"
                                     width="19" height="19"
                                     viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor"
                                     stroke-width="1.8"
                                     stroke-linecap="round"
                                     stroke-linejoin="round">

                                    <circle cx="12" cy="8" r="4"/>
                                    <path d="M5 21v-2a7 7 0 0 1 14 0v2"/>

                                </svg>

                            </div>

                            <input
                                type="text"
                                id="login"
                                name="login"
                                placeholder="Digite seu login"
                                autocomplete="username"
                                required
                                autofocus
                                class="w-full rounded-xl border border-gray-200
                                       bg-gray-50/50 py-3.5 pl-12 pr-4
                                       text-sm text-gray-900
                                       placeholder:text-gray-400
                                       outline-none
                                       transition-all
                                       focus:border-principal
                                       focus:ring-4 focus:ring-principal/10
                                       focus:bg-white">

                        </div>

                    </div>


                    <%-- Campo de senha --%>
                    <div class="flex flex-col gap-2">

                        <label for="senha"
                               class="text-sm font-semibold text-gray-700">
                            Senha
                        </label>

                        <div class="relative">

                            <div class="absolute inset-y-0 left-0
                                        flex items-center pl-4
                                        pointer-events-none text-gray-400">

                                <svg xmlns="http://www.w3.org/2000/svg"
                                     width="19" height="19"
                                     viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor"
                                     stroke-width="1.8"
                                     stroke-linecap="round"
                                     stroke-linejoin="round">

                                    <rect x="3" y="11" width="18" height="11" rx="2"/>
                                    <path d="M7 11V7a5 5 0 0 1 10 0v4"/>

                                </svg>

                            </div>

                            <input
                                type="password"
                                id="senha"
                                name="senha"
                                placeholder="Digite sua senha"
                                autocomplete="current-password"
                                required
                                class="w-full rounded-xl border border-gray-200
                                       bg-gray-50/50 py-3.5 pl-12 pr-4
                                       text-sm text-gray-900
                                       placeholder:text-gray-400
                                       outline-none
                                       transition-all
                                       focus:border-principal
                                       focus:ring-4 focus:ring-principal/10
                                       focus:bg-white">

                        </div>

                    </div>


                    <%-- Botão de acesso --%>
                    <button
                        type="submit"
                        class="group w-full flex items-center
                               justify-center gap-3
                               bg-principal text-white
                               font-semibold text-sm
                               py-3.5 px-5 rounded-xl
                               shadow-md shadow-principal/20
                               hover:bg-principal-hover
                               hover:shadow-lg
                               active:scale-[0.99]
                               transition-all duration-200
                               cursor-pointer">

                        Entrar na minha conta

                        <svg xmlns="http://www.w3.org/2000/svg"
                             width="18" height="18"
                             viewBox="0 0 24 24"
                             fill="none" stroke="currentColor"
                             stroke-width="2"
                             stroke-linecap="round"
                             stroke-linejoin="round"
                             class="group-hover:translate-x-1
                                    transition-transform">

                            <path d="M5 12h14"/>
                            <path d="m12 5 7 7-7 7"/>

                        </svg>

                    </button>

                </form>


                <%-- Cadastro --%>
                <div class="mt-8 pt-6 border-t border-gray-100
                            text-center">

                    <p class="text-sm text-gray-500">
                        Ainda não possui uma conta?

                        <a href="${pageContext.request.contextPath}/cadastro"
                        class="font-semibold text-principal hover:underline underline-offset-4 transition-colors">
                            Crie sua conta
                        </a>
                    </p>

                </div>

            </section>

        </div>

    </main>

</t:layout>