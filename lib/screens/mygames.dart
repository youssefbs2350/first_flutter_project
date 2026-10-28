import 'package:flutter/material.dart';
import '../card.dart';
import '../services/auth_service.dart';
import 'cart_screen.dart';
import 'login_screen.dart';

// Modèle Jeu
class Game {
  final String title;
  final String image;
  final int price;
  final String description;
  int quantity;

  Game({
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    this.quantity = 5,
  });
}

class MyGames extends StatefulWidget {
  const MyGames({super.key});

  @override
  State<MyGames> createState() => _MyGamesState();
}

class _MyGamesState extends State<MyGames> {
  // Liste des articles réservés dans le chariot / panier
  final List<CartItem> _cartItems = [];

  // Liste des jeux en magasin
  final List<Game> _gamesList = [
    Game(
      title: 'Devil May Cry 5',
      image: 'assets/images/dmc5.jpg',
      price: 200,
      quantity: 4,
      description: 'Jeu d\'action et de combat effréné signé Capcom avec Dante et Nero.',
    ),
    Game(
      title: 'FIFA 23',
      image: 'assets/images/fifa.jpg',
      price: 220,
      quantity: 5,
      description: 'Le célèbre jeu de simulation de football avec toutes les équipes et modes officiels.',
    ),
    Game(
      title: 'Minecraft',
      image: 'assets/images/minecraft.jpg',
      price: 90,
      quantity: 8,
      description: 'Construisez, explorez et survivez dans un monde infini fait de blocs.',
    ),
    Game(
      title: 'Need For Speed',
      image: 'assets/images/nfs.jpg',
      price: 150,
      quantity: 2,
      description: 'Faites la course jour et nuit dans des défis urbains intenses à toute vitesse.',
    ),
    Game(
      title: 'Red Dead Redemption 2',
      image: 'assets/images/rdr2.jpg',
      price: 250,
      quantity: 3,
      description: 'Chef-d\'œuvre en monde ouvert de Rockstar Games au cœur du Far West américain.',
    ),
    Game(
      title: 'Resident Evil Village',
      image: 'assets/images/re8.jpg',
      price: 180,
      quantity: 1,
      description: 'Survivez aux horreurs d\'un mystérieux village d\'Europe de l\'Est dans ce survival horror.',
    ),
  ];

  late Future<List<Game>> _gamesFuture;

  @override
  void initState() {
    super.initState();
    _gamesFuture = _loadGamesDynamically();
  }

  Future<List<Game>> _loadGamesDynamically() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _gamesList;
  }

  Future<void> _refreshGames() async {
    setState(() {
      _gamesFuture = _loadGamesDynamically();
    });
  }

  // Acheter / réserver un jeu et l'ajouter au panier
  void _buyGame(Game game) {
    if (game.quantity > 0) {
      setState(() {
        game.quantity--;

        // Vérifier si le jeu est déjà dans le panier
        final existingIndex = _cartItems.indexWhere((item) => item.game.title == game.title);
        if (existingIndex != -1) {
          _cartItems[existingIndex].quantity++;
        } else {
          _cartItems.add(CartItem(game: game, quantity: 1));
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${game.title}" ajouté au chariot ! (Reste: ${game.quantity})'),
          backgroundColor: Colors.cyan.shade800,
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'VOIR CHARIOT',
            textColor: Colors.amber,
            onPressed: _openCartScreen,
          ),
        ),
      );
    }
  }

  // Supprimer un article du panier et restituer le stock
  void _removeFromCart(CartItem item) {
    setState(() {
      item.game.quantity += item.quantity;
      _cartItems.remove(item);
    });
  }

  // Vider tout le panier et restituer tous les stocks
  void _clearCart() {
    setState(() {
      for (final item in _cartItems) {
        item.game.quantity += item.quantity;
      }
      _cartItems.clear();
    });
  }

  // Ouvrir l'écran du Panier / Chariot
  void _openCartScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          cartItems: _cartItems,
          onRemove: _removeFromCart,
          onClear: _clearCart,
        ),
      ),
    ).then((_) {
      // Met à jour l'écran au retour pour actualiser les stocks si des suppressions ont eu lieu
      setState(() {});
    });
  }

  // Nombre total d'articles dans le panier
  int get _totalCartCount {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text(
          'G-Store ESPRIT',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Recharger',
            onPressed: _refreshGames,
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Déconnexion',
            onPressed: () {
              AuthService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
          // Icône du chariot avec badge du nombre d'articles réservés
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                tooltip: 'Mon Chariot',
                onPressed: _openCartScreen,
              ),
              if (_totalCartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '$_totalCartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: FutureBuilder<List<Game>>(
        future: _gamesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.cyan, strokeWidth: 3),
                  SizedBox(height: 16),
                  Text(
                    'Chargement des jeux...',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 50, color: Colors.red),
                  const SizedBox(height: 10),
                  Text('Erreur : ${snapshot.error}'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _refreshGames,
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          final games = snapshot.data ?? [];

          return RefreshIndicator(
            color: Colors.cyan,
            onRefresh: _refreshGames,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return GameCard(
                  game: game,
                  onBuy: () => _buyGame(game),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
