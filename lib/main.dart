import 'package:count/ecrans/page_accueil.dart';
import 'package:count/ecrans/page_historique.dart'; 
import 'package:count/ecrans/page_objectifs.dart';
import 'package:count/ecrans/page_parametres.dart';
import 'package:count/models/depense.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Count',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light, 
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white, 
          brightness: Brightness.dark,  
        ),
      ),
      themeMode: ThemeMode.system, 
      home: const EcranPrincipal(),
    );
  }
}

// Ecran principal
class EcranPrincipal extends StatefulWidget {
  const EcranPrincipal({super.key});

  @override
  State<EcranPrincipal> createState() => _EcranPrincipalState();
}

class _EcranPrincipalState extends State<EcranPrincipal> {
  int indexActuel = 0; 

  List<Depense> historiqueDepenses = [];
  
  List<String> tagsDisponibles = ['Appart', 'Loisir', 'Extra'];

  @override
  Widget build(BuildContext context) {
    
    List<Widget> mesEcrans = [  
      PageAccueil(depenses: historiqueDepenses), 
      PageHistorique(depenses: historiqueDepenses, tagsDisponibles: tagsDisponibles,), 
      const PageObjectifs(),
      const PageParametres(),
    ];

    return Scaffold(
      body: mesEcrans[indexActuel], 
      
      bottomNavigationBar: BottomNavigationBar(   
        currentIndex: indexActuel, 
        selectedItemColor: Colors.tealAccent, 
        unselectedItemColor: Colors.grey,     
        
        onTap: (int nouvelIndex) {
          setState(() {
            indexActuel = nouvelIndex;  
          }); 
        },

        items: const [    
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Objectifs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres'
          )
        ],
      ),
    );
  }
}