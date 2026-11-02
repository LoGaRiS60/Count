import 'package:count/models/depense.dart';
import 'package:flutter/material.dart';

class PageHistorique extends StatefulWidget {
  // Liste à importer depuis main.dart
  final List<Depense> depenses; //Liste qui va acceuillir les dépenses
  final List<String> tagsDisponibles; //Liste qui va acceuillir les tags


  const PageHistorique({super.key, required this.depenses, required this.tagsDisponibles}); //Récupération des listes depuis main.dart (ce qu'on appelle un constructeur)

  @override
  State<PageHistorique> createState() => _PageHistoriqueState();
}

class _PageHistoriqueState extends State<PageHistorique> {

  //Controleurs de champs textuels 
  final titreController = TextEditingController();
  final montantController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historique des transactions")),
      // On vérifie d'abord si la liste est vide 
      body: widget.depenses.isEmpty
          ? const Center(child: Text("Aucune dépense pour le moment."))
          : ListView.builder(
              itemCount: widget.depenses.length, // Le nombre d'éléments
              itemBuilder: (context, index) {
                // On récupère la dépense correspondante à la ligne actuelle
                final depenseActuelle = widget.depenses[index];

                // On dessine la ligne
                return Card(
                  elevation: 5, // Gère la taille de l'ombre sous la carte
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), // L'espace entre chaque carte
                  child: ListTile(
                    title: Text(depenseActuelle.titre),
                    subtitle: Text("${depenseActuelle.date.day}/${depenseActuelle.date.month}/${depenseActuelle.date.year}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min, 
                      children: [
                        Text(
                          "${depenseActuelle.montant} €",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Color.fromARGB(255, 193, 186, 252)),
                          onPressed: () {

                            titreController.text = depenseActuelle.titre;
                            montantController.text = depenseActuelle.montant.toString();

                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                // On initialise la date à aujourd'hui au moment d'ouvrir le pop-up
                                DateTime dateSelectionnee = depenseActuelle.date;

                                // StatefulBuilder permet au pop-up de se rafraîchir tout seul
                                return StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setModalState) {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0), //marge pour aérer
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Modifier la dépense",
                                            style: TextStyle(
                                                fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                          
                                          TextField(
                                            controller: titreController,
                                            decoration: const InputDecoration(labelText: 'Titre de la dépense'),
                                          ),
                                          
                                          TextField(
                                            controller: montantController,
                                            decoration: const InputDecoration(labelText: 'Montant (€)'),
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
                                              setState(() { //MàJ de l'écran
                                                widget.depenses[index].titre = titreController.text; //modification du titre de la dépense
                                                widget.depenses[index].montant = montantSaisi; //modification de la valeur de la dépense
                                                widget.depenses[index].date = dateSelectionnee;
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text("Dépense modifiée avec succès !")),
                                                );
                                              });
                                              //nettoyage des controller -> On évite d'avoir le texte écrit la prochaine fois
                                              titreController.clear();
                                              montantController.clear();

                                            },
                                            child: const Text("Modifier"),
                                          )
                                        ],
                                      ), 
                                    );
                                  },
                                );
                                }
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Color.fromARGB(255, 193, 186, 252)),
                          onPressed: () {
                            setState(() {
                              widget.depenses.removeAt(index); //enlève de la liste, et donc de l'affichage lorsqu'on appuie sur le bouton 
                            });
                          },
                        ),
                      ],
                    ),
                    ),
                  );
              },
            ),
    );
  }
}