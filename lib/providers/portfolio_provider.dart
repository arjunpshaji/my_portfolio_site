import 'package:flutter/material.dart';
import 'package:my_portfolio/data/portfolio_repository.dart';
import 'package:my_portfolio/models/experience.dart';
import 'package:my_portfolio/models/profile.dart';
import 'package:my_portfolio/models/projects.dart';
import 'package:my_portfolio/models/social_links.dart';

class PortfolioProvider extends ChangeNotifier {
  final PortfolioRepository _repository = PortfolioRepository();

  Profile? _profile;
  List<SocialLink> _socialLinks = [];
  List<Project> _projects = [];
  List<Experience> _experiences = [];
  bool _isLoading = true;
  String? _error;

  Profile? get profile => _profile;
  List<SocialLink> get socialLinks => _socialLinks;
  List<Project> get projects => _projects;
  List<Experience> get experiences => _experiences;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadData() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      print('🔄 Starting to load portfolio data...');

      // Load profile
      try {
        _profile = await _repository.getProfile();
        print('✅ Profile loaded: ${_profile?.fullName}');
      } catch (e) {
        print('❌ Error loading profile: $e');
        _error = 'Failed to load profile: $e';
      }

      // Load social links
      try {
        _socialLinks = await _repository.getSocialLinks();
        print('✅ Social links loaded: ${_socialLinks.length} items');
      } catch (e) {
        print('❌ Error loading social links: $e');
        _error = (_error ?? '') + '\nFailed to load social links: $e';
      }

      // Load Experiences
      try {
        _experiences = await _repository.getExperiences();
        print('✅ Experiences loaded: ${_experiences.length} items');
      } catch (e) {
        print('❌ Error loading experiences: $e');
        _error = (_error ?? '') + '\nFailed to load experiences: $e';
      }

      // Load projects
      try {
        _projects = await _repository.getProjects();
        print('✅ Projects loaded: ${_projects.length} items');
      } catch (e) {
        print('❌ Error loading projects: $e');
        _error = (_error ?? '') + '\nFailed to load projects: $e';
      }

      if (_error != null) {
        print('⚠️ Completed with errors: $_error');
      } else {
        print('✅ All data loaded successfully!');
      }
    } catch (e) {
      print('❌ Fatal error in loadData: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
