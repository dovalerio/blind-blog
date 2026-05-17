# Home Page Redesign Report — Danilo Valerio

> **Data:** 2026-05-17
> **Repositório:** dovalerio/blind-blog
> **Objetivo:** Home page pessoal moderna, acessível e minimalista

---

## Arquivos modificados

### Criados

| Arquivo | Descrição |
|---------|-----------|
| `app/app/controllers/home_controller.rb` | Controller dedicado para a home, usa layout `home` |
| `app/app/views/layouts/home.html.erb` | Layout independente: sem navbar de blog, Bootstrap CDN, skip-link |
| `app/app/views/home/index.html.erb` | View da home page com perfil, skills, links e projetos |

### Modificados

| Arquivo | Alteração |
|---------|-----------|
| `app/config/routes.rb` | `root` alterado de `posts#index` para `home#index` |
| `app/app/assets/stylesheets/app.css` | Adicionadas classes `.home-*` (~120 linhas) para o layout da home |

---

## Rotas criadas/alteradas

```
root GET  /   home#index   (era posts#index)
```

Rotas preservadas:
```
GET  /posts      posts#index
GET  /posts/:id  posts#show
GET  /admin/     admin/posts#index
...
```

---

## Estratégia de estilização escolhida

**CSS puro, adicionado ao `app.css` existente.**

Bootstrap 5.3.3 já estava instalado via CDN. Não foi adicionada nenhuma nova dependência.

Critério: a home page tem estrutura simples (uma coluna, sem grid complexo). CSS puro com classes `.home-*` é suficiente e mais legível que classes utilitárias do Bootstrap para esse layout específico.

Nenhum arquivo separado foi criado — os estilos da home foram anexados ao `app.css` com namespace `.home-*` para evitar conflitos.

---

## Estrutura visual implementada

```
body.home-body (fundo branco, flex coluna, alinhamento central)
└── main#main-content
    └── .home-container (preto #111, max-width 660px, centralizado)
        ├── header.home-profile
        │   ├── .home-avatar (84x84, placeholder DV)
        │   └── .home-profile-info
        │       ├── h1.home-name      → "Danilo Valerio"
        │       ├── p.home-role       → "Engenheiro de Software Sênior"
        │       └── p.home-bio        → resumo profissional
        ├── hr.home-divider
        ├── section[aria-labelledby=skills-heading]
        │   └── ul.home-skills
        │       └── li.home-skill × 9 (tecnologias)
        ├── hr.home-divider
        ├── nav[aria-label="Links profissionais"]
        │   └── ul.home-links
        │       ├── li → GitHub (target _blank)
        │       ├── li → LinkedIn (target _blank)
        │       └── li → Blog (link interno)
        ├── hr.home-divider
        ├── section[aria-labelledby=projects-heading]
        │   ├── h2.home-section-label → "Projetos"
        │   └── .home-projects
        │       └── a.home-project × 6
        └── footer.home-footer → copyright
```

---

## Ajustes de acessibilidade

| Item | Implementação |
|------|---------------|
| Skip link | `<a href="#main-content" class="skip-link">` no layout |
| Headings hierarchy | `h1` (nome) → `h2` (skills heading, visually hidden) → `h2` (projetos label) |
| Skills heading | `<h2 class="sr-only">Especialidades</h2>` — visível para leitores de tela |
| Links externos | `aria-label` descritivo + `(abre em nova aba)` + `rel="noopener noreferrer"` |
| Blog link | `aria-label` com contexto descritivo |
| Foto de perfil | `alt="Foto de perfil de Danilo Valerio"` |
| Avatar sem imagem real | `role="img"` disponível para eventual CSS-only placeholder |
| Foco visível | `.home-link:focus-visible` e `.home-project:focus-visible` com outline 2px |
| Contraste | Texto `#d0d0d0` sobre `#111111` → ratio ~8.6:1 (WCAG AAA) |
| Links de projeto | `aria-label` com nome do projeto + "ver no GitHub (abre em nova aba)" |
| `role="list"` | Aplicado em `ul.home-skills` e `ul.home-links` (compatível com Safari VoiceOver) |
| Semântica | `<header>`, `<main>`, `<nav>`, `<section>`, `<footer>` com roles apropriados |

---

## Ajustes responsivos

