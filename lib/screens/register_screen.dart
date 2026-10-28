import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fonction de soumission et de validation du formulaire
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final nom = _nomController.text.trim();
      final prenom = _prenomController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      final newUser = UserModel(
        nom: nom,
        prenom: prenom,
        email: email,
        password: password,
      );

      // Enregistrer l'utilisateur
      final success = AuthService.register(newUser);

      if (!success) {
        Fluttertoast.showToast(
          msg: "Un compte avec cette adresse email existe déjà !",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        return;
      }

      // Message complet contenant les données saisies
      final toastMessage =
          "Inscription réussie !\nNom : $nom\nPrénom : $prenom\nEmail : $email";

      // 1. Affichage dans un Toast via Fluttertoast
      Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.cyan.shade900,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      // 2. Affichage également dans une SnackBar flottante pour garantir la visibilité sur Web
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(toastMessage),
          backgroundColor: Colors.cyan.shade800,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      // Redirection vers l'écran de connexion avec l'email prérempli
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(prefilledEmail: email),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: const Text(
          "Inscription - G-Store",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // En-tête avec icône
                    Icon(
                      Icons.person_add_alt_1,
                      size: 60,
                      color: Colors.cyan.shade700,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Créer un nouveau compte",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Remplissez les informations ci-dessous",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                    const SizedBox(height: 24),

                    // Champ Nom
                    TextFormField(
                      controller: _nomController,
                      decoration: InputDecoration(
                        labelText: "Nom",
                        hintText: "Ex : Ben Salah",
                        prefixIcon: const Icon(Icons.person_outline, color: Colors.cyan),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.cyan, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Le nom est obligatoire";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Champ Prénom
                    TextFormField(
                      controller: _prenomController,
                      decoration: InputDecoration(
                        labelText: "Prénom",
                        hintText: "Ex : Youssef",
                        prefixIcon: const Icon(Icons.person_outline, color: Colors.cyan),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.cyan, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Le prénom est obligatoire";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Champ Email avec contrôle de saisie (@)
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Adresse Email",
                        hintText: "exemple@esprit.tn",
                        prefixIcon: const Icon(Icons.email_outlined, color: Colors.cyan),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.cyan, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "L'adresse email est obligatoire";
                        }
                        // Contrôle de saisie : doit contenir un '@' et un format valide
                        if (!value.contains('@')) {
                          return "L'adresse email doit obligatoirement contenir '@'";
                        }
                        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value.trim())) {
                          return "Veuillez entrer une adresse email valide";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Champ Mot de passe avec contrôles stricts
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: "Mot de passe",
                        hintText: "Min 8 carac, 1 maj, 1 min, 1 chiffre, 1 spécial",
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.cyan),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.cyan, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Le mot de passe est obligatoire";
                        }
                        if (value.length < 8) {
                          return "Le mot de passe doit contenir au moins 8 caractères";
                        }
                        if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return "Le mot de passe doit contenir au moins 1 majuscule";
                        }
                        if (!RegExp(r'[a-z]').hasMatch(value)) {
                          return "Le mot de passe doit contenir au moins 1 minuscule";
                        }
                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return "Le mot de passe doit contenir au moins 1 chiffre";
                        }
                        // Caractère spécial
                        if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]').hasMatch(value)) {
                          return "Au moins 1 caractère spécial requis (@, #, \$, !, %, etc.)";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),

                    // Rappel des règles du mot de passe
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Le mot de passe doit contenir :",
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "• Au moins 8 caractères\n• Au moins 1 majuscule & 1 minuscule\n• Au moins 1 chiffre (0-9)\n• Au moins 1 caractère spécial (!@#\$%...)",
                            style: TextStyle(fontSize: 11, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Bouton S'inscrire
                    SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _submitForm,
                        icon: const Icon(Icons.check, color: Colors.white),
                        label: const Text(
                          "S'inscrire",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Lien vers la Connexion
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Vous avez déjà un compte ? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text(
                            "Se connecter",
                            style: TextStyle(
                              color: Colors.cyan,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
