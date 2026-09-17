
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout titulo="Cadastro - Lumina">

    <main class="min-h-screen bg-gray-50 flex items-center justify-center
                 px-4 py-8 sm:px-6 lg:px-8">
        <div class="mx-auto grid min-h-[650px] w-full max-w-5xl grid-cols-1 overflow-hidden rounded-3xl border border-gray-100 bg-white shadow-xl shadow-gray-200/60 md:grid-cols-2">

            <%-- Painel de apresentação --%>
            <section class="relative flex flex-col items-center justify-center overflow-hidden bg-principal px-6 py-10 text-center text-white sm:px-10 md:min-h-[650px]">

                <%-- Elementos decorativos --%>
                <div class="pointer-events-none absolute -right-16 -top-16 h-56 w-56 rounded-full bg-white/5"></div>
                <div class="pointer-events-none absolute -bottom-16 -left-16 h-48 w-48 rounded-full bg-white/5"></div>

                <div class="relative z-10 flex flex-col items-center">
                    <div class="mb-6 rounded-2xl border border-white/20 bg-white/15 p-2">
                        <img
                            src="${pageContext.request.contextPath}/images/logo.png"
                            alt="Logo Lumina"
                            class="h-20 w-20 rounded-xl bg-white object-contain p-2 sm:h-24 sm:w-24">
                    </div>

                    <span class="text-xs font-semibold uppercase tracking-[0.2em] text-white/70 sm:text-sm">
                        Bem-vindo ao
                    </span>

                    <h1 class="mt-2 text-4xl font-bold tracking-tight sm:text-5xl">
                        Lumina
                    </h1>

                    <div class="my-6 h-1 w-12 rounded-full bg-white/50"></div>

                    <h2 class="max-w-sm text-xl font-semibold leading-snug sm:text-2xl">
                        Sua próxima história começa aqui.
                    </h2>

                    <p class="mt-4 max-w-sm text-sm leading-relaxed text-white/80 sm:text-base">
                        Descubra livros que combinam com você e encontre novas histórias para se apaixonar.
                    </p>
                </div>

                <p class="relative z-10 mt-8 text-xs text-white/60 md:absolute md:bottom-8">
                    Explore. Descubra. Leia.
                </p>
            </section>

            <%-- Formulário de cadastro --%>
            <section class="flex flex-col justify-center px-6 py-8 sm:px-10 sm:py-10 lg:px-12">

                <div class="mb-6">
                    <span class="text-xs font-bold uppercase tracking-widest text-principal">
                        Crie sua conta
                    </span>

                    <h2 class="mt-2 text-3xl font-bold tracking-tight text-gray-900">
                        Junte-se à Lumina
                    </h2>

                    <p class="mt-2 text-sm leading-relaxed text-gray-500">
                        Crie seu perfil e receba recomendações dos seus livros favoritos.
                    </p>
                </div>

                <form
                    id="formCadastro"
                    class="flex flex-col gap-4"
                    method="post"
                    action="${pageContext.request.contextPath}/cadastro">

                    <%-- Mensagem de erro enviada pelo Servlet --%>
                    <c:if test="${not empty erro}">
                        <div role="alert"
                             class="flex items-start gap-3 rounded-xl border border-red-200 bg-red-50 p-3 text-sm text-red-700">
                            <svg xmlns="http://www.w3.org/2000/svg"
                                 class="mt-0.5 h-5 w-5 shrink-0"
                                 fill="none" viewBox="0 0 24 24"
                                 stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                      d="M12 9v4m0 4h.01M10.3 3.9 2.8 17a2 2 0 0 0 1.7 3h15a2 2 0 0 0 1.7-3l-7.5-13.1a2 2 0 0 0-3.4 0Z"/>
                            </svg>
                            <c:out value="${erro}"/>
                        </div>
                    </c:if>

                    <%-- Nome --%>
                    <div class="flex flex-col gap-1.5">
                        <label for="nome" class="text-sm font-semibold text-gray-700">
                            Nome completo <span class="text-red-500">*</span>
                        </label>

                        <input
                            type="text"
                            id="nome"
                            name="nome"
                            value="<c:out value='${usuario.nome}'/>"
                            placeholder="Como podemos te chamar?"
                            autocomplete="name"
                            maxlength="120"
                            required
                            autofocus
                            class="w-full rounded-xl border border-gray-200 bg-gray-50/50 px-4 py-3 text-sm text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20">
                    </div>

                    <%-- Login --%>
                    <div class="flex flex-col gap-1.5">
                        <label for="login" class="text-sm font-semibold text-gray-700">
                            Nome de usuário <span class="text-red-500">*</span>
                        </label>

                        <input
                            type="text"
                            id="login"
                            name="login"
                            value="<c:out value='${usuario.login}'/>"
                            placeholder="Escolha um nome de usuário"
                            autocomplete="username"
                            maxlength="50"
                            required
                            class="w-full rounded-xl border border-gray-200 bg-gray-50/50 px-4 py-3 text-sm text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20">

                        <p class="text-xs text-gray-400">
                            Você usará esse nome para entrar na sua conta.
                        </p>
                    </div>

                    <%-- Senha --%>
                    <div class="flex flex-col gap-1.5">
                        <label for="senha" class="text-sm font-semibold text-gray-700">
                            Senha <span class="text-red-500">*</span>
                        </label>

                        <div class="relative">
                            <input
                                type="password"
                                id="senha"
                                name="senha"
                                placeholder="Crie uma senha"
                                autocomplete="new-password"
                                minlength="6"
                                required
                                class="w-full rounded-xl border border-gray-200 bg-gray-50/50 px-4 py-3 pr-20 text-sm text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20">

                            <button
                                type="button"
                                id="toggleSenha"
                                class="absolute inset-y-0 right-3 my-auto h-fit rounded-md px-2 py-1 text-xs font-semibold text-principal hover:bg-principal/10 focus:outline-none focus:ring-2 focus:ring-principal"
                                aria-controls="senha"
                                aria-pressed="false">
                                Mostrar
                            </button>
                        </div>

                        <p class="text-xs text-gray-400">
                            Use pelo menos 6 caracteres.
                        </p>
                    </div>

                    <%-- Confirmação de senha --%>
                    <div class="flex flex-col gap-1.5">
                        <label for="confirmarSenha" class="text-sm font-semibold text-gray-700">
                            Confirmar senha <span class="text-red-500">*</span>
                        </label>

                        <input
                            type="password"
                            id="confirmarSenha"
                            name="confirmarSenha"
                            placeholder="Digite a senha novamente"
                            autocomplete="new-password"
                            minlength="6"
                            required
                            class="w-full rounded-xl border border-gray-200 bg-gray-50/50 px-4 py-3 text-sm text-gray-900 outline-none transition placeholder:text-gray-400 focus:border-principal focus:bg-white focus:ring-2 focus:ring-principal/20">

                        <p id="mensagemSenha" class="hidden text-xs text-red-600" aria-live="polite">
                            As senhas não coincidem.
                        </p>
                    </div>

                    <button
                        type="submit"
                        class="mt-2 flex w-full items-center justify-center gap-2 rounded-xl bg-principal px-5 py-3.5 text-sm font-semibold text-white shadow-md shadow-principal/20 transition hover:bg-principal-hover focus:outline-none focus:ring-2 focus:ring-principal focus:ring-offset-2">

                        Criar minha conta

                        <svg xmlns="http://www.w3.org/2000/svg"
                             class="h-4 w-4"
                             fill="none" viewBox="0 0 24 24"
                             stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                  d="M5 12h14m-7-7 7 7-7 7"/>
                        </svg>
                    </button>
                </form>

                <div class="mt-6 border-t border-gray-100 pt-5 text-center">
                    <p class="text-sm text-gray-500">
                        Já possui uma conta?
                        <a
                            href="${pageContext.request.contextPath}/login"
                            class="font-semibold text-principal underline-offset-4 transition hover:underline">
                            Entrar na minha conta
                        </a>
                    </p>
                </div>
            </section>
        </div>
    </main>

    <script>
        const senha = document.getElementById("senha");
        const confirmarSenha = document.getElementById("confirmarSenha");
        const mensagemSenha = document.getElementById("mensagemSenha");
        const toggleSenha = document.getElementById("toggleSenha");
        const formCadastro = document.getElementById("formCadastro");

        function validarSenhas() {
            const senhasDiferentes =
                confirmarSenha.value.length > 0 &&
                senha.value !== confirmarSenha.value;

            confirmarSenha.setCustomValidity(
                senhasDiferentes ? "As senhas não coincidem." : ""
            );

            mensagemSenha.classList.toggle("hidden", !senhasDiferentes);
        }

        senha.addEventListener("input", validarSenhas);
        confirmarSenha.addEventListener("input", validarSenhas);

        toggleSenha.addEventListener("click", function () {
            const mostrar = senha.type === "password";

            senha.type = mostrar ? "text" : "password";
            confirmarSenha.type = mostrar ? "text" : "password";
            toggleSenha.textContent = mostrar ? "Ocultar" : "Mostrar";
            toggleSenha.setAttribute("aria-pressed", String(mostrar));
        });

        formCadastro.addEventListener("submit", function (event) {
            validarSenhas();

            if (!formCadastro.checkValidity()) {
                event.preventDefault();
                formCadastro.reportValidity();
            }
        });
    </script>

</t:layout>