import 'package:flutter/material.dart';
import 'package:herodex/services/platform_service.dart';
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
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isTablet = getIt<PlatformService>().isTablet(context);
                      final crossAxisCount = constraints.maxWidth > 1200
                          ? 4
                          : (constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1));

                      if (isTablet || constraints.maxWidth > 600) {
                        return GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: 2.0,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemCount: state.heroes.length,
                          itemBuilder: (context, index) {
                            final hero = state.heroes[index];
                            return _buildDismissibleHero(context, hero, index);
                          },
                        );
                      }

                      return ListView.builder(
                        itemCount: state.heroes.length,
                        itemBuilder: (context, index) {
                          final hero = state.heroes[index];
                          return _buildDismissibleHero(context, hero, index);
                        },
                      );
                    },
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildDismissibleHero(BuildContext context, dynamic hero, int index) {
    return Dismissible(
      key: Key(hero.localId ?? hero.externalId ?? index.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onErrorContainer,
        ),
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
        onBookmark: () {
          context.read<SavedCubit>().deleteHero(hero);
        },
      ),
    );
  }
}
