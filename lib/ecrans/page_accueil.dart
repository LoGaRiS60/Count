import 'package:count/models/depense.dart';
import 'package:flutter/material.dart';

class PageAccueil extends StatefulWidget {

// Liste à importer depuis main.dart
  final List<Depense> depenses; //Liste qui va acceuillir les dépenses

  const PageAccueil({super.key, required this.depenses}); //Récupération de la liste depuis main.dart

  @override
  State<PageAccueil> createState() => _PageAccueilState();
}

class _PageAccueilState extends State<PageAccueil> {

  //Controleurs de champs textuels 
  final titreController = TextEditingController();
  final montantController = TextEditingController();

  // "Get" pour calcul du total des dépenses
  double get totalDepenses {
    double total = 0;

    for (var depense in widget.depenses) {
      total += depense.montant;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(
        child: SafeArea(
            child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

// -------------- Cercle dépense principale -----------------

                SizedBox(
                  height: 200, width: 200,
                  child:Stack(
                  children: [
                    // SizedBox.expand force le cercle à prendre les 200x200 de ton SizedBox parent
                    SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: 0.6, // Remplissage à 60% (en attendant la logique des objectifs)
                        strokeWidth: 15,
                        backgroundColor: const Color.fromARGB(255, 50, 50, 50), 
                        color: const Color.fromARGB(255, 9, 2, 104), 
                      ),
                    ),
                    Center(
                      child: Text(
                        "Dépenses :\n$totalDepenses €", 
                        textAlign: TextAlign.center, // Centre le texte sur deux lignes
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ), 
                  ],
                ),
                ),
              
              const SizedBox(height: 100), // Une marge invisible pour aérer

// -------------- Rangée de plus petits cercles ----------------- 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espace les cercles joliment
                  children: [
// -------------- Cercle dépense course appart ----------------- 

                  
                    SizedBox(
                      height: 100, width: 100,
                      child: Stack(
                      children: [
                        // SizedBox.expand force le cercle à prendre les 200x200 de ton SizedBox parent
                        SizedBox.expand(
                          child: CircularProgressIndicator(
                            value: 0.6, // Remplissage à 60% (en attendant la logique des objectifs)
                            strokeWidth: 15,
                            backgroundColor: const Color.fromARGB(255, 50, 50, 50), 
                            color: const Color.fromARGB(255, 9, 2, 104), 
                          ),
                        ),
                        Center(
                          child: Text(
                            "Appart :\n$totalDepenses €", //-------------A changer avec la bonne variable ------------------
                            textAlign: TextAlign.center, // Centre le texte sur deux lignes
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ), 
                      ],
                    ),
                    ),
                    
                    // -------------- Cercle dépense loisir -----------------   
                    SizedBox(
                    height: 100, width: 100,
                    child: Stack(
                      children: [
                        // SizedBox.expand force le cercle à prendre les 200x200 de ton SizedBox parent
                        SizedBox.expand(
                          child: CircularProgressIndicator(
                            value: 0.6, // Remplissage à 60% (en attendant la logique des objectifs)
                            strokeWidth: 15,
                            backgroundColor: const Color.fromARGB(255, 50, 50, 50), 
                            color: const Color.fromARGB(255, 9, 2, 104), 
                          ),
                        ),
                        Center(
                          child: Text(
                            "Loisir :\n$totalDepenses €", //-------------A changer avec la bonne variable ------------------
                            textAlign: TextAlign.center, // Centre le texte sur deux lignes
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ), 
                      ],
                    ),
                ),
                    
                    // -------------- Cercle dépense extra -----------------   
                    SizedBox(
                      height: 100, width: 100,
                      child: Stack(
                      children: [
                        // SizedBox.expand force le cercle à prendre les 200x200 de ton SizedBox parent
                        SizedBox.expand(
                          child: CircularProgressIndicator(
                            value: 0.6, // Remplissage à 60% (en attendant la logique des objectifs)
                            strokeWidth: 15,
                            backgroundColor: const Color.fromARGB(255, 50, 50, 50), 
                            color: const Color.fromARGB(255, 9, 2, 104), 
                          ),
                        ),
                        Center(
                          child: Text(
                            "Extra :\n$totalDepenses €", //-------------A changer avec la bonne variable ------------------
                            textAlign: TextAlign.center, // Centre le texte sur deux lignes
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ), 
                      ],
                    ),
              ),
                  ],


                ),

              ],
            ),



            ),
        ),
      

      // Création du bouton d'ajout de dépense
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Fonction native de Flutter qui ouvre le panneau du bas
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              // On initialise la date à aujourd'hui au moment d'ouvrir le pop-up
              DateTime dateSelectionnee = DateTime.now();

              // StatefulBuilder permet au pop-up de se rafraîchir tout seul
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0), //marge pour aérer
                    child: Column(
                      children: [
                        const Text(
                          "Nouvelle dépense",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        
                        TextField(
                          controller: titreController,
                          decoration: InputDecoration(labelText: 'Titre de la dépense'),
                        ),
                        
                        TextField(
                          controller: montantController,
                          decoration: InputDecoration(labelText: 'Montant (€)'),
                          keyboardType: TextInputType.number,
                        ),

                        // Partie Date
                        const SizedBox(height: 20), //Marge pour aérer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Écarte les éléments
                          children: [
                            Text(
                                "Date : ${dateSelectionnee.day}/${dateSelectionnee.month}/${dateSelectionnee.year}"),

                            // Le bouton pour ouvrir le calendrier
                            TextButton(
                              // "async" indique qu'il va y avoir une attente dans cette fonction
                              onPressed: () async {
                                // "await" met le code en pause jusqu'à ce que l'utilisateur valide
                                DateTime? dateChoisie = await showDatePicker(
                                  context: context,
                                  initialDate: dateSelectionnee,
                                  firstDate: DateTime(2025), // Date minimum
                                  lastDate: DateTime(2050), // Date maximum
                                );

                                // Si l'utilisateur a choisi une date (et n'a pas annulé)
                                if (dateChoisie != null) {
                                  setModalState(() {
                                    dateSelectionnee = dateChoisie; // On met à jour l'affichage !
                                  });
                                }
                              },
                              child: const Text("Choisir une date"),
                            )
                          ],
                        ),

                        ElevatedButton(
                          onPressed: () {
        
                            double montantSaisi = double.tryParse(montantController.text) ?? 0.0; //converti le texte en décimal, "?? 0.0" donne une valeur par défault si erreur de saisi
                            final nouvelleDepense = Depense(titreController.text, montantSaisi, dateSelectionnee); //Création de l'objet avec les valeurs saisies
                            setState(() { //MàJ de l'écran
                              widget.depenses.add(nouvelleDepense); //ajout de la dépense à l'historique total
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Dépense ajoutée avec succès !")),
                              );
                            });
                            //nettoyage des controller -> On évite d'avoir le texte écrit la prochaine fois
                            titreController.clear();
                            montantController.clear();

                          },
                          child: const Text("Ajouter"),
                        )
                      ],
                    ), 
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}