import 'package:flutter/material.dart';
import '../entite/film.dart';

class CellGridFilm extends StatelessWidget {
  final Film film;

  const CellGridFilm(this.film, {super.key});

  @override
  Widget build(BuildContext context) {
    // Adapter le chemin de l'image pour pointer vers assets/images/
    final String imagePath = film.nomimg.startsWith('assets/')
        ? film.nomimg
        : "assets/images/${film.nomimg}";

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Afficher les détails du jeu / film au clic
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(film.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(imagePath, height: 140, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 10),
                  Text("${film.prix} TND",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.cyan)),
                  const SizedBox(height: 8),
                  Text(film.description, style: const TextStyle(fontSize: 13)),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Fermer"),
                ),
              ],
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 90,
                    height: 90,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, size: 30),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                film.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(height: 2),
              Text(
                "${film.prix} TND",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
