import 'package:flutter/material.dart';
import 'package:wurigiri/consts/const.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/widget/head_photo.dart';

class UserDataView extends StatelessWidget {
  const UserDataView({
    super.key,
    required this.me,
    required this.other,
    required this.onTapUser,
  });
  final User me;
  final User other;
  final Function(User user) onTapUser;

  Widget dDayText() {
    final inDays = DateTime.now().difference(firstMeet).inDays + 1;
    return Column(
      children: [
        Text("$inDays일째"),
        const Icon(
          Icons.favorite,
          color: Colors.red,
        ),
      ],
    );
  }

  Widget userWidget(User user) {
    return GestureDetector(
      onTap: () {
        onTapUser(user);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WHeadPhoto(
            user.headPhoto,
            size: 56.0,
          ),
          Text(user.name),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        userWidget(other),
        dDayText(),
        userWidget(me),
      ],
    );
  }
}
