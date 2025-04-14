import 'package:flutter/material.dart';

import 'package:another_notes/src/feature/authentication/ui/logout/logout_view.dart';
// import 'package:another_notes/src/feature/home/ui/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String routePath = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    // _viewModel = HomeViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: LogoutButton()));
  }
}
