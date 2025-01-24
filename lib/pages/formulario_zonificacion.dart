import 'dart:convert'; // Para convertir la firma a Base64
import 'package:flutter/material.dart';
import 'package:signature/signature.dart'; // Paquete para la firma manuscrita
import '../services/google_sheets_zonas.dart';

class FormularioPage2 extends StatefulWidget {
  const FormularioPage2({super.key});

  @override
  _FormularioPageState2 createState() => _FormularioPageState2();
}

class _FormularioPageState2 extends State<FormularioPage2> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mensajeController = TextEditingController();

  // Controlador para la firma manuscrita
  final SignatureController _firmaController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
  );

  // Variable para el valor seleccionado en la lista desplegable
  String? _opcionSeleccionada;

  // Lista de opciones para el DropdownButton
  final List<String> _opciones = ['zona 1', 'zona 2', 'zona 3'];

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _mensajeController.dispose();
    _firmaController.dispose();

    super.dispose();
  }

  Future<void> enviarDatos() async {
    final nombre = _nombreController.text;
    final email = _emailController.text;
    final mensaje = _mensajeController.text;

    // Convertir la firma a formato Base64
    final firmaBytes = await _firmaController.toPngBytes();
    if (firmaBytes == null || firmaBytes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, añade tu firma antes de enviar.")),
      );
      return;
    }
    final firmaBase64 = base64Encode(firmaBytes);

    // Enviar datos al servicio
    final success = await GoogleSheetsService.enviarDatos(
      nombre: nombre,
      email: email,
      mensaje: mensaje,
      firma: firmaBase64, // Incluir la firma en Base64
      opcion: _opcionSeleccionada, // Incluir la opción seleccionada
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Datos enviados correctamente")),
      );
      _nombreController.clear();
      _emailController.clear();
      _mensajeController.clear();
      _firmaController.clear(); // Limpiar la firma
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Zonificación Enviada")),
      );
      _nombreController.clear();
      _emailController.clear();
      _mensajeController.clear();
      _firmaController.clear(); // Limpiar la firma
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Zonificación")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _mensajeController,
              decoration: InputDecoration(labelText: "Mensaje"),
            ),
            SizedBox(height: 20),

            // Aquí agregamos la lista desplegable con el ancho completo
            Container(
              width: double
                  .infinity, // Hace que el DropdownButton use todo el ancho disponible
              child: DropdownButton<String>(
                value: _opcionSeleccionada,
                hint: Text("Seleccione una opción"),
                onChanged: (String? nuevaOpcion) {
                  setState(() {
                    _opcionSeleccionada = nuevaOpcion;
                  });
                },
                isExpanded:
                    true, // Hace que el DropdownButton ocupe todo el ancho
                items: _opciones.map((String opcion) {
                  return DropdownMenuItem<String>(
                    value: opcion,
                    child: Text(opcion),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 20),
            Text(
              "Firma:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[200],
              child: Signature(
                controller: _firmaController,
                backgroundColor: Colors.grey[200]!,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    _firmaController.clear();
                  },
                  child: Text("Borrar firma"),
                ),
                ElevatedButton(
                  onPressed: enviarDatos,
                  child: Text("Enviar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
