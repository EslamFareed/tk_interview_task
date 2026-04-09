import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tk_interview_task/presentation/bloc/albums_bloc.dart';
import 'package:tk_interview_task/presentation/pages/album_detail_page.dart';
import 'package:tk_interview_task/presentation/widgets/album_card.dart';
import 'package:tk_interview_task/presentation/widgets/error_view.dart';

class AlbumsListPage extends StatefulWidget {
  const AlbumsListPage({super.key});

  @override
  State<AlbumsListPage> createState() => _AlbumsListPageState();
}

class _AlbumsListPageState extends State<AlbumsListPage> {
  @override
  void initState() {
    super.initState();
    context.read<AlbumsBloc>().add(const FetchAlbums());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Top Albums',
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'iTunes Top 100',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<AlbumsBloc, AlbumsState>(
                builder: (context, state) {
                  if (state is AlbumsLoading || state is AlbumsInitial) {
                    return const _LoadingGrid();
                  }

                  if (state is AlbumsError) {
                    return ErrorView(
                      message: state.message,
                      onRetry: () => context
                          .read<AlbumsBloc>()
                          .add(const FetchAlbums()),
                    );
                  }

                  if (state is AlbumsLoaded) {
                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.62,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: state.albums.length,
                      itemBuilder: (context, index) {
                        final album = state.albums[index];
                        return _AnimatedCard(
                          index: index,
                          child: AlbumCard(
                            album: album,
                            index: index,
                            onTap: () => Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (_, animation, __) =>
                                    AlbumDetailPage(album: album),
                                transitionsBuilder:
                                    (_, animation, __, child) =>
                                        FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                                transitionDuration:
                                    const Duration(milliseconds: 300),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedCard extends StatefulWidget {
  final int index;
  final Widget child;

  const _AnimatedCard({required this.index, required this.child});

  @override
  State<_AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<_AnimatedCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    final delay = (widget.index * 40).clamp(0, 600);
    Future.delayed(Duration(milliseconds: delay), () {
      if (mounted) _controller.forward();
    });

    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

class _LoadingGrid extends StatelessWidget {
  const _LoadingGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.62,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 12,
      itemBuilder: (_, index) => const _ShimmerCard(),
    );
  }
}

class _ShimmerCard extends StatefulWidget {
  const _ShimmerCard();

  @override
  State<_ShimmerCard> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<_ShimmerCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        final shimmer = Color.lerp(
          const Color(0xFF1C1C26),
          const Color(0xFF2A2A38),
          _animation.value,
        )!;
        return Container(
          decoration: BoxDecoration(
            color: shimmer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: shimmer,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A38),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 10,
                      width: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A38),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
