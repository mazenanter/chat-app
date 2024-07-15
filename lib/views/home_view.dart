import 'package:flutter/material.dart';
import 'package:my_chat_app/constans/constans.dart';
import 'package:my_chat_app/views/profile_view.dart';
import 'package:my_chat_app/widgets/fab_status.dart';
import 'package:my_chat_app/widgets/navigator.dart';
import 'package:my_chat_app/widgets/status_list_view.dart';
import 'package:my_chat_app/widgets/user_item_list_view.dart';
import 'setting_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  TextEditingController titleController = TextEditingController();
  bool showFab = false;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
    _tabController!.addListener(() {
      if (_tabController!.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'M.S.G',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          tabs: const [
            Tab(text: "CHATS"),
            Tab(
              text: "STATUS",
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            tooltip: 'show menu',
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            onSelected: (value) => onSelected(value, context),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text(
                  'Profile',
                ),
              ),
              const PopupMenuItem(
                value: 1,
                child: Text(
                  'Setting',
                ),
              ),
            ],
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ChatListView(),
          StatusListView(),
        ],
      ),
      floatingActionButton: showFab ? FabStatus() : null,
    );
  }
}

void onSelected(int value, BuildContext context) {
  switch (value) {
    case 0:
      navigateTo(
        context,
        const ProfileView(),
      );
      break;
    case 1:
      navigateTo(context, SettingView());
      break;
  }
}
