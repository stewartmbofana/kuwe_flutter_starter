import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{project_name.snakeCase()}}/feature/auth/bloc/auth_bloc.dart';
import 'package:{{project_name.snakeCase()}}/feature/profile/view/profile_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const ProfileView()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () =>
                context.read<AuthBloc>().add(const AuthSignOutRequested()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, ${user?.displayName ?? user?.email ?? 'there'}'),
            const SizedBox(height: 12),
            const Text(
              'This starter app is ready for Firebase login, Firestore user storage, and notifications.',
            ),
            const SizedBox(height: 24),
            const Card(
              child: ListTile(
                title: Text('Firebase auth'),
                subtitle: Text(
                  'Google, Facebook, Twitter, Apple, Microsoft, and GitHub are wired in.',
                ),
              ),
            ),
            const Card(
              child: ListTile(
                title: Text('Firestore users'),
                subtitle: Text(
                  'User profiles are stored in the users collection.',
                ),
              ),
            ),
            const Card(
              child: ListTile(
                title: Text('Notifications'),
                subtitle: Text(
                  'Firebase Messaging and OneSignal initialization are included.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
