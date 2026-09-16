<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<t:layout titulo="Bem-vindo ao Lumina">

    

    <header class="sticky top-0 z-50 bg-white/95 backdrop-blur-md
                border-b border-gray-100">

        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

            <div class="flex items-center justify-between h-20">

                <%-- Logo --%>
                <a href="${pageContext.request.contextPath}/"
                class="flex items-center gap-3 shrink-0 group">

                    <img
                        src="${pageContext.request.contextPath}/images/logo.png"
                        alt="Logo Lumina"
                        class="w-11 h-11 rounded-xl object-contain
                            bg-white p-1
                            group-hover:scale-105
                            transition-transform">

                    <div>
                        <span class="block text-2xl font-bold
                                    tracking-tight text-principal">
                            Lumina
                        </span>

                        <span class="block text-[10px] text-gray-400
                                    -mt-1 tracking-wide">
                            Sua próxima leitura
                        </span>
                    </div>

                </a>


                <%-- Navegação --%>
                <nav aria-label="Navegação principal"
                    class="hidden md:flex items-center gap-8">

                    <a href="${pageContext.request.contextPath}/#inicio"
                    class="text-sm font-medium text-gray-600
                            hover:text-principal transition-colors">
                        Início
                    </a>

                    <a href="${pageContext.request.contextPath}/#funcionalidades"
                    class="text-sm font-medium text-gray-600
                            hover:text-principal transition-colors">
                        Funcionalidades
                    </a>

                    <a href="${pageContext.request.contextPath}/#sobre"
                    class="text-sm font-medium text-gray-600
                            hover:text-principal transition-colors">
                        Sobre
                    </a>

                </nav>


                <%-- Acesso --%>
                <div class="flex items-center gap-3">

                    <a
                        href="${pageContext.request.contextPath}/login"
                        class="inline-flex items-center justify-center
                            gap-2 bg-principal text-white
                            font-semibold text-sm
                            px-5 py-3 rounded-xl
                            hover:bg-principal-hover
                            hover:-translate-y-0.5
                            shadow-md shadow-principal/15
                            transition-all duration-200">

                        Entrar

                        <svg xmlns="http://www.w3.org/2000/svg"
                            width="17" height="17"
                            viewBox="0 0 24 24"
                            fill="none" stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round">

                            <path d="M5 12h14"/>
                            <path d="m12 5 7 7-7 7"/>

                        </svg>

                    </a>

                </div>

            </div>

        </div>

    </header>

    <main class="bg-gray-50/70 text-gray-900">

        <%-- Hero --%>
        <section class="relative overflow-hidden">

            <div class="absolute top-0 right-0 w-96 h-96
                        rounded-full bg-principal/5
                        translate-x-1/3 -translate-y-1/3
                        pointer-events-none">
            </div>

            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8
                        py-16 md:py-24 lg:py-28">

                <div class="grid grid-cols-1 lg:grid-cols-2
                            items-center gap-12 lg:gap-16">

                    <%-- Apresentação --%>
                    <div class="relative z-10 text-center lg:text-left">

                        <div class="inline-flex items-center gap-2
                                    bg-principal/10 text-principal
                                    rounded-full px-4 py-2
                                    text-xs sm:text-sm font-semibold
                                    mb-6">

                            <span class="w-2 h-2 rounded-full bg-principal"></span>

                            Sua biblioteca de novas descobertas

                        </div>

                        <h1 class="text-4xl sm:text-5xl lg:text-6xl
                                   font-extrabold tracking-tight
                                   leading-tight">

                            Descubra sua próxima
                            <span class="text-principal">
                                grande história.
                            </span>

                        </h1>

                        <p class="text-base sm:text-lg text-gray-500
                                  leading-relaxed mt-6 max-w-xl mx-auto
                                  lg:mx-0">

                            Encontre livros que combinam com você.
                            Explore diferentes gêneros, conheça novas histórias
                            e transforme sua próxima leitura em uma experiência única.

                        </p>

                        <div class="flex flex-col sm:flex-row
                                    gap-3 mt-8 justify-center lg:justify-start">

                            <a
                                href="${pageContext.request.contextPath}/login"
                                class="inline-flex items-center justify-center
                                       gap-3 bg-principal text-white
                                       font-semibold px-7 py-4 rounded-xl
                                       shadow-lg shadow-principal/20
                                       hover:bg-principal-hover
                                       hover:-translate-y-0.5
                                       transition-all duration-200">

                                Começar a explorar

                                <svg xmlns="http://www.w3.org/2000/svg"
                                     width="19" height="19"
                                     viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor"
                                     stroke-width="2"
                                     stroke-linecap="round"
                                     stroke-linejoin="round">

                                    <path d="M5 12h14"/>
                                    <path d="m12 5 7 7-7 7"/>

                                </svg>

                            </a>

                        </div>

                        <div class="flex flex-wrap items-center
                                    justify-center lg:justify-start
                                    gap-x-6 gap-y-3 mt-8
                                    text-sm text-gray-500">

                            <span class="flex items-center gap-2">
                                <svg xmlns="http://www.w3.org/2000/svg"
                                     width="17" height="17"
                                     viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor"
                                     stroke-width="2"
                                     stroke-linecap="round"
                                     stroke-linejoin="round"
                                     class="text-principal">

                                    <path d="m9 12 2 2 4-4"/>
                                    <circle cx="12" cy="12" r="10"/>

                                </svg>

                                Descobertas personalizadas
                            </span>

                            <span class="flex items-center gap-2">
                                <svg xmlns="http://www.w3.org/2000/svg"
                                     width="17" height="17"
                                     viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor"
                                     stroke-width="2"
                                     stroke-linecap="round"
                                     stroke-linejoin="round"
                                     class="text-principal">

                                    <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/>
                                    <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2Z"/>

                                </svg>

                                Uma biblioteca para você
                            </span>

                        </div>

                    </div>


                    <%-- Composição visual --%>
                    <div class="relative flex items-center justify-center
                                min-h-[320px] sm:min-h-[400px]">

                        <div class="absolute w-64 h-64 sm:w-80 sm:h-80
                                    rounded-full bg-principal/10">
                        </div>

                        <div class="absolute w-48 h-48 sm:w-64 sm:h-64
                                    rounded-full border border-principal/15">
                        </div>

                        <div class="relative w-full max-w-md">

                            <div class="absolute -top-5 right-3 sm:right-8
                                        z-20 bg-white border border-gray-100
                                        rounded-2xl shadow-lg p-4
                                        flex items-center gap-3">

                                <div class="w-10 h-10 rounded-xl
                                            bg-principal/10
                                            flex items-center justify-center
                                            text-principal">

                                    <svg xmlns="http://www.w3.org/2000/svg"
                                         width="22" height="22"
                                         viewBox="0 0 24 24"
                                         fill="none" stroke="currentColor"
                                         stroke-width="1.8"
                                         stroke-linecap="round"
                                         stroke-linejoin="round">

                                        <path d="M12 8v8"/>
                                        <path d="M8 12h8"/>
                                        <circle cx="12" cy="12" r="10"/>

                                    </svg>

                                </div>

                                <div>
                                    <p class="text-xs text-gray-400">
                                        Novas descobertas
                                    </p>

                                    <p class="text-sm font-bold text-gray-800">
                                        Sua próxima leitura
                                    </p>
                                </div>

                            </div>


                            <%-- Livros ilustrativos --%>
                            <div class="relative flex items-center
                                        justify-center gap-2 sm:gap-3
                                        pt-8 pb-6">

                                <div class="w-24 sm:w-32 h-48 sm:h-60
                                            rounded-lg bg-[#7765A8]
                                            shadow-xl -rotate-12
                                            flex flex-col justify-between
                                            p-3 sm:p-4 text-white">

                                    <div class="border border-white/30
                                                rounded p-2 h-full
                                                flex flex-col justify-center
                                                items-center text-center">

                                        <svg xmlns="http://www.w3.org/2000/svg"
                                             width="34" height="34"
                                             viewBox="0 0 24 24"
                                             fill="none" stroke="currentColor"
                                             stroke-width="1.2"
                                             stroke-linecap="round"
                                             stroke-linejoin="round">

                                            <path d="M12 3v18"/>
                                            <path d="M5 7c3-3 11-3 14 0"/>
                                            <path d="M5 17c3 3 11 3 14 0"/>

                                        </svg>

                                        <span class="text-[10px] sm:text-xs
                                                     font-bold mt-3">
                                            IMAGINAÇÃO
                                        </span>

                                    </div>

                                </div>


                                <div class="w-28 sm:w-36 h-56 sm:h-72
                                            rounded-lg bg-[#D8C9F2]
                                            shadow-2xl z-10
                                            flex flex-col justify-between
                                            p-3 sm:p-4 text-[#59457E]">

                                    <div class="text-[9px] sm:text-xs
                                                uppercase tracking-widest
                                                font-semibold">
                                        Lumina
                                    </div>

                                    <div class="text-center">

                                        <svg xmlns="http://www.w3.org/2000/svg"
                                             width="56" height="56"
                                             viewBox="0 0 24 24"
                                             fill="none" stroke="currentColor"
                                             stroke-width="1"
                                             stroke-linecap="round"
                                             stroke-linejoin="round"
                                             class="mx-auto">

                                            <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/>
                                            <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2Z"/>

                                        </svg>

                                        <p class="font-bold text-lg
                                                  sm:text-xl mt-3">
                                            Novos
                                            <br>
                                            mundos
                                        </p>

                                        <div class="w-8 h-0.5
                                                    bg-[#59457E]/40
                                                    mx-auto mt-3">
                                        </div>

                                    </div>

                                    <p class="text-[9px] sm:text-xs
                                              text-center uppercase
                                              tracking-widest">
                                        Uma história por vez
                                    </p>

                                </div>


                                <div class="w-24 sm:w-32 h-48 sm:h-60
                                            rounded-lg bg-[#8C9BBD]
                                            shadow-xl rotate-12
                                            flex flex-col justify-between
                                            p-3 sm:p-4 text-white">

                                    <div class="border border-white/30
                                                rounded p-2 h-full
                                                flex flex-col justify-center
                                                items-center text-center">

                                        <svg xmlns="http://www.w3.org/2000/svg"
                                             width="34" height="34"
                                             viewBox="0 0 24 24"
                                             fill="none" stroke="currentColor"
                                             stroke-width="1.2"
                                             stroke-linecap="round"
                                             stroke-linejoin="round">

                                            <path d="M12 2 15 9l7 3-7 3-3 7-3-7-7-3 7-3 3-7Z"/>

                                        </svg>

                                        <span class="text-[10px] sm:text-xs
                                                     font-bold mt-3">
                                            DESCOBERTA
                                        </span>

                                    </div>

                                </div>

                            </div>


                            <div class="absolute -bottom-3 left-0 sm:left-4
                                        z-20 bg-white border border-gray-100
                                        rounded-2xl shadow-lg p-3 sm:p-4
                                        flex items-center gap-3">

                                <div class="flex -space-x-2">

                                    <div class="w-8 h-8 rounded-full
                                                bg-[#D8C9F2] border-2 border-white">
                                    </div>

                                    <div class="w-8 h-8 rounded-full
                                                bg-[#8C9BBD] border-2 border-white">
                                    </div>

                                    <div class="w-8 h-8 rounded-full
                                                bg-[#7765A8] border-2 border-white">
                                    </div>

                                </div>

                                <p class="text-xs sm:text-sm font-semibold
                                          text-gray-700">
                                    Histórias para descobrir
                                </p>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </section>


        <%-- Funcionalidades --%>
        <section class="bg-white border-y border-gray-100">

            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8
                        py-16 md:py-20">

                <div class="text-center max-w-2xl mx-auto mb-10 md:mb-14">

                    <span class="text-xs font-bold text-principal
                                 uppercase tracking-widest">
                        O universo Lumina
                    </span>

                    <h2 class="text-2xl sm:text-3xl font-bold
                               text-gray-900 mt-3">
                        Encontre sua próxima leitura
                    </h2>

                    <p class="text-gray-500 mt-4 leading-relaxed">
                        Tudo o que você precisa para explorar o mundo
                        dos livros em um só lugar.
                    </p>

                </div>


                <div class="grid grid-cols-1 md:grid-cols-3 gap-5 md:gap-6">


                    <%-- Catálogo --%>
                    <article class="group rounded-2xl border border-gray-100
                                    bg-gray-50/50 p-6 sm:p-8
                                    hover:bg-white hover:border-principal/20
                                    hover:shadow-lg transition-all duration-300">

                        <div class="w-14 h-14 rounded-2xl
                                    bg-principal/10 text-principal
                                    flex items-center justify-center
                                    mb-6 group-hover:scale-105
                                    transition-transform">

                            <svg xmlns="http://www.w3.org/2000/svg"
                                 width="28" height="28"
                                 viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor"
                                 stroke-width="1.7"
                                 stroke-linecap="round"
                                 stroke-linejoin="round">

                                <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/>
                                <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2Z"/>

                            </svg>

                        </div>

                        <h3 class="text-lg font-bold text-gray-900">
                            Explore o catálogo
                        </h3>

                        <p class="text-sm text-gray-500 mt-3
                                  leading-relaxed">
                            Navegue por livros de diferentes autores,
                            conheça novas obras e encontre histórias
                            que despertem sua curiosidade.
                        </p>

                    </article>


                    <%-- Gêneros --%>
                    <article class="group rounded-2xl border border-gray-100
                                    bg-gray-50/50 p-6 sm:p-8
                                    hover:bg-white hover:border-principal/20
                                    hover:shadow-lg transition-all duration-300">

                        <div class="w-14 h-14 rounded-2xl
                                    bg-principal/10 text-principal
                                    flex items-center justify-center
                                    mb-6 group-hover:scale-105
                                    transition-transform">

                            <svg xmlns="http://www.w3.org/2000/svg"
                                 width="28" height="28"
                                 viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor"
                                 stroke-width="1.7"
                                 stroke-linecap="round"
                                 stroke-linejoin="round">

                                <path d="M12 20h9"/>
                                <path d="M16.5 3.5a2.12 2.12 0 0 1 3 3L8 18l-4 1 1-4Z"/>
                                <path d="m15 5 4 4"/>

                            </svg>

                        </div>

                        <h3 class="text-lg font-bold text-gray-900">
                            Escolha seus gêneros
                        </h3>

                        <p class="text-sm text-gray-500 mt-3
                                  leading-relaxed">
                            Selecione os estilos literários que mais
                            combinam com você e personalize sua
                            experiência de leitura.
                        </p>

                    </article>


                    <%-- Recomendações --%>
                    <article class="group rounded-2xl border border-gray-100
                                    bg-gray-50/50 p-6 sm:p-8
                                    hover:bg-white hover:border-principal/20
                                    hover:shadow-lg transition-all duration-300">

                        <div class="w-14 h-14 rounded-2xl
                                    bg-principal/10 text-principal
                                    flex items-center justify-center
                                    mb-6 group-hover:scale-105
                                    transition-transform">

                            <svg xmlns="http://www.w3.org/2000/svg"
                                 width="28" height="28"
                                 viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor"
                                 stroke-width="1.7"
                                 stroke-linecap="round"
                                 stroke-linejoin="round">

                                <path d="M12 3v2"/>
                                <path d="M12 19v2"/>
                                <path d="m4.93 4.93 1.42 1.42"/>
                                <path d="m17.65 17.65 1.42 1.42"/>
                                <path d="M3 12h2"/>
                                <path d="M19 12h2"/>
                                <path d="m4.93 19.07 1.42-1.42"/>
                                <path d="m17.65 6.35 1.42-1.42"/>
                                <circle cx="12" cy="12" r="4"/>

                            </svg>

                        </div>

                        <h3 class="text-lg font-bold text-gray-900">
                            Receba recomendações
                        </h3>

                        <p class="text-sm text-gray-500 mt-3
                                  leading-relaxed">
                            Descubra sugestões de livros de acordo
                            com seus gêneros favoritos e encontre
                            novas possibilidades de leitura.
                        </p>

                    </article>

                </div>

            </div>

        </section>


        <%-- Chamada final --%>
        <section class="px-4 sm:px-6 lg:px-8 py-16 md:py-20">

            <div class="max-w-7xl mx-auto relative overflow-hidden
                        rounded-3xl bg-principal
                        px-6 py-12 sm:px-12 sm:py-14
                        text-center text-white">

                <div class="absolute top-0 right-0
                            w-56 h-56 rounded-full bg-white/5
                            -translate-y-1/2 translate-x-1/3">
                </div>

                <div class="absolute bottom-0 left-0
                            w-40 h-40 rounded-full bg-white/5
                            translate-y-1/2 -translate-x-1/3">
                </div>

                <div class="relative z-10 max-w-2xl mx-auto">

                    <h2 class="text-2xl sm:text-3xl
                               font-bold tracking-tight">
                        Uma nova história espera por você.
                    </h2>

                    <p class="text-sm sm:text-base text-white/80
                              mt-4 leading-relaxed">
                        Entre no Lumina e comece a descobrir
                        livros que combinam com seus interesses.
                    </p>

                    <a
                        href="${pageContext.request.contextPath}/login"
                        class="inline-flex items-center justify-center
                               gap-3 mt-8 px-7 py-3.5
                               rounded-xl bg-white text-principal
                               font-semibold text-sm
                               hover:bg-white/90
                               transition-colors">

                        Acessar o Lumina

                        <svg xmlns="http://www.w3.org/2000/svg"
                             width="18" height="18"
                             viewBox="0 0 24 24"
                             fill="none" stroke="currentColor"
                             stroke-width="2"
                             stroke-linecap="round"
                             stroke-linejoin="round">

                            <path d="M5 12h14"/>
                            <path d="m12 5 7 7-7 7"/>

                        </svg>

                    </a>

                </div>

            </div>

        </section>

    </main>

</t:layout>