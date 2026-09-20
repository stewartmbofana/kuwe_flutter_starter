import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{project_name.snakeCase()}}/feature/auth/bloc/auth_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = snapshot.data?.data() ?? <String, dynamic>{};
          return Padding(
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage: profile['photoUrl'] != null
                      ? NetworkImage(profile['photoUrl'] as String)
                      : null,
                  child: profile['photoUrl'] == null
                      ? const Icon(Icons.person, size: 48)
                      : null,
                ),
                const SizedBox(height: 24),
                ListTile(
                  title: const Text('Display name'),
                  subtitle: Text(profile['displayName']?.toString() ?? '—'),
                ),
                ListTile(
                  title: const Text('Email'),
                  subtitle: Text(
                    profile['email']?.toString() ?? user?.email ?? '—',
                  ),
                ),
                ListTile(
                  title: const Text('Providers'),
                  subtitle: Text(
                    (profile['providers'] as List<dynamic>?)?.join(', ') ?? '—',
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthSignOutRequested());
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Sign out'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
