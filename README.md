# tickets_app

A full-stack Event Management application built with **Node.js (Backend)** and **Flutter (Frontend)**.

## 🏗️ Architecture Stack

### Frontend
- **Framework:** Flutter. Version: 3.38+
- **State Management:** Riverpod (Functional & Reactive approach).
- **Networking:** Dio with Interceptors.
- **Architecture:** Feature-First (Auth & Events modules).

**Arquitectura Propuesta:**
Se aplicó un enfoque **Feature-First** integrado con una **Arquitectura en Capas (Layered Architecture)**, permitiendo una estructura modular y altamente escalable. Para la gestión de estado y dependencias, se seleccionó **Riverpod**, aprovechando su seguridad en tiempo de compilación para desacoplar eficazmente la lógica de negocio de la interfaz de usuario. Esta base técnica asegura un código organizado, testable y preparado para evolucionar hacia un entorno productivo robusto.

### Backend
- **Framework:** Node.js / Express. Version: 20+
- **Architecture:** Layered Architecture (Routes -> Controllers -> Services -> Models).
- **Security:** JWT (JSON Web Tokens) for authentication.
- **Data:** Mocked in-memory storage for events and users.

**Arquitectura Propuesta:**
Se implementó una **Arquitectura de Capas (Layered Architecture)** que separa estrictamente las responsabilidades en Rutas, Controladores, Servicios y Modelos. Esta estructura proporciona una base técnica clara, ordenada y preparada para crecer hacia un entorno productivo. Al desacoplar la lógica de negocio (Services) del manejo de peticiones HTTP (Controllers) y del acceso a datos (Models/Mocks), el código se vuelve altamente mantenible y fácil de extender.

---

## 🚀 Getting Started / Instrucciones de Ejecución

### 1. Backend Setup (Node.js)
El servidor gestiona la autenticación JWT, el listado de eventos y la lógica de validación de tickets con persistencia en memoria.

1. Navega a la carpeta del servidor: `cd backend`
2. Instala las dependencias necesarias: `npm install`
3. **Configuración del entorno (.env):**
   - Como el archivo `.env` original no se sube al repositorio, crea uno nuevo en la raíz de la carpeta `backend`.
   - Puedes crear el archivo `.env` con el siguiente contenido:
     ```tex
     PORT=3000
     NODE_ENV=development
     JWT_SECRET=tu_secreto_super_seguro
     JWT_EXPIRES_IN=1d
     ```
4. Inicia el servidor en modo desarrollo: `npm run dev`

> **Nota:** El servidor corre por defecto en **http://localhost:3000**. Asegúrate de que este puerto esté disponible.

---

### 2. Frontend Setup (Flutter)
La aplicación móvil consume la API de forma reactiva y maneja el estado global con Riverpod.

1. Navega a la carpeta del proyecto Flutter: `cd frontend`
2. Descarga los paquetes necesarios: `flutter pub get`
3. **Configuración de Red (Punto Crítico):**
   Debes ajustar la URL base en el archivo `lib/core/api/api_client.dart` según tu entorno:
   - **Android Emulator:** Usa `http://10.0.2.2:3000/api`
   - **iOS Simulator:** Usa `http://localhost:3000/api`
   - **Dispositivo Físico:** Usa la IP local de tu ordenador (ej. `http://192.168.1.XX:3000/api`)

4. Ejecuta la aplicación: `flutter run`

---

### 🔑 Credenciales de Acceso
Utiliza la siguiente cuenta preconfigurada para probar el flujo de login y compra:

- **Usuario:** admin@meet2go.com
- **Contraseña:** password123