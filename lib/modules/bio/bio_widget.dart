import 'package:flutter/material.dart';
import 'package:my_portfolio/support/helper.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/theme/widgets/liquid_glass.dart';
import 'package:my_portfolio/models/metric.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';

class BioWidget extends StatelessWidget {
  const BioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final colors = appColor(context)!;

    final about = context.select<PortfolioProvider, String>(
      (p) =>
          p.profile?.about ??
          "Passionate Software Developer with extensive experience in building robust, responsive, and performant cross-platform mobile and web applications. Expert in Clean Architecture, reactive state management (Riverpod/BLoC), high-performance UI rendering, and IoT integrations.",
    );
    final cvUrl = context.select<PortfolioProvider, String?>(
      (p) => p.profile?.cvUrl,
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
          // Metrics Strip
          _MetricsStrip(isMobile: isMobile),
          const SizedBox(height: 60),

          // Section Header
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
                "About Me",
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
          const SizedBox(height: 28),

          // Main Split Content
          if (isMobile)
            Column(
              children: [
                _AboutStoryCard(about: about, cvUrl: cvUrl),
                const SizedBox(height: 24),
                const _FocusAreasList(),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: _AboutStoryCard(about: about, cvUrl: cvUrl),
                ),
                const SizedBox(width: 32),
                const Expanded(
                  flex: 5,
                  child: _FocusAreasList(),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _MetricsStrip extends StatelessWidget {
  final bool isMobile;
  const _MetricsStrip({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final metrics = context.select<PortfolioProvider, List<Metric>>(
      (p) => p.metrics,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        runAlignment: WrapAlignment.center,
        spacing: 24,
        runSpacing: 20,
        children: metrics.map((m) {
          return _MetricItem(value: m.value, label: m.label);
        }).toList(),
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String value;
  final String label;

  const _MetricItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xffC084FC), Color(0xff38BDF8)],
          ).createShader(bounds),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontFamily: 'Manrope',
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xff94A3B8),
            fontFamily: 'Manrope',
          ),
        ),
      ],
    );
  }
}

class _AboutStoryCard extends StatelessWidget {
  final String about;
  final String? cvUrl;

  const _AboutStoryCard({required this.about, this.cvUrl});

  @override
  Widget build(BuildContext context) {
    final colors = appColor(context)!;
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xff120F24).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Building the future of mobile experiences.",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colors.primaryText,
              fontFamily: 'Manrope',
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            about,
            style: TextStyle(
              fontSize: 15,
              height: 1.7,
              color: colors.subText,
              fontFamily: 'Manrope',
            ),
          ),
          const SizedBox(height: 24),
          if (cvUrl != null && cvUrl!.isNotEmpty)
            LiquidGlassButton(
              label: "View Curriculum Vitae",
              icon: Icons.description_outlined,
              primaryColor: const Color(0xff8B5CF6),
              secondaryColor: const Color(0xff06B6D4),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
              onTap: () => launchAppUrl(cvUrl!),
            ),
        ],
      ),
    );
  }
}

class _FocusAreasList extends StatelessWidget {
  const _FocusAreasList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _FocusCard(
          icon: Icons.phone_android_rounded,
          title: "Cross-Platform Engineering",
          description:
              "High-performance native iOS, Android, and Web applications engineered from a unified Flutter codebase.",
          accentColor: Color(0xffA855F7),
        ),
        SizedBox(height: 14),
        _FocusCard(
          icon: Icons.architecture_rounded,
          title: "Clean Architecture & State Management",
          description:
              "Scalable modular codebases powered by Riverpod and BLoC with separation of concerns and testability.",
          accentColor: Color(0xff06B6D4),
        ),
        SizedBox(height: 14),
        _FocusCard(
          icon: Icons.sensors_rounded,
          title: "IoT & Realtime Streaming",
          description:
              "Bluetooth Low Energy (BLE), MQTT protocol integrations, and WebSocket streaming for hardware ecosystems.",
          accentColor: Color(0xffF59E0B),
        ),
      ],
    );
  }
}

class _FocusCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color accentColor;

  const _FocusCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.07),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: accentColor.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(icon, color: accentColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Manrope',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Color(0xff94A3B8),
                    fontFamily: 'Manrope',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
