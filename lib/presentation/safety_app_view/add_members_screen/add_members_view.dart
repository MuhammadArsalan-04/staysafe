import 'package:flutter/material.dart';
import 'package:stay_safe_user/presentation/safety_app_view/add_members_screen/layout/body.dart';

class AddMembersView extends StatelessWidget {
  const AddMembersView({super.key});

  static const routeName = '/add_members';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: AddMembersViewBody()),
    );
  }
}
