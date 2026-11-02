📊 Count - Gestionnaire de Finances Personnelles
Count est une application mobile et web développée avec Flutter permettant de suivre, catégoriser et gérer ses dépenses quotidiennes de manière simple, moderne et visuelle.

✨ Fonctionnalités actuelles
🎨 Tableau de bord visuel (Accueil)
Jauges circulaires interactives : Visualisation globale des dépenses mensuelles grâce à un composant central (CircularProgressIndicator dans un Stack).

Répartition par catégories : Aperçu sous forme de sous-jauges pour les postes de dépenses principaux (Appartement, Loisirs, Extras).

📜 Historique & Gestion des Transactions (CRUD)
Création : Ajout de dépenses via une fenêtre modale (showModalBottomSheet) avec sélecteur de date natif (showDatePicker).

Lecture : Affichage optimisé en liste dynamique (ListView.builder) sous forme de cartes (Card / ListTile).

Mise à jour : Modification rapide des dépenses existantes avec pré-remplissage automatique des formulaires.

Suppression : Suppression instantanée des cartes.

🌗 Interface & Thème
Thème adaptatif : Support automatique du mode clair et sombre selon les réglages du téléphone (ThemeMode.system).

Navigation fluide : Navigation par onglets via BottomNavigationBar.

🚀 Prochaines évolutions (Roadmap)
[ ] Gestion des Tags : Catégorisation personnalisée des dépenses à l'aide de widgets InputChip.

[ ] Objectifs budgétaires : Définition de plafonds mensuels connectés directement aux jauges d'accueil.

[ ] Persistance des données : Sauvegarde en base de données locale ou en ligne.

[ ] Graphiques analytiques : Statistiques mensuelles et annuelles.

🛠️ Stack Technique
Framework : Flutter (Dart)

Architecture d'état : Remontée d'état (State Lifting) vers main.dart

UI/UX : Material Design 3

📂 Structure du projet
Plaintext
lib/
├── ecrans/
│   ├── page_accueil.dart      # Tableau de bord principal (jauges)
│   ├── page_historique.dart   # Liste des transactions et formulaires CRUD
│   ├── page_objectifs.dart   # Suivi des objectifs de budget
│   └── page_parametres.dart  # Réglages de l'application
├── models/
│   └── depense.dart           # Modèle de données Depense
└── main.dart                  # Point d'entrée, thèmes et état global
⚙️ Installation et Lancement
Cloner le dépôt :

Bash
git clone https://github.com/LoGaRiS60/count.git
cd count
Récupérer les dépendances :

Bash
flutter pub get
Lancer l'application :

Bash
flutter run