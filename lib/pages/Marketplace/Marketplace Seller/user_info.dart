import 'package:flutter/material.dart';
import 'package:lawod/components/userprovider.dart';
import 'package:provider/provider.dart';
import 'user_name.dart';
import 'username_fullname.dart';
import 'user_email.dart';
import 'user_password.dart';
import 'user_phone.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: SizedBox(
            width: 305,
            child: Text(
              'Information',
              style: TextStyle(
                color: Color(0xFF196DFF),
                fontSize: 31,
                fontFamily: 'Proxima Nova',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4F4F4F)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: const ShapeDecoration(
                color: Color(0x701D1B1B),
                shape: CircleBorder(),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://drive.google.com/uc?export=view&id=1Dc-e2GPOpqWgumRNt8kLVp6b_ztKI2yw',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 43),
            SizedBox(
              width: 332.67,
              height: 347,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Username',
                      context.watch<UserProvider>().userName, const UserName()),
                  const SizedBox(height: 25),
                  _buildInfoRow(
                      'Full Name',
                      '${context.watch<UserProvider>().firstName} ${context.watch<UserProvider>().lastName}',
                      const UserFullName()),
                  const SizedBox(height: 25),
                  _buildInfoRow('Email',
                      context.watch<UserProvider>().email, const UserEmail()),
                  const SizedBox(height: 25),
                  _buildInfoRow('Phone Number',
                      context.watch<UserProvider>().phoneNumber, const UserPhoneNumber()),
                  const SizedBox(height: 25),
                  _buildInfoRow('Password',
                      context.watch<UserProvider>().password, const UserPassword()),
                  const SizedBox(height: 25),
                  _buildInfoRow('Account Type',
                      context.watch<UserProvider>().userName, const UserName()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Widget destination) {
    if (label == 'Full Name') {
      value =
          '${context.watch<UserProvider>().firstName} ${context.watch<UserProvider>().lastName}';
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: SizedBox(
        width: 332.67,
        height: 37,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                width: 107.24,
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF4F4F4F),
                    fontSize: 14,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 17,
              child: SizedBox(
                width: 198,
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF196DFF),
                    fontSize: 20,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 283,
              top: 10,
              child: SizedBox(
                width: 49.67,
                child: Text(
                  'Change',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF828282),
                    fontSize: 14,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
