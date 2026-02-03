import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herodex/injection.dart';
import 'package:herodex/presentation/saved/cubit/saved_cubit.dart';
import 'package:herodex/presentation/saved/cubit/saved_state.dart';
import 'package:herodex/presentation/search/widgets/hero_card.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SavedCubit>()..loadSavedHeroes(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Heroes / Villains')),
        body: BlocBuilder<SavedCubit, SavedState>(
          builder: (context, state) {
            if (state is SavedLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SavedError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is SavedLoaded) {
              if (state.heroes.isEmpty) {
                return const Center(child: Text('No saved heroes yet.'));
              }
              return ListView.builder(
                itemCount: state.heroes.length,
                itemBuilder: (context, index) {
                  final hero = state.heroes[index];
                  return Dismissible(
                    key: Key(
                      hero.localId ?? hero.externalId ?? index.toString(),
                    ),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) {
                      context.read<SavedCubit>().deleteHero(hero);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${hero.name} deleted')),
                      );
                    },
                    child: HeroCard(
                      hero: hero,
                      onTap: () {
                        context.push('/details', extra: hero);
                      },
                      // Hide bookmark button in saved view or make it readonly?
                      // Requirement says "Swipe to remove", so maybe button is redundant but keeps UI consistent.
                      // Let's pass empty onBookmark or handle it.
                      onBookmark: () {
                        context.read<SavedCubit>().deleteHero(hero);
                      },
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
