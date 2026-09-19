import 'package:flutter/material.dart';
import 'package:my_portfolio/data/portfolio_repository.dart';
import 'package:my_portfolio/models/experience.dart';
import 'package:my_portfolio/models/metric.dart';
import 'package:my_portfolio/models/profile.dart';
import 'package:my_portfolio/models/projects.dart';
import 'package:my_portfolio/models/social_links.dart';

class PortfolioProvider extends ChangeNotifier {
  final PortfolioRepository _repository = PortfolioRepository();

  Profile? _profile;
  List<SocialLink> _socialLinks = [];
  List<Project> _projects = [];
  List<Experience> _experiences = [];
  List<Metric> _metrics = [];
  bool _isLoading = true;
  String? _error;

  Profile? get profile => _profile;
  List<SocialLink> get socialLinks => _socialLinks;
  List<Project> get projects => _projects;
  List<Experience> get experiences => _experiences;
  List<Metric> get metrics => _metrics;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadData() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Load all sections concurrently or sequentially with silent fallback
      try {
        _profile = await _repository.getProfile();
      } catch (e) {
        _error = 'Failed to load profile';
      }

      try {
        _socialLinks = await _repository.getSocialLinks();
      } catch (e) {
        _error = 'Failed to load social links';
      }

      try {
        _experiences = await _repository.getExperiences();
      } catch (e) {
        _error = 'Failed to load experiences';
      }

      try {
        _projects = await _repository.getProjects();
      } catch (e) {
        _error = 'Failed to load projects';
      }

      try {
        _metrics = await _repository.getMetrics();
      } catch (e) {
        _error = 'Failed to load metrics';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
