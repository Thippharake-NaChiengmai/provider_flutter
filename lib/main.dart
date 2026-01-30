import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteModel(),
      child: const MyApp(),
    ),
  );
}

class FavoriteModel extends ChangeNotifier {
  final Set<int> _favorites = {};

  bool isFavorite(int index) => _favorites.contains(index);

  void toggleFavorite(int index) {
    if (_favorites.contains(index)) {
      _favorites.remove(index);
    } else {
      _favorites.add(index);
    }
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white10),
        useMaterial3: true,
      ),
      home: const FavoriteListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FavoriteListPage extends StatelessWidget {
  const FavoriteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item #$index'),
            trailing: Consumer<FavoriteModel>(
              builder: (context, favoriteModel, child) {
                final isFavorite = favoriteModel.isFavorite(index);
                return IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    favoriteModel.toggleFavorite(index);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