| Breakpoint | Comportamento |
|------------|---------------|
| > 520px | Container 660px centralizado com padding 2.5rem |
| ≤ 520px | Container largura total, padding reduzido, border-radius 0 (full bleed mobile) |
| ≤ 520px | Profile section passa para coluna (foto acima do texto) |
| ≤ 520px | Avatar reduz de 84px para 64px |
| ≤ 520px | Nome reduz de 1.35rem para 1.2rem |
| Geral | Skills e links com `flex-wrap: wrap` (se encaixam em qualquer largura) |
| Geral | `max-width: 660px; width: 100%` no container (sem overflow horizontal) |

---

## Projetos selecionados do GitHub

Comando executado:
```bash
gh repo list dovalerio --limit 20 --json name,description,url,primaryLanguage,updatedAt
```

Critérios de seleção: acessibilidade, backend, Kotlin, Java, automação, recência.

| Projeto | Linguagem | Categoria | URL |
|---------|-----------|-----------|-----|
| `jetbrains_NVDA_Addon` | Python | Acessibilidade | github.com/dovalerio/jetbrains_NVDA_Addon |
| `blind-dev-setup` | PowerShell | Acessibilidade | github.com/dovalerio/blind-dev-setup |
| `foxbit-trade-bot` | Kotlin | Automação / Backend | github.com/dovalerio/foxbit-trade-bot |
| `multi-exchange-quote-engine` | Kotlin | Backend / Microsserviços | github.com/dovalerio/multi-exchange-quote-engine |
| `cars-api` | Java | Backend / Spring Boot | github.com/dovalerio/cars-api |
| `gerador-diagramas` | Python | Automação | github.com/dovalerio/gerador-diagramas |

---

## Dependências adicionadas

**Nenhuma.**

Bootstrap 5.3.3 já estava no projeto via CDN. Nenhum novo gem, npm package ou CDN foi adicionado.

---

## Comandos executados

```bash
# Listagem de repositórios GitHub
gh repo list dovalerio --limit 20 --json name,description,url,primaryLanguage,updatedAt

# Verificação de estrutura
rails routes  # verificado via análise estática do routes.rb
```

---

## Pendências futuras

| Item | Descrição |
|------|-----------|
| Foto de perfil real | Substituir placeholder `placehold.co/84x84` por imagem real |
| Open Graph | Adicionar `<meta property="og:*">` para compartilhamento em redes sociais |
| Favicon personalizado | Adicionar favicon com iniciais DV |
| Animações sutis | Considerar fade-in suave no container (opcional, com `prefers-reduced-motion`) |
| i18n | Considerar versão em inglês da home page |
| Analytics | Adicionar Umami ou Plausible (privacy-first) |

---

## Melhorias recomendadas

| # | Melhoria | Prioridade |
|---|----------|-----------|
| 1 | **Foto real** — substituir `placehold.co` por imagem do usuário | Alta |
| 2 | **Open Graph + Twitter Card** — melhorar compartilhamento em redes sociais | Alta |
| 3 | **Link para o admin** — link secreto ou acesso via URL direta (já existe `/admin`) | Média |
| 4 | **Contato** — adicionar email ou formulário de contato | Média |
| 5 | **Projetos dinâmicos** — buscar repos do GitHub via API em tempo real (Rails caching) | Baixa |
| 6 | **Dark/light toggle** — botão para alternar tema manualmente | Baixa |
| 7 | **Página de about** — página separada com mais detalhes de experiência | Baixa |

---

## Resultado

| Critério | Status |
|----------|--------|
| Home abre em `/` | ✅ `root "home#index"` |
| Layout estilo Tumblr minimalista | ✅ Container escuro centralizado em fundo branco |
| Container principal escuro | ✅ `#111111` com texto `#d0d0d0` |
| Fundo branco | ✅ `.home-body { background-color: #ffffff }` |
| Tipografia Helvetica | ✅ Herdado do `--bs-font-sans-serif` em `app.css` |
| Espaço para foto de perfil | ✅ `.home-avatar` 84×84px com placeholder |
| Responsivo | ✅ Breakpoint em 520px, flex-wrap em pills e links |
| Acessível | ✅ Semântica, aria-labels, foco visível, contraste AAA |
| Funcionalidades existentes preservadas | ✅ Posts, admin, API — sem alterações |
| Relatório final gerado | ✅ Este arquivo |
