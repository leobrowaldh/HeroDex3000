import 'package:flutter/material.dart';
import 'package:herodex/domain/entities/hero_entity.dart';

class HeroCard extends StatelessWidget {
  final HeroEntity hero;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;

  const HeroCard({super.key, required this.hero, this.onTap, this.onBookmark});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // IMAGE
              if (hero.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    hero.imageUrl!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.person),
                ),

              const SizedBox(width: 12),

              // TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hero.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (hero.fullName != null)
                      Text(
                        hero.fullName!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    Text(
                      'Alignment: ${hero.alignment.name}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (hero.publisher != null)
                      Text(
                        hero.publisher!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
              ),

              // BOOKMARK BUTTON
              IconButton(
                icon: hero.isSaved
                    ? const Icon(Icons.bookmark, color: Colors.amber)
                    : const Icon(Icons.bookmark_outline),
                onPressed: onBookmark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
