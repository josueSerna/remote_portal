# Rick and Morty App

Aplicación en Flutter que consume la [API de Rick and Morty](https://rickandmortyapi.com) para mostrar los personajes de la serie y su información.

## ¿Qué trae la app?

### Pantalla principal
- Lista de personajes en formato **grid** (cuadrícula) con imagen, nombre, estado y especie.
- **Scroll infinito**: al llegar al final se cargan automáticamente más personajes (la API entrega 20 por página).
- **Pull to refresh**: desliza hacia abajo para recargar la lista.
- Indicador de carga inicial y al cargar más páginas.
- **Manejo de errores** con mensajes claros y botón de **Reintentar**.

### Pantalla de detalle
- Imagen del personaje con animación (`Hero`) al entrar.
- Estado, especie, tipo, género, origen, última ubicación, número de episodios y fecha de creación.
- Estados de carga y error, también con botón de **Reintentar**.

## ¿Por qué existe el botón de "Reintentar"?

La API de Rick and Morty tiene un **límite de peticiones (rate limit)**. Si se hacen demasiadas solicitudes en poco tiempo, por ejemplo al hacer scroll muy rápido o al refrescar varias veces seguidas, la API deja de responder temporalmente y devuelve un error (normalmente el código `429`).

Para que la app no quede bloqueada ni pierda lo que ya se cargó, se añadió el botón **Reintentar**:

- **Primera carga fallida:** se muestra el error en pantalla completa con el botón para volver a intentarlo.
- **Error al cargar más páginas:** la lista ya cargada se conserva y, al final, aparece el mensaje de error con su botón de **Reintentar**.
- **Error en el detalle:** se muestra el error con el botón para volver a pedir el personaje.

Si ves el error, espera unos segundos y toca **Reintentar**.

## Tecnologías

| Tecnología | Uso |
|---|---|
| [Flutter](https://flutter.dev) | Framework de la app |
| [Riverpod](https://riverpod.dev) | Manejo de estado e inyección de dependencias |
| [Dio](https://pub.dev/packages/dio) | Consumo de la API |
| [GoRouter](https://pub.dev/packages/go_router) | Navegación entre pantallas |

## Arquitectura

Clean Architecture dividida en tres capas:

```
lib/
├── core/                  # Errores (Failure), cliente Dio y router
└── features/characters/
    ├── domain/            # Entidades, contrato del repositorio y casos de uso
    ├── data/              # Modelos, data source (Dio) e implementación del repositorio
    └── presentation/      # Pantallas, widgets y providers de Riverpod
```

## Cómo ejecutarla

1. Instala las dependencias:
   ```bash
   flutter pub get
   ```
2. Ejecuta la app:
   ```bash
   flutter run
   ```
