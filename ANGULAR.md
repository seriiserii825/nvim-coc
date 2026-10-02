# Angular: автодополнение в шаблонах (.html) через coc-angular

Чек-лист, что должно быть выполнено, чтобы в `.html`-шаблоне Angular-компонента работало автодополнение из TS (`product().` → поля модели). Подробный разбор причин — в `CLAUDE.md`, секция «coc-angular: template completion silently fails…».

## 1. Глобально (один раз на машину, повторять после `:CocUpdate coc-angular`)

coc-angular (`17.0.2`) тащит устаревший `@angular/language-server`, который не распознаёт Angular 18+ (`@angular/core/types/core.d.ts`). Обновить его внутри расширения:

```bash
cd ~/.config/coc/extensions/node_modules/coc-angular/node_modules
npm install @angular/language-server@latest --legacy-peer-deps
```

Проверка:
```bash
grep -m1 '"version"' ~/.config/coc/extensions/node_modules/coc-angular/node_modules/@angular/language-server/package.json
# должно быть >= мажорной версии @angular/core проекта, не 17.x
```

`:CocUpdate` откатывает этот патч — после обновления расширений проверить снова.

## 2. В каждом Angular-проекте

Встроенный в coc-angular TypeScript `5.2.2` не умеет парсить `"module": "preserve"` (Angular CLI ставит это по умолчанию) и не знает TS 6+. Нужно направить его на TypeScript проекта — файл `<проект>/.vim/coc-settings.json`:

```json
{
  "typescript.tsdk": "/абсолютный/путь/к/<проект>/node_modules/typescript/lib"
}
```

- Путь **только абсолютный** — относительный не резолвится надёжно.
- Быстро создать из корня проекта:
  ```bash
  mkdir -p .vim && printf '{\n  "typescript.tsdk": "%s/node_modules/typescript/lib"\n}\n' "$PWD" > .vim/coc-settings.json
  ```
- Добавить `.vim/` в `.gitignore` проекта (путь машинно-зависимый).
- В проекте должен быть выполнен `npm install` (нужны `node_modules/typescript` и `node_modules/@angular/core`).

Не класть `typescript.tsdk` в глобальный `coc-settings.json` этого репо — он проектно-специфичный.

## 3. Проверка

1. `:CocRestart`, переоткрыть `.html`-шаблон.
2. `:CocCommand workspace.showOutput` → `Angular Language Service`:
   - должно быть `Using @angular/language-service v2x.x.x`;
   - не должно быть `'@angular/core' could not be found` и `No config file for ...html`.
3. В шаблоне набрать `product().` / `item.` внутри `{{ }}` — должны появиться реальные поля.

## Inlay hints в шаблонах

Новый `@angular/language-server` (22.x) по умолчанию рисует inlay hints прямо в тексте шаблона (`[hero: IHero]`, `as latestProducts: {...}`). coc-angular 17 не знает про настройки `angular.inlayHints.*`, поэтому они выключены на стороне coc в глобальном `coc-settings.json`:

```json
"[html][htmlangular][html.htmlangular]": {
  "inlayHint.enable": false
}
```

Если хинты снова нужны — убрать этот блок (или временно `:CocCommand document.toggleInlayHint`).

## Если всё ещё не работает

- `:CocList extensions` — coc-angular установлен и активен.
- `:set filetype?` в шаблоне — ожидается `html.htmlangular` (autocmd в `modules/coc.vim`).
- `node -v` — достаточно свежий Node.
- Остальной порядок диагностики — `CLAUDE.md`, «Troubleshooting: Works on one machine, not another».
