import 'package:flutter/material.dart';
import 'package:prueba/pages/formulario_claves.dart';
import 'package:prueba/pages/formulario_gprs.dart';
import 'package:prueba/pages/formulario_lev_necesidad.dart';
import 'package:prueba/pages/formulario_page.dart';
import 'package:prueba/pages/formulario_zonificacion.dart';
import 'package:prueba/pages/registros_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Lista de páginas que se mostrarán según el índice seleccionado
  static List<Widget> _pages = [
    const HomeScreen(),
    const FormularioPage(), // Formulario 1
    FormularioPage2(), // Formulario 2
    FormularioPage3(), // Formulario 3
    FormularioPage4(), // Formulario 4
    FormularioPage5(), // Formulario 5
    const RegistrosPage(), // Registros
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Página actual
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.indigo, // Cambia el color de fondo aquí
        selectedItemColor: const Color.fromARGB(
            255, 204, 5, 5), // Color del ícono seleccionado
        unselectedItemColor: const Color.fromARGB(
            255, 240, 240, 241), // Color de íconos no seleccionados
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'OT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sensors),
            label: 'Zonas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_ind_outlined),
            label: 'Usuarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Necesidad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.signal_cellular_0_bar_outlined),
            label: 'GPRS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Registros',
          ),
        ],
      ),
    );
  }
}

// Pantalla de inicio
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inicio")),
      body: Center(
        child: Text("Bienvenidos.", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
