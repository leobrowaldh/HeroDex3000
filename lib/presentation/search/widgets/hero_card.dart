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
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // IMAGE
              if (hero.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: hero.imageUrl!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    memCacheWidth: 200, // Optimize memory usage
                    memCacheHeight: 200,
                    placeholder: (context, url) => Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image),
                    ),
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

                    const SizedBox(height: 6),

                    // BASIC STATS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _stat('STR', hero.stats.strength),
                        _stat('SPD', hero.stats.speed),
                        _stat('POW', hero.stats.power),
                      ],
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

Widget _stat(String label, int value) {
  // Clamp value between 0–100 just in case
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

      // Indicator bar
      Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(2),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: normalized / 100,
          child: Container(
            decoration: BoxDecoration(
              color: _statColor(label),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    ],
  );
}

Color _statColor(String label) {
  switch (label) {
    case 'STR':
      return Colors.redAccent; // strength
    case 'SPD':
      return Colors.blueAccent; // speed
    case 'POW':
      return Colors.amberAccent; // power
    default:
      return Colors.grey;
  }
}
