import 'package:flutter/material.dart';
import '../services/google_sheets_ot.dart';

class RegistrosPage extends StatefulWidget {
  const RegistrosPage({super.key});

  @override
  _RegistrosPageState createState() => _RegistrosPageState();
}

class _RegistrosPageState extends State<RegistrosPage> {
  List registros = [];

  Future<void> cargarRegistros() async {
    final data = await GoogleSheetsService.obtenerRegistros();
    if (data != null) {
      setState(() {
        registros = data;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar los registros")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    cargarRegistros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registros")),
      body: registros.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: registros.length,
              itemBuilder: (context, index) {
                final registro = registros[index];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nombre: ${registro['nombre']}"),
                        Text("Email: ${registro['email']}"),
                        Text("Mensaje: ${registro['mensaje']}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
