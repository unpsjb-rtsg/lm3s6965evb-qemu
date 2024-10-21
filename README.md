# HelloWorld para la placa LM3S6965

Programa de ejemplo que imprime el mensaje `Hello World!`, basado en la [demo de FreeRTOS para QEMU](https://www.freertos.org/cortex-m3-qemu-lm3S6965-demo.html).

## Docker

Generar la imagen docker con:
```bash
docker build rtsg -t .
```

**Importante**: el script `docker.make` espera que la imagen se llame `rtsg`.

Para compilar el proyecto:
```bash
docker.make
```

Para ejecutar:
```bash
docker.make qemu
```

Para terminar la ejecución, presionar `C^A X`.

Es posible visualizar la salida gráfica de QEMU mediante VNC conectandose a `:0`.

## Importar y compilar en Eclipse

Clonar o descargar este repositorio. Luego, para importar el proyecto en Eclipse:

1. Seleccionar **[File > New > Makefile Project with Existing Code]**. 
2. En la nueva ventana:
   - En **[Existing Code Location]** indicar el *path* en donde se descargó o clonó el repositorio (usar el botón **[Browse...]**).
   - En **[Toolchain for Indexer]** seleccionar la opción *ARM Cross GCC* (¡importante!).

3. El proyecto debe aparecer ahora en la vista *Project Explorer*: 
   - Hacer clic derecho sobre el mismo, y seleccionar **[Properties]** en el menú contextual.
   - En la nueva ventana, en la sección izquierda, seleccionar **[C/C++ Build > Settings]**. En la sección derecha de la ventana, hacer clic en la pestaña **[Toolchains]**. Verificar que el campo *Name* indique *GNU MCU Eclipse ARM Embedded GCC (arm-none-eabi-gcc)* o similar.
   - Hacer clic en **[Apply and Close]**.

Para compilarlo se puede:

- Hacer clic derecho sobre el proyecto en la vista *Project Explorer* y seleccionar **[Build]** en el menú contextual.
- Seleccionar en la barra de menúes de Eclipse **[Project > Build Project]**.
- Hacer clic en el ícono *Build* (un martillo).

Si el proyecto compilo correctamente, en la vista **[Console]** debe indicarse que se generó correctamente el archivo `build/main.elf`.

## Debugging desde Eclipse con QEMU

Primero configurar el perfil de _debugging_:

1. Seleccionar **[Run > Debug Configurations...]** en el menú de Eclipse.
2. En la nueva ventana, hacer doble clic sobre **[GDB Hardware Debugging]** en el menú izquierdo. Esto crea una nueva configuración basada en el perfil, con el nombre del proyecto activo.
3. Seleccionar el nuevo perfil creado (*lm3s6965evb-helloworld-makefile*).
4. En el panel derecho:
    - En la pestaña **[Main]**:
      - En el *Project* debe indicar el nombre del proyecto (*lm3s6965evb-helloworld-makefile*).
      - En el campo *C/C++ Application* se debe indicar `build/main.elf`.
      - Seleccionar **Use workspace settings**.
    - En la pestaña **[Debugger]**:
      - El campo *GDB Command* debe decir `arm-none-eabi-gdb`.
      - Seleccionar **Use remote target**.
      - En *GDB Connection String* completar `localhost:1234`.
    - En la pestaña **[Startup]**:
      - Desmarcar **Reset and delay**, **Halt** y **Load image** si estuvieran seleccionados.
      - Seleccionar la opción **Load symbols** y **Use project binary: main.elf**.
      - Seleccionar la opción **Set breakpoint at:** y en el campo adyacente indicar `main`.
      - Seleccionar la opción **Resume**.
    - En la pestaña **[Common]**, seleccionar la opción **[Shared file:]**, indicando en el campo el nombre del proyecto. De esta manera la configuración para debugging es guardada en un archivo `*.launch` dentro del proyecto.
    - Hacer clic en el botón **[Apply]**, no cerrar la ventana aún.

A continuación, abrir una terminal y ejecutar el siguiente comando (utilizar el _path_ correcto a `main.elf`):

```bash
qemu-system-arm -kernel ./build/main.elf -S -s -machine lm3s6965evb
```

Como resultado, debe ejecutarse QEMU, presentando una ventana y quedando a la espera de que se conecte una sesión de _debugging_.

Luego, desde Eclipse hacemos clic en el botón **[Debug]**, y cuando Eclipse nos pregunte si queremos cambiar a la perspectiva de _Debugging_ le decimos que sí (_switch_).

Si todo funcionó correctamente, se alcanza el _breakpoint_ en la función `main()` y la ejecución queda detenida en ese punto. Seleccionar **[Run > Resume]** (o presionar **F8**) y en la ventana de QEMU debe aparecer el mensaje `Hello World!`.
