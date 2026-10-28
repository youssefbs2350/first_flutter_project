import 'package:flutter/material.dart';
import '../card.dart';

// Modèle Film
class Film {
  final String title;
  final String genre;
  final String year;
  final String duration;
  final double rating;
  final String imageUrl;
  final String synopsis;

  const Film({
    required this.title,
    required this.genre,
    required this.year,
    required this.duration,
    required this.rating,
    required this.imageUrl,
    required this.synopsis,
  });
}

class Myfilm extends StatelessWidget {
  const Myfilm({super.key});

  final List<Film> films = const [
    Film(
      title: 'Inception',
      genre: 'Science-Fiction / Action',
      year: '2010',
      duration: '2h 28min',
      rating: 8.8,
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_FMjpg_UX1000_.jpg',
      synopsis: 'Un voleur expérimenté s\'infiltre dans le subconscient des gens pour voler leurs secrets.',
    ),
    Film(
      title: 'Interstellar',
      genre: 'Aventure / Drame',
      year: '2014',
      duration: '2h 49min',
      rating: 8.7,
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BYzdjMDAxZGItMjI2My00ODA1LTlkNzItOWFjMDU5ZDJlYWY3XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      synopsis: 'Une équipe d\'explorateurs voyage à travers un trou de ver pour assurer la survie de l\'humanité.',
    ),
    Film(
      title: 'The Dark Knight',
      genre: 'Action / Crime',
      year: '2008',
      duration: '2h 32min',
      rating: 9.0,
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_FMjpg_UX1000_.jpg',
      synopsis: 'Batman s\'associe à Gordon et Dent pour contrer la menace anarchique du Joker à Gotham.',
    ),
    Film(
      title: 'Avatar : La Voie de l\'eau',
      genre: 'Action / Fantastique',
      year: '2022',
      duration: '3h 12min',
      rating: 7.6,
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BNmQxNjZlZTctMWJiMC00NGMxLWJjNTctNTFiNjA1Njk3ZDQ5XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      synopsis: 'Jake Sully et Neytiri explorent les régions côtières de Pandora face à une nouvelle menace humaine.',
    ),
    Film(
      title: 'Gladiator',
      genre: 'Action / Drame',
      year: '2000',
      duration: '2h 35min',
      rating: 8.5,
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BYWQ4YmNjYjEtOWE1Zi00Y2U4LWI4NTAtMTU0MjkxNWQ1ZmJiXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      synopsis: 'Un général romain trahi cherche vengeance contre l\'empereur corrompu qui a assassiné sa famille.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: const Text(
          "Ciné ESPRIT",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
        elevation: 2,
      ),
      // Utilisation d'un ListView.builder avec le composant FilmCard
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: films.length,
        itemBuilder: (context, index) {
          final film = films[index];
          return FilmCard(film: film);
        },
      ),
    );
  }
}
