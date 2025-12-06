import 'package:my_portfolio/models/projects.dart';
import 'package:my_portfolio/models/social_links.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile.dart';

class PortfolioRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<Profile> getProfile() async {
    try {
      print('📡 Fetching profile from Supabase...');
      final data = await _client.from('profile').select().single();
      print('📦 Profile data received: $data');
      return Profile.fromMap(data as Map<String, dynamic>);
    } catch (e) {
      print('❌ Error in getProfile: $e');
      rethrow;
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
      return list
          .map((e) => SocialLink.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('❌ Error in getSocialLinks: $e');
      rethrow;
    }
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
      return list
          .map((e) => Project.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('❌ Error in getProjects: $e');
      rethrow;
    }
  }
}
