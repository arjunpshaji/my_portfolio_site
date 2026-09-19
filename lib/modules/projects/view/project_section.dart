import 'package:flutter/material.dart';
import 'package:my_portfolio/support/helper.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/theme/widgets/liquid_glass.dart';
import 'package:my_portfolio/models/projects.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final colors = appColor(context)!;

    int crossAxisCount = 1;
    if (screenWidth > 800) crossAxisCount = 2;

    final projects = context.select<PortfolioProvider, List<Project>>(
      (p) => p.projects,
    );

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 40.0,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 4,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xffA855F7), Color(0xff06B6D4)],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Featured Projects",
                style: TextStyle(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.w900,
                  color: colors.primaryText,
                  fontFamily: 'Manrope',
                  letterSpacing: -0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "A showcase of applications, open-source packages, and digital creations.",
              style: TextStyle(
                fontSize: 15,
                color: colors.subText,
                fontFamily: 'Manrope',
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Projects Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              const double gap = 28.0;
              final cardWidth =
                  crossAxisCount == 1
                      ? availableWidth
                      : (availableWidth - gap) / 2;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children:
                    projects.map((project) {
                      return SizedBox(
                        width: cardWidth,
                        child: _ProjectCard(project: project),
                      );
                    }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = appColor(context)!;
    final techTags =
        widget.project.techStack
            ?.split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList() ??
        [];

    final bannerSource = _resolveBannerImage();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color:
              _isHovered
                  ? const Color(0xff181434).withValues(alpha: 0.95)
                  : const Color(0xff120F24).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color:
                _isHovered
                    ? const Color(0xffC084FC).withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.08),
            width: 1.5,
          ),
          boxShadow:
              _isHovered
                  ? [
                    BoxShadow(
                      color: const Color(0xffA855F7).withValues(alpha: 0.25),
                      blurRadius: 28,
                      offset: const Offset(0, 10),
                    ),
                  ]
                  : [],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dynamic Project Banner (Supabase Storage / Web / Asset)
            _buildBanner(bannerSource),

            // Card Body
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.project.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: colors.primaryText,
                            fontFamily: 'Manrope',
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.rocket_launch_outlined,
                        color: Color(0xffC084FC),
                        size: 22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Description
                  Text(
                    widget.project.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.subText,
                      height: 1.6,
                      fontFamily: 'Manrope',
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),

                  // Tech Stack Chips
                  if (techTags.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          techTags.map((tag) => _TechTag(label: tag)).toList(),
                    ),
                  const SizedBox(height: 24),

                  // Action Links
                  Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    children: [
                      if (widget.project.projectUrl != null)
                        LiquidGlassButton(
                          label: "View Project",
                          icon: Icons.open_in_new_rounded,
                          primaryColor: const Color(0xff8B5CF6),
                          secondaryColor: const Color(0xff06B6D4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          onTap: () => launchAppUrl(widget.project.projectUrl!),
                        ),
                      LiquidGlassButton(
                        label: "GitHub",
                        icon: Icons.code_rounded,
                        isSecondary: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        onTap:
                            () =>
                                launchAppUrl("https://github.com/arjunpshaji"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _resolveBannerImage() {
    final rawUrl = widget.project.imageUrl?.trim();
    if (rawUrl != null && rawUrl.isNotEmpty) {
      if (rawUrl.startsWith('http://') ||
          rawUrl.startsWith('https://') ||
          rawUrl.startsWith('assets/')) {
        return rawUrl;
      }
      // If it is a filename/path stored in the Supabase 'project-thumbnails' storage bucket
      try {
        return Supabase.instance.client.storage
            .from('project-thumbnails')
            .getPublicUrl(rawUrl);
      } catch (_) {
        return null;
      }
    }

    // Dynamic web thumbnail / pub.dev package detection
    final projectUrl = widget.project.projectUrl?.toLowerCase() ?? '';
    final lowerTitle = widget.project.title.toLowerCase();
    if (projectUrl.contains('pub.dev') ||
        lowerTitle.contains('simply') ||
        lowerTitle.contains('date')) {
      return 'assets/images/pub_dev_bg.png';
    }

    if (lowerTitle.contains('invoice') || lowerTitle.contains('pdf')) {
      return 'assets/images/invoice_builder_thumbnail.png';
    }

    return null;
  }

  Widget _buildBanner(String? bannerSource) {
    if (bannerSource == null) {
      return Container(
        height: 100,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff2E1065), Color(0xff0C4A6E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Icon(Icons.code_rounded, color: Colors.white24, size: 40),
        ),
      );
    }

    final isNetwork =
        bannerSource.startsWith('http://') || bannerSource.startsWith('https://');

    final Widget imageWidget;
    if (isNetwork) {
      imageWidget = Image.network(
        bannerSource,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: const Color(0xff120F24),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  value:
                      loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                  strokeWidth: 2,
                  color: const Color(0xffA855F7),
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          final lowerTitle = widget.project.title.toLowerCase();
          if (lowerTitle.contains('invoice') || lowerTitle.contains('pdf')) {
            return Image.asset(
              'assets/images/invoice_builder_thumbnail.png',
              fit: BoxFit.cover,
            );
          } else if (lowerTitle.contains('date') ||
              lowerTitle.contains('simply')) {
            return Image.asset(
              'assets/images/pub_dev_bg.png',
              fit: BoxFit.cover,
            );
          }
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff2E1065), Color(0xff0C4A6E)],
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.broken_image_rounded,
                color: Colors.white24,
                size: 36,
              ),
            ),
          );
        },
      );
    } else {
      imageWidget = Image.asset(
        bannerSource,
        fit: BoxFit.cover,
        errorBuilder:
            (context, error, stackTrace) => Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff2E1065), Color(0xff0C4A6E)],
                ),
              ),
            ),
      );
    }

    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          imageWidget,
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  const Color(0xff120F24).withValues(alpha: 0.85),
                  const Color(0xff120F24),
                ],
                stops: const [0.3, 0.8, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _TechTag extends StatelessWidget {
  final String label;
  const _TechTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xffA855F7).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xffA855F7).withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xffC084FC),
          fontFamily: 'Manrope',
        ),
      ),
    );
  }
}
