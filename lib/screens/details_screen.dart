import 'package:flutter/material.dart';
import 'mygames.dart';

class DetailsScreen extends StatefulWidget {
  final Game game;
  final VoidCallback onBuy;

  const DetailsScreen({
    super.key,
    required this.game,
    required this.onBuy,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  void _buyGame() {
    if (widget.game.quantity > 0) {
      widget.onBuy();
      setState(() {}); // Actualise l'affichage du stock
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Félicitations ! Vous avez réservé "${widget.game.title}". Il reste ${widget.game.quantity} exemplaire(s).',
          ),
          backgroundColor: Colors.cyan.shade800,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;
    final bool isAvailable = game.quantity > 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text(
          game.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.cyan,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          // La vue détaillée est entièrement encapsulée dans un widget Card
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Grande image du jeu
                SizedBox(
                  width: double.infinity,
                  height: 240,
                  child: Image.asset(
                    game.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 240,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 70, color: Colors.grey),
                    ),
                  ),
                ),

                // 2. Corps de la Card avec toutes les informations
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre du jeu et Prix
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              game.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${game.price} TND',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan.shade800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Badge de stock (Exemplaires disponibles)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isAvailable ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isAvailable ? Colors.green.shade400 : Colors.red.shade400,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isAvailable ? Icons.check_circle : Icons.cancel,
                              size: 16,
                              color: isAvailable ? Colors.green.shade800 : Colors.red.shade800,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isAvailable
                                  ? '${game.quantity} exemplaire(s) disponible(s)'
                                  : 'Rupture de stock',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isAvailable ? Colors.green.shade800 : Colors.red.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),
                      const Divider(),
                      const SizedBox(height: 12),

                      // Description
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        game.description,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 26),

                      // Bouton d'achat dans la Card
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: isAvailable ? _buyGame : null,
                          icon: const Icon(Icons.shopping_cart, color: Colors.white),
                          label: Text(
                            isAvailable ? 'Acheter maintenant' : 'Épuisé',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            disabledBackgroundColor: Colors.grey.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
