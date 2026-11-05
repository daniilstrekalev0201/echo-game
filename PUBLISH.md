# Как выложить «ЭХО» на itch.io

Всё для загрузки лежит в папке `release/` (её создаёт `tools/build-release.sh`):

| Файл | Что это |
|---|---|
| `release/echo-web.zip` | игра целиком: index.html, движок three.js и шрифты внутри, интернет не нужен |
| `release/promo/cover-630x500.jpg` | обложка (Cover image) |
| `release/promo/shot-1-water.jpg` … `shot-4-core.jpg` | скриншоты 1280×720 |

Пересобрать архив после изменений в игре: `bash tools/build-release.sh`.

> Админ-режим: 5 нажатий на заголовок «Уровни» и код (код хранится в игре только в виде хеша).

## Шаги

1. Зарегистрируйся на https://itch.io и открой **Dashboard → Create new project**.
2. Заполни поля:
   - **Title:** `ЭХО — тихий побег` (или просто `ЭХО`)
   - **Project URL:** например `echo-quiet-escape`
   - **Short description or tagline:** текст «Коротко» ниже
   - **Classification:** Games · **Kind of project:** HTML
   - **Release status:** Released (или In development, если хочешь собирать отзывы)
   - **Pricing:** No payments или Donate (донат по желанию)
3. **Uploads:** загрузи `release/echo-web.zip` и поставь галочку **This file will be played in the browser**.
4. **Embed options:**
   - Viewport dimensions: **1280 × 720**
   - ✓ **Mobile friendly**, Orientation: **Default** (игра работает и вертикально, и горизонтально)
   - ✓ **Fullscreen button**
   - ✗ Automatically start on page load (звук всё равно включается только после клика)
   - ✗ Enable scrollbars
5. **Details:**
   - **Description:** текст «Описание» ниже (можно русский и английский вместе)
   - **Genre:** Action
   - **Tags:** `stealth`, `3d`, `isometric`, `maze`, `robots`, `singleplayer`, `minimalist`, `browser`, `mobile`, `cute`
   - **App store links / community:** по желанию; включи комментарии — это отзывы игроков
6. **Cover image:** `release/promo/cover-630x500.jpg`. **Screenshots:** четыре файла `shot-*.jpg`.
7. **Visibility & access:** сначала **Draft** → открой страницу, сыграй сам на компьютере и телефоне → переключи на **Public**.

Прогресс и настройки игроков сохраняются в их браузере (localStorage домена itch.io), отдельно от версии на GitHub Pages.

---

## Тексты для страницы

### Коротко (tagline)
RU: Стелс-побег от невидимых Охотников, которые слышат каждый твой шаг.
EN: A stealth escape from invisible hunters who hear every step you take.

### Описание (RU)
**ЭХО** — изометрическая стелс-игра в игрушечном лабиринте.

Ты — маленький робот ЭХО-01. Собери энергоячейки и выберись наружу. Но в лабиринте ходят Охотники: они невидимы и слепы, зато слышат всё.

**Одно правило: каждый звук — это круг на полу.** Шаги, сонар, звон ячейки, даже стук твоего сердца. Если круг коснулся Охотника — он идёт туда.

- **Сонар** показывает невидимых Охотников — но и выдаёт тебя
- **Приманки** уводят Охотников в другую сторону
- **Водомёты**: вода замыкает робота-Охотника на несколько секунд
- **Шкафы**, где можно затаиться, и **двери**, которые Охотнику приходится выламывать
- **Блэкаут**: свет гаснет, и стены видно только в свете сонара
- **Страх слышен**: когда Охотник рядом, сердце бьётся громче — присядь и успокойся
- 10 уровней, 3 звезды на каждом, 8 раскрасок робота
- Играется в браузере на компьютере и телефоне
- Русский и английский язык, переключаются в меню

**Управление (компьютер):** WASD — идти, Shift — бег, C — присесть, ЛКМ/Пробел — сонар, ПКМ/F — приманка, R — водомёт, Q/E — повернуть камеру, Esc — пауза. Любую клавишу можно переназначить в настройках.
**Телефон:** стик ходьбы и кнопка «Присесть» слева, карточки «Сонар», «Приманка» и «Водомёт» справа.

### Description (EN)
**ECHO** is an isometric stealth game set in a toy-like maze.

You are ECHO-01, a small robot. Collect the energy cells and get out. But the maze is patrolled by Hunters — invisible and blind, yet they hear everything.

**One rule: every sound is a ring on the floor.** Footsteps, sonar, a picked-up cell, even your own heartbeat. If a ring touches a Hunter, it comes for the source.

- **Sonar** reveals invisible Hunters — and gives you away
- **Decoys** lure Hunters elsewhere
- **Water pistols** short-circuit a robot Hunter for a few seconds
- **Lockers** to hide in and **doors** Hunters have to break through
- **Blackouts**: the lights go out and only your sonar shows the walls
- **Fear is loud**: when a Hunter is near, your heart pounds — crouch and calm down
- 10 levels, 3 stars each, 8 robot skins
- Plays in the browser on desktop and mobile
- English and Russian, switchable in the menu

The game is available in English and Russian (switch in the main menu or in Settings).

**Controls (desktop):** WASD move, Shift run, C crouch, LMB/Space sonar, RMB/F decoy, R water pistol, Q/E rotate camera, Esc pause. All keys can be rebound in Settings.
**Mobile:** movement stick and Crouch button on the left, Sonar / Decoy / Water cards on the right.

### Благодарности / Credits
three.js (MIT License) · шрифт Barlow (SIL Open Font License 1.1). Модели, звуки и музыка созданы в коде игры.
