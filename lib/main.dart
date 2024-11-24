import 'package:flutter/material.dart';

void main() {
  runApp(const NFPAApp());
}

class NFPAApp extends StatelessWidget {
  const NFPAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rombo NFPA 704',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const NFPAHomePage(),
    );
  }
}

class NFPAHomePage extends StatelessWidget {
  const NFPAHomePage({super.key});

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Path _createDiamondPath(double size) {
    return Path()
      ..moveTo(size / 2, 0) // Punto superior
      ..lineTo(size, size / 2) // Punto derecho
      ..lineTo(size / 2, size) // Punto inferior
      ..lineTo(0, size / 2) // Punto izquierdo
      ..close(); // Cerrar el camino
  }

  @override
  Widget build(BuildContext context) {
    double diamondSize = 150;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rombo NFPA 704'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: diamondSize * 2,
              height: diamondSize * 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Rombo azul (izquierda)
                  Positioned(
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        _showDialog(context, "Riesgo a la Salud", '''
0 = Sin riesgo alguno
1 = Ligeramente peligroso
2 = Peligroso
3 = Extremadamente peligroso
4 = Mortal
''');
                      },
                      child: ClipPath(
                        clipper: DiamondClipper(),
                        child: Container(
                          width: diamondSize,
                          height: diamondSize,
                          color: Colors.blue,
                          alignment: Alignment.center,
                          child: const Text(
                            'Riesgo para\nla salud',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Rombo rojo (arriba)
                  Positioned(
                    top: 0,
                    child: GestureDetector(
                      onTap: () {
                        _showDialog(context, "Inflamabilidad", '''
0 = No arde
1 = Arde a los 93° Celsius
2 = Entra en ignición debajo de los 93° Celsius
3 = Entra en ignición debajo de los 37° Celsius
4 = Entra en ignición debajo de los 25° Celsius
''');
                      },
                      child: ClipPath(
                        clipper: DiamondClipper(),
                        child: Container(
                          width: diamondSize,
                          height: diamondSize,
                          color: Colors.red,
                          alignment: Alignment.center,
                          child: const Text(
                            'Peligro de\ninflamabilidad',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Rombo amarillo (derecha)
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        _showDialog(context, "Reactividad", '''
0 = Estable
1 = Inestable si se calienta
2 = Posibilidad de cambio
3 = Puede detonar con golpe o calentamiento
4 = Detona con facilidad
''');
                      },
                      child: ClipPath(
                        clipper: DiamondClipper(),
                        child: Container(
                          width: diamondSize,
                          height: diamondSize,
                          color: Colors.yellow,
                          alignment: Alignment.center,
                          child: const Text(
                            'Riesgo por\nreactividad',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Rombo blanco (abajo)
                  Positioned(
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        _showDialog(context, "Riesgo Específico", '''
R: Materiales radioactivos
COR: Materiales corrosivos
BIO: Riesgo biológico
CRYO: Material criogénico
Xn: Nocivo, riesgos epidemiológicos
ALC: Materiales alcalinos
W: Reacciona con agua
OX: Materiales oxidantes
ACID: Sustancias ácidas
''');
                      },
                      child: ClipPath(
                        clipper: DiamondClipper(),
                        child: Container(
                          width: diamondSize,
                          height: diamondSize,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: const Text(
                            'Riesgo\nespecífico',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showDialog(context, "Información Adicional",
                  "Este es el rombo NFPA 704, un sistema para identificar riesgos.");
            },
            child: const Text("Ver Peligro"),
          ),
        ],
      ),
    );
  }
}

class DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width / 2, 0) // Punto superior
      ..lineTo(size.width, size.height / 2) // Punto derecho
      ..lineTo(size.width / 2, size.height) // Punto inferior
      ..lineTo(0, size.height / 2) // Punto izquierdo
      ..close(); // Cerrar el camino
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
