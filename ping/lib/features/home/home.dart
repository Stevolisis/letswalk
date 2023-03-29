import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:ping/app/app.dart';
import 'package:ping/features/home/tabs/categories.dart';
import 'package:ping/features/home/tabs/status.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            if (state.isEmpty) {
              // handle error
            }

            return DefaultTabController(
              length: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(36),
                    SvgPicture.asset(
                      'assets/svg/logo.svg',
                      semanticsLabel: 'Acme Logo',
                    ),
                    const Gap(28),
                    _buildTabBar(),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          CategoriesTab(),
                          StatusTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container _buildTabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          color: const Color(0xFFDAECE9),
          borderRadius: BorderRadius.circular(4),
        ),
        labelColor: const Color(0xFF1D2827),
        tabs: const [
          Tab(
            text: 'Categories',
            height: 32,
          ),
          Tab(
            height: 32,
            text: 'Status',
          ),
        ],
      ),
    );
  }
}
