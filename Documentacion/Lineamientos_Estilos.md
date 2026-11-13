# Lineamientos de estilo

## Sistema de Gestión de Clínica Médica “Clínica San Rafael”

**Proyecto:** TPINT_GRUPO_1_PR3
**Materia:** Programación III — Tecnicatura Universitaria en Programación
**Institución:** UTN Facultad Regional General Pacheco
**Tecnología:** ASP.NET Web Forms (C#) · .NET Framework 4.8 · SQL Server
**Versión:** 1.0 — Primera entrega (16/11/2026)

---

## 1. Objetivo y alcance

Este documento define la identidad visual, los componentes y las convenciones de interfaz que se aplican en todas las pantallas del sistema. Su finalidad es que cualquier integrante del grupo pueda construir una página nueva sin inventar estilos y que el resultado sea visual y funcionalmente consistente con las pantallas ya entregadas.

Los lineamientos se derivan de la hoja de estilos real del proyecto (`Estilos/estilos.css`) y de las páginas implementadas. **No proponen un sistema de diseño nuevo**: documentan lo que ya está construido para asegurar su continuidad.

Alcance:

- Paleta, tipografía, espaciado y estructura de pantalla.
- Componentes reutilizables (tarjetas, formularios, grillas, avisos, modales, reportes).
- Estados de interacción, accesibilidad y convenciones de código CSS.
- Criterios de redacción de la interfaz.
- Implementación de los estilos en ASP.NET Web Forms.

Fuera de alcance: la definición funcional del sistema, el modelo de datos y las reglas de negocio, que se documentan en el informe de la entrega.

---

## 2. Principios de diseño

1. **Claridad operativa.** La pantalla debe permitir identificar en pocos segundos dónde está el usuario, qué datos está viendo y cuál es la acción principal.
2. **Consistencia.** Un mismo elemento se ve y se comporta igual en todas las páginas. Los colores, radios, tamaños y espacios provienen de los tokens definidos en `:root`.
3. **Jerarquía visual.** Un único título por pantalla, una única acción primaria por bloque y el resto de las acciones en segundo plano.
4. **Densidad controlada.** Es un sistema administrativo: se prioriza ver muchos datos sin perder legibilidad, con filas compactas y tipografía de 13 px en grillas.
5. **Previsibilidad.** Toda acción destructiva se confirma; todo resultado de una operación se informa; todo campo obligatorio se señala.
6. **Sobriedad institucional.** Paleta azul petróleo y verde azulado, sin gradientes decorativos fuera del login, sin animaciones llamativas.

---

## 3. Identidad visual

- **Nombre visible:** Clínica San Rafael.
- **Bajada:** Sistema de Gestión.
- **Símbolo:** cruz médica (`+`) blanca sobre un cuadrado redondeado verde azulado.
- **Tono:** profesional, sanitario, tranquilo. Se evita el lenguaje coloquial y los signos de exclamación.
- **Color de marca:** verde azulado (`--teal: #0e8f8f`) para acciones principales; azul petróleo (`--azul-900: #0d2f47`) para estructura y títulos.

El login es la única pantalla que utiliza un fondo con gradiente de marca (`#0d2f47 → #17567c → #0e8f8f`). El resto de la aplicación usa fondo gris claro (`--gris-100`).

---

## 4. Paleta de colores

Todos los colores se declaran como variables CSS en `:root`. **No se deben escribir valores hexadecimales sueltos** en las páginas: siempre se referencia la variable.

### 4.1 Azules institucionales

| Token | Hex | Uso |
|---|---|---|
| `--azul-900` | `#0d2f47` | Fondo del encabezado, títulos de página y de tarjeta, valores de KPI |
| `--azul-800` | `#11405e` | Cabecera de grillas, hover de botón azul, texto de menú activo |
| `--azul-700` | `#17567c` | Botón azul, enlaces, página actual del paginador |
| `--azul-500` | `#2b7fb0` | Foco de campos, borde izquierdo de KPI por defecto |
| `--celeste` | `#e8f2f8` | Fondo de menú activo, hover de filas, aviso informativo |

### 4.2 Neutros

| Token | Hex | Uso |
|---|---|---|
| `--blanco` | `#ffffff` | Fondo de tarjetas, campos y grillas |
| `--gris-100` | `#f4f7fa` | Fondo general, filtros, pie de modal, campos deshabilitados |
| `--gris-200` | `#e7edf2` | Bordes de tarjetas, separadores y bordes de fila |
| `--gris-300` | `#d6dfe6` | Bordes de campos, botones secundarios y paginador |
| `--gris-500` | `#7a8b98` | Texto secundario, ayudas, etiquetas de KPI |
| `--gris-700` | `#4a5a67` | Texto de grillas, etiquetas de formulario, ítems de menú |
| `--gris-900` | `#1f2a33` | Texto principal del cuerpo |

### 4.3 Colores semánticos

| Token | Hex | Fondo | Uso |
|---|---|---|---|
| `--verde` | `#1e8e5a` | `--verde-bg: #e3f5ec` | Presente, confirmación, operación exitosa |
| `--rojo` | `#b3362c` | `--rojo-bg: #fbe7e5` | Ausente, error, eliminación, acción destructiva |
| `--ámbar` | `#9a6b00` | `--ámbar-bg: #fdf3d8` | Pendiente, advertencia |
| `--teal` | `#0e8f8f` | `#e0f2f2` | Acción primaria, marca, acentos |
| `--teal-oscuro` | `#0a6f6f` | — | Hover de la acción primaria |

**Regla de uso del color:** el color nunca es el único portador de información. Los estados se acompañan siempre de texto (por ejemplo, la etiqueta “Presente” además del punto verde).

### 4.4 Sombra

| Token | Valor | Uso |
|---|---|---|
| `--sombra` | `0 1px 2px rgba(16,42,67,.06), 0 4px 12px rgba(16,42,67,.06)` | Tarjetas y KPI |

Las sombras son muy sutiles. No se usan sombras fuertes fuera del login, del modal y del menú flotante.

---

## 5. Tipografía

### 5.1 Familia

```css
font-family: "Segoe UI", "Inter", Roboto, "Helvetica Neue", Arial, sans-serif;
```

Se utiliza la tipografía del sistema para evitar dependencias externas y demoras de carga. No se incorporan fuentes web.

### 5.2 Escala

| Elemento | Tamaño | Peso | Color | Notas |
|---|---|---|---|---|
| Cuerpo | 14 px | 400 | `--gris-900` | `line-height` normal del navegador |
| Título de página (`h1`) | 21 px | 600 | `--azul-900` | Uno por pantalla |
| Título de tarjeta (`h2`) | 14,5 px | 600 | `--azul-900` | En `.tarjeta-cab` |
| Título de modal (`h3`) | 16 px | 600 | `--azul-900` | |
| Valor de KPI | 27 px | 700 | `--azul-900` | `line-height: 1` |
| Etiqueta de KPI | 11,5 px | 600 | `--gris-500` | Mayúsculas, `letter-spacing: .6px` |
| Etiqueta de campo | 12 px | 600 | `--gris-700` | `letter-spacing: .2px` |
| Texto de campo | 13,5 px | 400 | `--gris-900` | Inputs, selects y textarea |
| Texto de grilla | 13 px | 400 | `--gris-700` | Cabecera 11,5 px en mayúsculas |
| Botón | 13,5 px | 600 | Según variante | Botón mini: 12 px |
| Ayuda y error | 11,5 px | 400 | `--gris-500` / `--rojo` | Debajo del campo |
| Migas de pan | 12 px | 400 | `--gris-500` | |
| Nota al pie | 11,5 px | 400 | `--gris-500` | `line-height: 1.6` |

### 5.3 Reglas

- No se usan más de tres tamaños de texto en un mismo bloque.
- Los títulos no llevan punto final.
- Las mayúsculas se reservan para etiquetas cortas (KPI, cabecera de grilla, títulos de sección del menú). Nunca para párrafos.
- El texto de ayuda y el de error se escriben en minúscula inicial, sin negrita.
- No se utiliza `text-align: justify`.

---

## 6. Espaciado, radios y medidas

La unidad base es **4 px**. Todos los espacios son múltiplos de 4.

| Concepto | Valor |
|---|---|
| Espaciado base | 4 px |
| Separación entre campos de una fila | 14 px |
| Separación entre filas de formulario | 14 px |
| Padding interno de tarjeta | 18 px |
| Padding de cabecera de tarjeta | 14 px 18 px |
| Padding de contenido de página | 26 px 30 px 40 px |
| Separación entre tarjetas | 20 px |
| Padding de botón | 9 px 18 px |
| Padding de campo | 9 px 11 px |
| Radio de tarjeta | 12 px |
| Radio de botón y campo | 8 px |
| Radio de modal | 14 px |
| Radio de etiqueta (badge) | 999 px |
| Ancho del menú lateral | 232 px |
| Alto del encabezado | 64 px |
| Ancho del modal | 480 px |
| Ancho de la tarjeta de login | 900 px |

**Regla:** los márgenes entre secciones se resuelven con `margin-bottom` del bloque contenedor, no con márgenes individuales de cada elemento.

---

## 7. Estructura de pantalla

### 7.1 Layout general (páginas internas)

```
┌──────────────────────────────────────────────────────────┐
│ ENCABEZADO 64 px: marca · usuario · cerrar sesión        │
├──────────────┬───────────────────────────────────────────┤
│ MENÚ 232 px  │ CONTENIDO                                 │
│              │  migas de pan                             │
│              │  título de página + acciones              │
│              │  avisos                                   │
│              │  tarjetas / KPI / grillas                 │
└──────────────┴───────────────────────────────────────────┘
```

- El encabezado es `position: sticky` y permanece visible al desplazarse.
- El menú lateral no se colapsa: es fijo y de 232 px.
- El contenido ocupa el resto del ancho (`flex: 1`) con `min-width: 0` para permitir el scroll horizontal de las grillas.
- El alto mínimo del cuerpo es `calc(100vh - 64px)`.

### 7.2 Encabezado

Elementos, en orden:

1. `.marca`: símbolo `.cruz`, nombre fuerte y bajada en mayúsculas.
2. `.separador`: empuja el resto a la derecha.
3. `.usuario-chip`: avatar con iniciales, nombre y rol. **Debe estar visible en todas las pantallas internas** (requisito de la cátedra).
4. `.btn-salir`: cierre de sesión.

### 7.3 Menú lateral

- Título de sección: `.titulo`, 10,5 px, mayúsculas, `--gris-500`.
- Ítem: enlace con icono SVG de 16 px y texto de 13,5 px.
- Ítem activo: fondo `--celeste`, texto `--azul-800`, peso 600 y barra izquierda de 3 px `--teal`.
- Hover: fondo `--gris-100`, sin subrayado.
- El ítem de cierre de sesión se implementa con `LinkButton` para limpiar la sesión, pero conserva la apariencia de ítem de menú.

### 7.4 Encabezado de página

```html
<div class="migas"><a href="../Default.aspx">Inicio</a> / Gestión de pacientes</div>
<div class="titulo-pagina">
    <div>
        <h1>Pacientes</h1>
        <p>Alta, modificación, baja lógica y consulta de pacientes.</p>
    </div>
    <div class="botones">
        <a class="btn btn-primario" href="Pacientes.aspx?nuevo=1">+ Nuevo paciente</a>
    </div>
</div>
```

- Las migas indican la ubicación y siempre comienzan en “Inicio”.
- El título describe la pantalla, no la acción.
- La descripción es una sola línea e indica qué se puede hacer.
- La acción principal va a la derecha, alineada con el título.

### 7.5 Login

- Fondo con gradiente de marca y tarjeta centrada de 900 px.
- Columna izquierda (44 %): mensaje institucional, título y pie.
- Columna derecha (56 %): formulario, título “Iniciar sesión”, subtítulo y campos.
- Es la única pantalla sin encabezado ni menú.
- El botón de ingreso es `.btn-primario` a ancho completo.

---

## 8. Componentes

### 8.1 Tarjetas

Contenedor base de todo bloque de contenido.

```html
<div class="tarjeta">
    <div class="tarjeta-cab">
        <h2>Listado de pacientes</h2>
        <span class="nota">128 registros activos</span>
    </div>
    <div class="tarjeta-cuerpo"> … </div>
</div>
```

- Una tarjeta agrupa un único tema.
- La cabecera lleva título y, opcionalmente, una nota alineada a la derecha.
- No se anidan tarjetas dentro de tarjetas.
- El cuerpo puede reemplazarse por `.filtros`, `.tabla-scroll` o `.paginador` cuando el bloque es una grilla.

### 8.2 KPI

Se usan en el panel de inicio y en “Mis turnos”.

```html
<div class="kpis">
    <div class="kpi teal">
        <div class="etiqueta">Turnos de hoy</div>
        <div class="valor">18</div>
        <div class="detalle">6 pendientes de atención</div>
    </div>
</div>
```

- Siempre en grilla de 4 columnas.
- Borde izquierdo de 4 px: azul por defecto; `.teal`, `.verde` o `.ambar` según el significado.
- Etiqueta en mayúsculas, valor grande y detalle breve.
- No se usan KPI sin detalle: el detalle aporta contexto.

### 8.3 Formularios

Estructura de fila y campo:

```html
<div class="fila">
    <div class="campo">
        <label for="<%= txtNombre.ClientID %>">Nombre <span class="req">*</span></label>
        <asp:TextBox ID="txtNombre" runat="server" MaxLength="60" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre"
            ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
            ErrorMessage="Ingrese el nombre." />
    </div>
    <div class="campo medio"> … </div>
    <div class="campo angosto"> … </div>
</div>
```

Reglas:

- Cada campo tiene etiqueta visible asociada con `for`. No se usa el placeholder como etiqueta.
- Los obligatorios se marcan con `<span class="req">*</span>` y la leyenda “Los campos con * son obligatorios” en la cabecera de la tarjeta.
- Anchos: `.campo` es flexible (mínimo 180 px); `.campo.medio` 220 px; `.campo.angosto` 140 px.
- Una fila no debe superar los cuatro campos. Si hay más, se distribuyen en varias filas.
- Los campos relacionados se agrupan en la misma fila (por ejemplo, DNI, nombre y apellido).
- Textarea: alto mínimo 70 px y redimensionable solo en vertical.
- Los mensajes de validación se muestran debajo del campo, en rojo, con `Display="Dynamic"`.
- El texto de ayuda va debajo del campo con `.ayuda`.
- Los campos calculados o de solo lectura usan `readonly` y fondo gris.
- Los formularios de alta y modificación comparten la misma pantalla; el título y las migas cambian según el modo.

### 8.4 Botones

| Clase | Apariencia | Uso |
|---|---|---|
| `.btn .btn-primario` | Fondo teal, texto blanco | Acción principal: guardar, ingresar, confirmar |
| `.btn .btn-azul` | Fondo azul 700, texto blanco | Acción de búsqueda o secundaria fuerte |
| `.btn .btn-secundario` | Fondo blanco, borde gris | Cancelar, volver, limpiar |
| `.btn .btn-peligro` | Fondo rojo, texto blanco | Confirmar una baja o una acción destructiva |
| `.btn .btn-mini` | Versión compacta | Acciones dentro de tablas |
| `.btn-link` | Texto azul sin fondo | “Editar”, “Ver”, acciones terciarias |
| `.btn-link.peligro` | Texto rojo sin fondo | “Eliminar” dentro de una fila |

Reglas:

- **Una sola acción primaria por bloque.** El resto son secundarias o de peligro.
- El orden visual es: secundaria a la izquierda, primaria a la derecha.
- Las acciones destructivas nunca son la acción primaria de la pantalla.
- Todo botón debe tener texto claro; se evitan íconos solos sin `title` o texto accesible.
- Los botones dentro de grillas son `.btn-link` o `.btn-mini`, nunca `.btn` de tamaño completo.
- `+` se usa solo en acciones de alta (“+ Nuevo paciente”).

### 8.5 Filtros

```html
<div class="filtros">
    <div class="fila">
        <div class="campo"> … </div>
        <div class="campo medio"> … </div>
        <div class="campo angosto" style="flex: 0 0 auto; display: flex; align-items: flex-end; gap: 8px">
            <asp:Button runat="server" Text="Buscar" CssClass="btn btn-azul" />
            <asp:Button runat="server" Text="Limpiar" CssClass="btn btn-secundario" />
        </div>
    </div>
</div>
```

- Los filtros van dentro de la tarjeta del listado, arriba de la grilla, con fondo `--gris-100`.
- El botón “Buscar” es azul y “Limpiar” es secundario.
- Los filtros se envían por query string para que el listado sea enlazable y el paginador conserve el criterio.
- Los filtros de texto libre se rotulan “Buscar por…” y aplican `LIKE %texto%`.
- Los desplegables incluyen la opción “Todos” con valor vacío o `0`.

### 8.6 Grillas de datos

```html
<div class="tabla-scroll">
    <asp:GridView ID="gvPacientes" runat="server" AutoGenerateColumns="False"
        CssClass="grid" UseAccessibleHeader="true" GridLines="None">
        <Columns>
            <asp:BoundField DataField="DNI" HeaderText="DNI" ItemStyle-CssClass="principal" />
            …
            <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="acciones"> … </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>
```

Reglas:

- Cabecera azul 800 con texto claro en mayúsculas, 11,5 px y borde inferior teal de 2 px.
- Filas de 10 px de padding vertical, separador gris 200 y alternancia muy sutil (`#fafcfd`).
- Hover de fila en celeste.
- La columna de acciones va última, alineada a la derecha y sin saltos de línea.
- El dato identificatorio principal (DNI, matrícula, fecha/hora) se destaca con `.principal`.
- Los importes y cantidades se alinean a la derecha; el texto, a la izquierda.
- No se muestran columnas técnicas (IDs internos, `EstadoRegistro`).
- Los estados se muestran con `.badge`, no con texto plano.
- Toda grilla debe tener estado vacío: una fila o mensaje que indique “No se encontraron registros”.

### 8.7 Paginación

Dos implementaciones con la misma apariencia:

1. **Paginador propio** (`.paginador` + `.paginas`) para los listados con filtros por query string.
2. **Paginador nativo de GridView** (`tr.pager`) para grillas de informes y detalles.

Reglas:

- Mostrar el resumen “Mostrando X–Y de Z”.
- Botones de 32 × 32 px, radio 7 px.
- Página actual con fondo azul 700 y texto blanco.
- Se muestran como máximo 7 números, con elipsis (`.puntos`) si hay más.
- “Anterior” y “Siguiente” se deshabilitan visualmente en los extremos.
- El paginador va al pie de la tarjeta, separado por una línea gris.

### 8.8 Etiquetas de estado (badges)

```html
<span class="badge badge-presente">Presente</span>
<span class="badge badge-ausente">Ausente</span>
<span class="badge badge-pendiente">Pendiente</span>
<span class="badge badge-neutro">Cancelado</span>
```

- Siempre incluyen un punto de 6 px del color del texto.
- `badge-presente`: verde. `badge-ausente`: rojo. `badge-pendiente`: ámbar. `badge-neutro`: gris. `badge-teal`: teal.
- El texto es una sola palabra o una expresión de dos como máximo.
- No se usan badges para acciones, solo para estados.

### 8.9 Avisos

| Clase | Uso |
|---|---|
| `.aviso .aviso-ok` | Operación exitosa (“Paciente registrado correctamente”) |
| `.aviso .aviso-error` | Error de validación o de negocio |
| `.aviso .aviso-info` | Contexto de edición o aclaración |
| `.aviso .aviso-warn` | Advertencia que no impide continuar |

- Se ubican debajo del título de página y antes de la tarjeta.
- Son de una sola línea o dos como máximo.
- El mensaje empieza con el resultado y luego el detalle: “Paciente guardado. El DNI 30.111.222 ya existe…”.
- Se ocultan (`Visible="false"`) hasta que corresponde mostrarlos y no se acumulan: un aviso por operación.

### 8.10 Modal de confirmación

Se usa para bajas lógicas y acciones irreversibles.

```html
<div class="velo">
    <div class="modal">
        <div class="modal-cab">
            <div class="icono">!</div>
            <h3>Confirmar baja</h3>
        </div>
        <div class="modal-cuerpo">¿Confirma la baja del paciente …?</div>
        <div class="modal-pie">
            <button class="btn btn-secundario">Cancelar</button>
            <button class="btn btn-peligro">Sí, dar de baja</button>
        </div>
    </div>
</div>
```

- Ancho 480 px, radio 14 px, fondo blanco y velo `rgba(9,30,45,.55)`.
- Cabecera con ícono circular rojo, título y borde inferior.
- Cuerpo con la consecuencia de la acción, no solo la pregunta.
- Pie gris con “Cancelar” (secundario) a la izquierda y la acción destructiva (peligro) a la derecha.
- El foco inicial va al botón “Cancelar”.
- `Esc` y clic en el velo cierran el modal.
- Nunca se usa `confirm()` del navegador.

### 8.11 Reportes y visualizaciones

- `.reportes-grid`: dos columnas iguales con separación de 18 px.
- `.barra`: barra apilada de 26 px de alto, radio 6 px, con segmentos verde (presente) y rojo (ausente).
- `.torta`: círculo de 140 px con centro blanco de 92 px para el total.
- `.leyenda` y `.punto`: referencia de colores debajo de cada gráfico.
- `.tabla-resumen`: tabla compacta de 12,5 px, cabecera gris claro sin mayúsculas.
- `.nota-pie`: aclaración metodológica al pie del informe.
- Todo gráfico debe tener su tabla de respaldo o leyenda con valores; el color no puede ser la única fuente de información.

### 8.12 Login

- No reutiliza el layout interno.
- Campos con las mismas reglas de formulario.
- Mensaje de error en `.aviso .aviso-error`.
- El botón de ingreso ocupa el ancho completo.
- El pie muestra la versión o el año.

---

## 9. Estados e interacción

| Estado | Tratamiento |
|---|---|
| Hover de enlace | Subrayado; en menú, fondo gris claro y sin subrayado |
| Hover de botón | Color más oscuro de la misma familia |
| Hover de fila | Fondo celeste |
| Foco | Borde azul 500 y anillo `0 0 0 3px rgba(43,127,176,.15)` |
| Activo (clic) | Desplazamiento de 1 px hacia abajo (`translateY(1px)`) |
| Deshabilitado | Fondo gris 100, texto gris 500, sin cursor de acción |
| Solo lectura | Fondo gris 100, texto gris 500 |
| Error de campo | Borde y mensaje rojo debajo del campo |
| Cargando | Texto “Procesando…” en el botón y botón deshabilitado |
| Vacío | Mensaje explicativo dentro de la tarjeta, sin grilla |

Reglas:

- Las transiciones son cortas: 150 ms y solo sobre color, borde y sombra.
- No se usan animaciones de entrada, parallax ni efectos de carga llamativos.
- El foco del teclado siempre es visible; nunca se aplica `outline: none` sin reemplazo.
- Los estados no dependen exclusivamente del color.

---

## 10. Redacción de la interfaz

- **Idioma:** español rioplatense, sin voseo en la interfaz. Se prefiere la forma neutra: “Ingrese el DNI”, “Seleccione una especialidad”.
- **Títulos:** sustantivo o frase nominal. “Pacientes”, “Nuevo turno”, “Informe de atención”.
- **Botones:** verbo en infinitivo o imperativo breve. “Guardar”, “Buscar”, “Dar de baja”, “Volver al listado”.
- **Etiquetas:** sustantivo, sin dos puntos. “Fecha de nacimiento”, “Matrícula”.
- **Mensajes de éxito:** “Paciente guardado correctamente.”
- **Mensajes de error:** qué falló y cómo resolverlo. “El DNI ya está registrado. Verifique el número ingresado.”
- **Confirmaciones:** pregunta + consecuencia. “¿Confirma la baja de…? El registro dejará de aparecer en los listados.”
- **Fechas:** `dd/mm/aaaa` (cultura `es-AR`).
- **Horas:** `HH:mm` en formato de 24 horas.
- **Importes:** `$ 1.234,56` con separador de miles y coma decimal.
- **DNI y matrícula:** sin puntos ni espacios en los datos; se pueden formatear solo para lectura.
- **Mayúsculas:** se evita el texto todo en mayúsculas salvo etiquetas cortas.
- **Puntos suspensivos:** solo para acciones que abren otra instancia.
- **Signos:** se usan signos de apertura en preguntas y exclamaciones (¿ ?).

---

## 11. Accesibilidad

- Contraste mínimo 4,5:1 para texto normal. La combinación gris 700 sobre blanco y blanco sobre azul 800 cumple.
- Todos los campos tienen `<label>` asociado; los `GridView` usan `UseAccessibleHeader="true"`.
- El foco es visible en todos los controles.
- Las imágenes decorativas llevan `alt=""`; las informativas, `alt` descriptivo.
- Los íconos del menú son SVG con `stroke="currentColor"` y acompañan siempre a un texto.
- No se transmite información solo por color: los estados llevan texto.
- El modal atrapa el foco y se cierra con `Esc`.
- El tamaño mínimo de texto es 11,5 px y solo para metadatos.
- Los mensajes de validación se anuncian junto al campo, no en un bloque lejano.

---

## 12. Comportamiento responsive e impresión

- **Objetivo:** escritorio de 1280 px o superior. El sistema es administrativo y no está diseñado para uso móvil.
- Las filas de formulario usan `flex-wrap`, por lo que los campos bajan de línea en anchos menores.
- Las grillas se envuelven en `.tabla-scroll` para desplazamiento horizontal sin romper el layout.
- El menú lateral no se colapsa; en anchos muy reducidos aparece el scroll horizontal de la página.
- No se usan media queries de breakpoint, para mantener una única experiencia visual.
- **Impresión:** `@media print` oculta encabezado, menú, botones y paginador. Los informes se imprimen solo con el contenido y las tablas.

---

## 13. Convenciones de CSS

### 13.1 Organización del archivo

`Estilos/estilos.css` se ordena por bloques, separados con comentarios:

1. Variables y base
2. Login
3. Layout
4. Encabezados de página
5. Tarjetas y KPI
6. Formularios
7. Filtros
8. Grillas y paginación
9. Etiquetas
10. Avisos
11. Modal
12. Reportes
13. Paginador nativo de GridView
14. Impresión

### 13.2 Nomenclatura

- Clases en minúscula, en español y separadas con guion: `.titulo-pagina`, `.tarjeta-cab`, `.btn-peligro`, `.badge-presente`.
- Se usa el patrón **bloque-elemento**: `.tarjeta`, `.tarjeta-cab`, `.tarjeta-cuerpo`; `.modal`, `.modal-cab`, `.modal-cuerpo`, `.modal-pie`.
- Los modificadores se agregan como segunda clase: `.btn.btn-primario`, `.kpi.teal`, `.aviso.aviso-error`.
- No se usan IDs para estilos.
- No se usa `!important` salvo en la hoja de impresión.
- No se anidan selectores más de dos niveles.
- Los nombres describen la función, no el aspecto: `.btn-peligro`, no `.btn-rojo`.

### 13.3 Valores

- Colores: siempre mediante variables de `:root`.
- Tamaños: `px` para tipografía y componentes; `%`, `fr` y `calc()` para layout.
- Sombras: variable `--sombra` o valores documentados.
- Sin prefijos de proveedor salvo los necesarios.
- Sin estilos en línea, salvo ajustes puntuales de layout en un campo (por ejemplo, alinear un botón al pie de una fila).

### 13.4 Reglas de convivencia

- No se incorpora Bootstrap ni otra librería de UI: el estilo propio garantiza que las capturas y el sistema real coincidan.
- Todo estilo nuevo debe reutilizar un componente existente antes de crear una clase.
- Si se crea una clase, se agrega a este documento y al inventario del anexo.
- Los estilos específicos de una página van en `Estilos/estilos.css`, no en bloques `<style>` dentro del `.aspx`.

---

## 14. Implementación en ASP.NET Web Forms

- La hoja de estilos se referencia una sola vez desde `Site.Master`:
  `<link href="~/Estilos/estilos.css" rel="stylesheet" runat="server" />`.
- Los controles del servidor reciben la clase con `CssClass`: `CssClass="grid"`, `CssClass="btn btn-primario"`, `CssClass="aviso aviso-ok"`.
- Los `GridView` usan `AutoGenerateColumns="False"`, `GridLines="None`, `CssClass="grid"` y `UseAccessibleHeader="true"`.
- La columna de acciones se define con `TemplateField` y `ItemStyle-CssClass="acciones"`.
- Los validadores usan `CssClass="error-campo"`, `Display="Dynamic"` y un `ValidationGroup` por formulario.
- Los paneles de mensaje usan `Visible="false"` y se muestran desde el código.
- Los controles que no son de servidor (encabezados, migas, contenedores) usan HTML plano con las mismas clases.
- El modal se implementa con un `Panel` y las clases `.velo` / `.modal`, controlado por `Visible`.
- No se usa `Style` en línea para colores ni tipografía.
- Las páginas nuevas heredan de `PaginaBase` y respetan el layout de `Site.Master`.

---

## 15. Checklist de revisión de una pantalla

Antes de considerar terminada una pantalla, verificar:

- [ ] Usa `Site.Master` y muestra el usuario logueado en el encabezado.
- [ ] Tiene migas de pan y un único `h1`.
- [ ] La acción principal es única y está a la derecha del título.
- [ ] Todos los campos tienen etiqueta y los obligatorios están marcados con `*`.
- [ ] Los mensajes de validación están debajo del campo y en rojo.
- [ ] La grilla tiene cabecera accesible, columna de acciones y estado vacío.
- [ ] Los estados se muestran con badges y texto, no solo con color.
- [ ] La paginación conserva los filtros aplicados.
- [ ] Las bajas piden confirmación con el modal propio.
- [ ] Los avisos de resultado se muestran una sola vez y desaparecen al continuar.
- [ ] Los colores y tamaños provienen de las variables y clases existentes.
- [ ] La pantalla se ve correctamente a 1280 px y se imprime sin menú ni botones.
- [ ] No hay estilos en línea ni clases nuevas sin documentar.

---

## Anexo A. Inventario de clases

| Grupo | Clases |
|---|---|
| Layout | `.encabezado`, `.marca`, `.cruz`, `.separador`, `.usuario-chip`, `.avatar`, `.datos`, `.btn-salir`, `.cuerpo`, `.menu`, `.titulo`, `.ico`, `.contenido` |
| Página | `.migas`, `.titulo-pagina` |
| Tarjetas | `.tarjeta`, `.tarjeta-cab`, `.tarjeta-cuerpo`, `.nota` |
| KPI | `.kpis`, `.kpi`, `.etiqueta`, `.valor`, `.detalle`, `.teal`, `.verde`, `.ambar` |
| Formularios | `.fila`, `.campo`, `.campo.angosto`, `.campo.medio`, `.etiqueta-campo`, `.req`, `.ayuda`, `.error-campo`, `.campo-check` |
| Botones | `.botones`, `.derecha`, `.btn`, `.btn-primario`, `.btn-azul`, `.btn-secundario`, `.btn-peligro`, `.btn-mini`, `.btn-link`, `.peligro` |
| Filtros | `.filtros` |
| Grillas | `.tabla-scroll`, `table.grid`, `.principal`, `.acciones`, `tr.pager` |
| Paginación | `.paginador`, `.info`, `.paginas`, `.actual`, `.puntos` |
| Estados | `.badge`, `.badge-presente`, `.badge-ausente`, `.badge-pendiente`, `.badge-neutro`, `.badge-teal` |
| Avisos | `.aviso`, `.aviso-ok`, `.aviso-error`, `.aviso-info`, `.aviso-warn` |
| Modal | `.velo`, `.modal`, `.modal-cab`, `.icono`, `.modal-cuerpo`, `.modal-pie` |
| Reportes | `.reportes-grid`, `.barra`, `.pres`, `.aus`, `.leyenda`, `.punto`, `.torta`, `.circulo`, `.centro`, `.tabla-resumen`, `.nota-pie` |
| Login | `.login-body`, `.login-card`, `.login-lado`, `.login-form`, `.subtitulo`, `.pie` |

## Anexo B. Tokens de referencia rápida

```css
:root {
    --azul-900: #0d2f47;   --azul-800: #11405e;
    --azul-700: #17567c;   --azul-500: #2b7fb0;
    --celeste: #e8f2f8;    --teal: #0e8f8f;
    --teal-oscuro: #0a6f6f;
    --gris-900: #1f2a33;   --gris-700: #4a5a67;
    --gris-500: #7a8b98;   --gris-300: #d6dfe6;
    --gris-200: #e7edf2;   --gris-100: #f4f7fa;
    --verde: #1e8e5a;      --verde-bg: #e3f5ec;
    --rojo: #b3362c;       --rojo-bg: #fbe7e5;
    --ambar: #9a6b00;      --ambar-bg: #fdf3d8;
    --sombra: 0 1px 2px rgba(16,42,67,.06), 0 4px 12px rgba(16,42,67,.06);
}
```

---

*Documento de lineamientos de estilo — Clínica San Rafael · Programación III · UTN FRGP.*
