import 'package:flutter/material.dart';
import 'package:herodex/domain/entities/hero_entity.dart';

class HeroDetailPage extends StatelessWidget {
  final HeroEntity hero;

  const HeroDetailPage({super.key, required this.hero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hero.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hero.imageUrl != null)
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: Image.network(
                  hero.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
              )
            else
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.grey[300],
                child: Center(
                  child: Icon(Icons.person, size: 100, color: Colors.grey[600]),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hero.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (hero.fullName != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        hero.fullName!,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    context,
                    'Publisher',
                    hero.publisher ?? 'Unknown',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(context, 'Alignment', hero.alignment.name),
                  const SizedBox(height: 24),
                  Text('Stats', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  _buildStatBar(context, 'Strength', hero.stats.strength),
                  _buildStatBar(
                    context,
                    'Intelligence',
                    hero.stats.intelligence,
                  ),
                  _buildStatBar(context, 'Speed', hero.stats.speed),
                  _buildStatBar(context, 'Durability', hero.stats.durability),
                  _buildStatBar(context, 'Power', hero.stats.power),
                  _buildStatBar(context, 'Combat', hero.stats.combat),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Fighting Power: ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '${hero.stats.fightingPower}',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (hero.lastKnownBattleLocation != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Last Known Battle Location',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          if (hero.lastKnownBattleLocation?.description != null)
                            Text(
                              hero.lastKnownBattleLocation!.description!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(BuildContext context, String label, int value) {
    final maxValue = 100;
    final percentage = (value / maxValue).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
              Text(
                value.toString(),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: percentage, minHeight: 8),
          ),
        ],
      ),
    );
  }
}
