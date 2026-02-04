import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/presentation/search/cubit/search_cubit.dart';
import 'package:herodex/presentation/search/cubit/search_state.dart';
import 'package:herodex/presentation/search/widgets/hero_card.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Heroes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _searchController,
              builder: (context, value, _) {
                return TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search heroes...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: value.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              context.read<SearchCubit>().reset();
                            },
                          )
                        : null,
                  ),
                  onChanged: (text) {
                    context.read<SearchCubit>().search(text);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return const Center(
                    child: Text('Search for a hero to get started'),
                  );
                }

                if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is SearchSuccess) {
                  return ListView.builder(
                    cacheExtent: 1000,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.heroes.length,
                    itemBuilder: (context, index) {
                      final hero = state.heroes[index];

                      return HeroCard(
                        hero: hero,
                        onTap: () {
                          context.push('/details', extra: hero);
                        },
                        onBookmark: () {
                          context.read<SearchCubit>().toggleSave(hero);
                        },
                      );
                    },
                  );
                }

                if (state is SearchEmpty) {
                  return const Center(child: Text('No heroes found'));
                }

                if (state is SearchError) {
                  return Center(child: Text('Error: ${state.message}'));
                }

                return const Center(child: Text('Unknown state'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
