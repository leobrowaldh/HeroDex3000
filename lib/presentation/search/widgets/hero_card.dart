import 'package:flutter/material.dart';
import 'package:herodex/domain/entities/hero_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              if (hero.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: hero.imageUrl!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    memCacheWidth: 200,
                    memCacheHeight: 200,
                    placeholder: (context, url) => Container(
                      width: 80,
                      height: 80,
                      color: Theme.of(context).colorScheme.surface,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 80,
                      height: 80,
                      color: Theme.of(context).colorScheme.surface,
                      child: Icon(
                        Icons.broken_image,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                )
              else
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),

              const SizedBox(width: 12),

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

                    const SizedBox(height: 6),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _stat(context, 'STR', hero.stats.strength),
                        _stat(context, 'SPD', hero.stats.speed),
                        _stat(context, 'POW', hero.stats.power),
                      ],
                    ),
                  ],
                ),
              ),

              IconButton(
                icon: hero.isSaved
                    ? Icon(
                        Icons.bookmark,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : Icon(
                        Icons.bookmark_outline,
                        color: Theme.of(context).iconTheme.color,
                      ),
                onPressed: onBookmark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _stat(BuildContext context, String label, int value) {
  final normalized = value.clamp(0, 100);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
      Text(value.toString(), style: const TextStyle(fontSize: 12)),
      const SizedBox(height: 2),
      Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(2),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: normalized / 100,
          child: Container(
            decoration: BoxDecoration(
              color: _statColor(context, label),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    ],
  );
}

Color _statColor(BuildContext context, String label) {
  switch (label) {
    case 'STR':
      return Theme.of(context).colorScheme.error;
    case 'SPD':
      return Theme.of(context).colorScheme.primary;
    case 'POW':
      return Theme.of(context).colorScheme.secondary;
    default:
      return Theme.of(context).disabledColor;
  }
}
