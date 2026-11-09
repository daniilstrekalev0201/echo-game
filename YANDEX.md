# Как выложить «ЭХО» на Яндекс Игры

## Что уже готово

| Файл | Что это |
|---|---|
| `release/echo-yandex.zip` | игра для Яндекса: SDK подключён, всё лежит внутри архива |
| `release/promo-yandex/icon-512.png` | иконка 512×512 |
| `release/promo-yandex/cover-800x470.jpg` | обложка 800×470 |
| `release/promo-yandex/desktop-*.jpg` | 4 скриншота для компьютера, 1920×1080 |
| `release/promo-yandex/mobile-*.jpg` | 2 скриншота для телефона, 1080×1920 |

Пересобрать архив после изменений: `bash tools/build-release.sh yandex`.

**Что встроено в версию для Яндекса** (в обычной версии этого нет):
- SDK Яндекс Игр: игра сообщает о готовности (LoadingAPI.ready) и о начале/паузе игры (GameplayAPI);
- язык берётся у Яндекса, если игрок сам его не выбирал (ru, be, kk, uk, uz → русский, остальные → английский);
- прогресс уровней и выбранная раскраска сохраняются в облаке Яндекса;
- реклама: полноэкранная — при переходе между уровнями (частоту ограничивает сам Яндекс);
  за вознаграждение — кнопка «Ещё шанс (реклама)» после поимки, один раз за уровень;
- на время рекламы звук выключается; при сворачивании вкладки звук и игра тоже останавливаются;
- нет кнопки «На весь экран» (это делает площадка) и нет входа в админ-режим.

## Шаги в консоли

1. Открой https://games.yandex.ru/console/ и войди с Яндекс ID. Прими соглашение разработчика.
2. **Добавить приложение** → загрузи `release/echo-yandex.zip` в раздел архива с игрой.
3. Включи рекламу (полноэкранную и rewarded) в настройках монетизации, если хочешь зарабатывать.
   Для выплат Яндекс попросит данные получателя — следуй подсказкам консоли.
4. Заполни карточку игры текстами ниже, загрузи иконку, обложку и скриншоты.
5. Проверь игру **во встроенном просмотре консоли** (черновик): запуск, реклама, сохранение после перезагрузки.
6. **Отправь на модерацию.** Обычно это несколько дней; если будут замечания, Яндекс пришлёт список.

Актуальные требования площадки: https://yandex.ru/dev/games/doc/ru/concepts/requirements —
если что-то в этом файле с ними расходится, ориентируйся на консоль.

---

## Тексты для карточки

**Название:** ЭХО: Тихий побег (EN: ECHO: Quiet Escape) — точно как логотип в игре (правило 5.1.3)

**Возрастной рейтинг:** 6+ (нет насилия и крови: робота «ловят», и уровень начинается заново)

**Категории:** Экшен, Головоломки (или «Приключения»)
**Теги:** стелс, лабиринт, роботы, 3D, изометрия, прятки

### Краткое описание
RU: Стелс-побег от невидимых Охотников, которые слышат каждый твой шаг.
EN: A stealth escape from invisible hunters who hear every step you take.

### Описание (RU)
ЭХО — изометрическая стелс-игра в игрушечном лабиринте.

Ты — маленький робот ЭХО-01. Собери энергоячейки и выберись наружу. Но в лабиринте ходят Охотники: они невидимы и слепы, зато слышат всё.

Одно правило: каждый звук — это круг на полу. Шаги, сонар, звон ячейки, даже стук твоего сердца. Если круг коснулся Охотника — он идёт туда.

• Сонар показывает невидимых Охотников — но и выдаёт тебя
• Приманки уводят Охотников в другую сторону
• Водомёты: вода замыкает робота-Охотника на несколько секунд
• Шкафы, где можно затаиться, и двери, которые Охотнику приходится выламывать
• Блэкаут: свет гаснет, и стены видно только в свете сонара
• Страх слышен: когда Охотник рядом, сердце бьётся громче — присядь и успокойся
• 10 уровней, 3 звезды на каждом, 8 раскрасок робота

### Description (EN)
ECHO is an isometric stealth game set in a toy-like maze.

You are ECHO-01, a small robot. Collect the energy cells and get out. But the maze is patrolled by Hunters — invisible and blind, yet they hear everything.

One rule: every sound is a ring on the floor. Footsteps, sonar, a picked-up cell, even your own heartbeat. If a ring touches a Hunter, it comes for the source.

• Sonar reveals invisible Hunters — and gives you away
• Decoys lure Hunters elsewhere
• Water guns short-circuit a robot Hunter for a few seconds
• Lockers to hide in and doors Hunters have to break through
• Blackouts: the lights go out and only your sonar shows the walls
• Fear is loud: when a Hunter is near, your heart pounds — crouch and calm down
• 10 levels, 3 stars each, 8 robot skins

### Как играть (RU)
Компьютер: WASD — идти, Shift — бег, C — присесть (у шкафа — спрятаться), ЛКМ или Пробел — сонар (удерживай для заряда), ПКМ или F — приманка, R — водомёт, Q/E — повернуть камеру, Esc — пауза. Клавиши можно поменять в настройках.
Телефон: стик слева — идти (до края — бег), рядом кнопка «Присесть»; карточки «Сонар», «Приманка» и «Водомёт» справа.
Собери все энергоячейки — откроется выход.

### How to play (EN)
Desktop: WASD move, Shift run, C crouch (next to a locker — hide), LMB or Space sonar (hold to charge), RMB or F decoy, R water gun, Q/E rotate camera, Esc pause. Keys can be changed in Settings.
Mobile: stick on the left to walk (to the edge to run), Crouch button next to it; Sonar, Decoy and Water cards on the right.
Collect all energy cells to open the exit.
