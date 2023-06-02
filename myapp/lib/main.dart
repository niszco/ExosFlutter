// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() => runApp(
      MyApp(),
    );

class PageName {
  static const String home = '/';
  static const String detail = '/detail_page';
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final TextEditingController controller;
  late final List<int> deletedIndexes;

  @override
  void initState() {
    controller = TextEditingController();
    deletedIndexes = [];
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final pokedex = <Pokemon>[
    // <== liste finale, contenu constant
    Pokemon(name: 'Artikodin', icon: Icons.ac_unit),
    Pokemon(name: 'Sulfura', icon: Icons.fireplace),
    Pokemon(name: 'Elektor', icon: Icons.thunderstorm),
    Pokemon(name: 'Mewtwo', icon: Icons.remove_red_eye),
  ];

  void showMessageError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  void addPokemon() {
    final nameToAdd = controller.text.trim();

    if (nameToAdd.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vous de vez écrire au moins 3 lettres !')));
      return;
    }

    final lowercaseNameToAdd = nameToAdd.toLowerCase();
    final trimmedNameToAdd = lowercaseNameToAdd.trim();

    for (final pokemon in pokedex) {
      final lowercasePokemonName = pokemon.name.toLowerCase();
      final trimmedPokemonName = lowercasePokemonName.trim();

      if (trimmedPokemonName == trimmedNameToAdd) {
        return showMessageError('Le Pokémon existe déjà dans la liste !');
      }
    }

    setState(() {
      pokedex.insert(0, Pokemon(icon: Icons.architecture, name: nameToAdd));
      if (nameToAdd.isEmpty || nameToAdd.trim().isEmpty) {
        showMessageError('Le nom ne peut pas être vide !');
        return;
      }
    });
  }

  void removePokemon(int index) {
    setState(() {
      deletedIndexes.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          // <== définit le thème Light
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          // <== définit le thème Dark
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        home: ScaffoldMessenger(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Première appli'),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                labelText: 'Ecrivez un nom',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => addPokemon(),
                          ),
                        ),
                      ],
                    ),
                    for (int i = 0; i < pokedex.length; i++)
                      if (!deletedIndexes.contains(i))
                        TheAmazingRow(
                          icon: pokedex[i].icon,
                          label: pokedex[i].name,
                          onDelete: () => removePokemon(i),
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
        initialRoute: PageName.home,
        routes: {
          PageName.detail: (context) => const DetailPage(),
        });
  }
}

class Pokemon {
  final String name;
  final IconData icon;

  Pokemon({required this.icon, required this.name});
}

class TheAmazingRow extends StatefulWidget {
  const TheAmazingRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.onDelete,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback onDelete;

  @override
  State<TheAmazingRow> createState() => _TheAmazingRowState();
}

class _TheAmazingRowState extends State<TheAmazingRow> {
  @override
  Widget build(BuildContext context) {
    final label = widget.label;
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        PageName.detail,
        arguments: label,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              Icon(widget.icon),
              const SizedBox(width: 16),
              Expanded(
                child: Text(widget.label),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: widget.onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page détail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nom du Pokémon : $pokemonName',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}
