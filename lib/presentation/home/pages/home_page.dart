import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/presentation/home/cubit/home_cubit.dart';
import 'package:herodex/presentation/home/widgets/hero_count_card.dart';
import 'package:herodex/presentation/home/widgets/stats_card.dart';
import 'package:herodex/injection.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(getIt())..load(),
      child: Scaffold(
        appBar: AppBar(title: const Text('HeroDex 3000')),
        drawer: _buildDrawer(context),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeError) {
              return Center(child: Text(state.message));
            }

            if (state is HomeLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // --- STATISTICS CARDS ---
                    Row(
                      children: [
                        Expanded(
                          child: HeroCountCard(
                            title: 'Heroes',
                            count: state.heroCount,
                            icon: Icons.shield,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: HeroCountCard(
                            title: 'Villains',
                            count: state.villainCount,
                            icon: Icons.warning_amber_rounded,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    StatsCard(
                      title: 'Total Fighting Power',
                      value: state.totalPower.toString(),
                      icon: Icons.bolt,
                      accentColor: Theme.of(context).colorScheme.secondary,
                    ),

                    const SizedBox(height: 32),

                    // --- INVASION STATUS ---
                    Row(
                      children: [
                        Icon(Icons.public, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        const SizedBox(width: 8),
                        Text(
                          'Latest War Updates',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    ...state.warUpdates.map((update) {
                       return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainerHighest,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(update.icon, color: Theme.of(context).colorScheme.onSurfaceVariant),
                          ),
                          title: Text(
                            update.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(update.description),
                        ),
                      );
                    }),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: const Text('HeroDex Menu', style: TextStyle(fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              context.go('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search Heroes'),
            onTap: () {
              Navigator.pop(context);
              context.go('/search');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Heroes / Villains'),
            onTap: () {
              Navigator.pop(context);
              context.go('/saved');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              context.go('/settings');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              Navigator.pop(context);
              context.go('/auth');
            },
          ),
        ],
      ),
    );
  }
}
