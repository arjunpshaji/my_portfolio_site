import 'package:my_portfolio/models/projects.dart';
import 'package:my_portfolio/models/social_links.dart';
import 'package:my_portfolio/models/experience.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile.dart';

class PortfolioRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<Profile> getProfile() async {
    try {
      print('📡 Fetching profile from Supabase...');
      final data = await _client.from('profile').select().single();
      print('📦 Profile data received: $data');
      return Profile.fromMap(data);
    } catch (e) {
      print('❌ Error in getProfile: $e. Using fallback profile.');
      return Profile(
        fullName: 'Arjun P Shaji',
        tagline: 'Senior Flutter & Mobile Developer',
        about:
            'Passionate Software Developer with extensive experience in building robust, responsive, and performant cross-platform mobile and web applications. Expert in Clean Architecture, reactive state management (Riverpod/BLoC), high-performance UI rendering, and IoT integrations.',
        email: 'imarjunpshaji@gmail.com',
        location: 'Kerala, India',
        profileImage: 'assets/images/mydp.png',
        cvUrl:
            'https://drive.google.com/uc?export=download&id=1DqUoGPaGqfPc3JDIQuF3uisKeUzSnAEB',
      );
    }
  }

  Future<List<SocialLink>> getSocialLinks() async {
    try {
      print('📡 Fetching social links from Supabase...');
      final data = await _client
          .from('social_links')
          .select()
          .order('sort', ascending: true);
      print('📦 Social links data received: $data');

      final list = data as List<dynamic>;
      if (list.isNotEmpty) {
        return list
            .map((e) => SocialLink.fromMap(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('❌ Error in getSocialLinks: $e. Using fallback social links.');
    }
    return [
      SocialLink(
        label: 'LinkedIn',
        url: 'https://www.linkedin.com/in/arjun-p-shaji-336712213/',
        sort: 1,
      ),
      SocialLink(
        label: 'GitHub',
        url: 'https://github.com/arjunpshaji',
        sort: 2,
      ),
      SocialLink(
        label: 'Gmail',
        url: 'mailto:imarjunpshaji@gmail.com',
        sort: 3,
      ),
      SocialLink(
        label: 'Instagram',
        url: 'https://www.instagram.com/arjun_p_shaji',
        sort: 4,
      ),
    ];
  }

  Future<List<Project>> getProjects() async {
    try {
      print('📡 Fetching projects from Supabase...');
      final data = await _client
          .from('projects')
          .select()
          .order('sort', ascending: true);
      print('📦 Projects data received: $data');

      final list = data as List<dynamic>;
      if (list.isNotEmpty) {
        return list
            .map((e) => Project.fromMap(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('❌ Error in getProjects: $e. Using fallback projects.');
    }
    return [
      Project(
        title: 'PDF Invoice Generator',
        description:
            'A modern web application built with Flutter for seamless invoice generation and PDF export. Leverages Riverpod for state management along with the PDF and printing packages for responsive document creation.',
        projectUrl: 'https://arjunpshaji.github.io/invoice_builder_pdf/',
        techStack: 'Flutter, Riverpod, PDF, Dart',
        sort: 1,
      ),
      Project(
        title: 'SimplyDate',
        description:
            'A published Flutter package designed to simplify date formatting in mobile & web apps. Provides human-readable formats, custom styles, ordinal suffixes, and relative time calculations.',
        projectUrl: 'https://pub.dev/packages/simply_date',
        techStack: 'Dart, Flutter, Pub.dev, Open Source',
        sort: 2,
      ),
    ];
  }

  Future<List<Experience>> getExperiences() async {
    try {
      print('📡 Fetching experiences from Supabase...');
      final data = await _client
          .from('experiences')
          .select()
          .order('sort', ascending: true);
      print('📦 Experiences data received: $data');

      final list = data as List<dynamic>;
      if (list.isNotEmpty) {
        return list
            .map((e) => Experience.fromMap(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('❌ Error in getExperiences: $e. Using fallback experiences.');
    }
    return [
      Experience(
        title: 'Software Developer - Techwarelab',
        period: 'Jul 2023 - Present',
        description:
            '• Engineered and shipped scalable cross-platform mobile apps for enterprise clients using Flutter and Dart.\n• Implemented Clean Architecture patterns and reactive state management utilizing Riverpod and BLoC.\n• Integrated GraphQL and RESTful microservices, WebSocket channels, and Bluetooth IoT device communication.\n• Managed complete release cycles and CI/CD automated deployments to Google Play Store and Apple App Store.',
        sort: 1,
      ),
      Experience(
        title: 'Freelance Mobile Developer',
        period: 'Jan 2023 - Jun 2023',
        description:
            '• Partnered with startups and entrepreneurs to build custom Flutter applications and open-source packages.\n• Implemented payment gateway integrations (Stripe, Razorpay), Firebase authentication, and Cloud Firestore.\n• Optimized rendering performance and frame rates across diverse Android and iOS screen form factors.',
        sort: 2,
      ),
      Experience(
        title: 'Flutter Developer Intern - Techfriar',
        period: 'Jul 2022 - Dec 2022',
        description:
            '• Contributed to core mobile feature modules using Flutter and Dart in an agile sprint environment.\n• Collaborated on responsive UI component libraries, unit testing, and Git version control workflows.',
        sort: 3,
      ),
    ];
  }
}
