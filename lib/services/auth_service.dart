// Modèle Utilisateur
class UserModel {
  final String nom;
  final String prenom;
  final String email;
  final String password;

  UserModel({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
  });
}

// Service d'authentification pour stocker et gérer les utilisateurs enregistrés
class AuthService {
  // Liste des utilisateurs enregistrés (avec un compte de test par défaut)
  static final List<UserModel> registeredUsers = [
    UserModel(
      nom: 'Ben Salah',
      prenom: 'Youssef',
      email: 'youssef@esprit.tn',
      password: 'Password1!',
    ),
  ];

  // Utilisateur actuellement connecté
  static UserModel? currentUser;

  // Enregistrer un nouvel utilisateur
  static bool register(UserModel user) {
    final alreadyExists = registeredUsers.any(
      (u) => u.email.trim().toLowerCase() == user.email.trim().toLowerCase(),
    );
    if (alreadyExists) {
      return false;
    }
    registeredUsers.add(user);
    return true;
  }

  // Connexion de l'utilisateur
  static UserModel? login(String email, String password) {
    try {
      final user = registeredUsers.firstWhere(
        (u) =>
            u.email.trim().toLowerCase() == email.trim().toLowerCase() &&
            u.password == password,
      );
      currentUser = user;
      return user;
    } catch (_) {
      return null;
    }
  }

  // Déconnexion
  static void logout() {
    currentUser = null;
  }
}
