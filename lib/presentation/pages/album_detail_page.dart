import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tk_interview_task/domain/entities/album.dart';

class AlbumDetailPage extends StatelessWidget {
  final Album album;

  const AlbumDetailPage({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 380,
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'album-art-${album.id}',
                    child: CachedNetworkImage(
                      imageUrl: album.artworkUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: const Color(0xFF1C1C26),
                        child: const Center(
                          child: Icon(
                            Icons.album,
                            color: Color(0xFF6C63FF),
                            size: 60,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: const Color(0xFF1C1C26),
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Color(0xFF6C63FF),
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          theme.scaffoldBackgroundColor.withValues(alpha: 0.6),
                          theme.scaffoldBackgroundColor,
                        ],
                        stops: const [0.4, 0.8, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _GenreChip(genre: album.genre),
                        const SizedBox(height: 8),
                        Text(
                          album.name,
                          style: theme.textTheme.headlineLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          album.artistName,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: const Color(0xFF9D97FF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoGrid(album: album),
                  const SizedBox(height: 28),
                  if (album.rights.isNotEmpty) ...[
                    Text(
                      album.rights,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 11,
                        color: const Color(0xFF6B6B80),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  final String genre;

  const _GenreChip({required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF6C63FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        genre.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final Album album;

  const _InfoGrid({required this.album});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _InfoTile(
                icon: Icons.calendar_today_rounded,
                label: 'Released',
                value: album.releaseDate,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _InfoTile(
                icon: Icons.music_note_rounded,
                label: 'Tracks',
                value: album.trackCount,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _InfoTile(
                icon: Icons.attach_money_rounded,
                label: 'Price',
                value: album.price,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _InfoTile(
                icon: Icons.album_rounded,
                label: 'Genre',
                value: album.genre,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C26),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF6C63FF), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
