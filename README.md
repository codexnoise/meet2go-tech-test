#BACKEND, ARQUITECTURA PROPUESTA
Se implementó una Arquitectura de Capas (Layered Architecture) que 
separa estrictamente las responsabilidades en Rutas, Controladores, Servicios y Modelos. 
Esta estructura proporciona una base técnica 
clara, ordenada y preparada para crecer hacia un entorno productivo. Al desacoplar la lógica 
de negocio (Services) del manejo de peticiones HTTP (Controllers) y del acceso a datos 
(Models/Mocks), el código se vuelve altamente mantenible y fácil de extender por otros 
desarrolladores. Además, la inclusión de un middleware de autenticación JWT y 
la gestión de stock simulada demuestran decisiones técnicas sólidas y coherentes 
con un producto real.
