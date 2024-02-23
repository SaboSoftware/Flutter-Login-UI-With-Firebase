import 'package:firebaselogin/login_page.dart';
import 'package:firebaselogin/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _SignInThreeState();
}

class _SignInThreeState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController passController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF21899C),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              //bg design, we use 3 svg img
              Positioned(
                left: -26,
                top: 51.0,
                child: SvgPicture.string(
                  '<svg viewBox="-26.0 51.0 91.92 91.92" ><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, -26.0, 96.96)" d="M 48.75 0 L 65 32.5 L 48.75 65 L 16.24999809265137 65 L 0 32.5 L 16.25000381469727 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, -10.83, 105.24)" d="M 0 0 L 27.625 11.05000019073486 L 55.25 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 16.51, 93.51)" d="M 0 37.04999923706055 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 91.92,
                  height: 91.92,
                ),
              ),
              Positioned(
                right: 43.0,
                top: -103,
                child: SvgPicture.string(
                  '<svg viewBox="63.0 -103.0 268.27 268.27" ><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 63.0, 67.08)" d="M 147.2896423339844 0 L 196.3861999511719 98.19309997558594 L 147.2896423339844 196.3861999511719 L 49.09654235839844 196.3861999511719 L 0 98.19309234619141 L 49.09656143188477 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 113.73, 79.36)" d="M 0 0 L 83.46413421630859 33.38565444946289 L 166.9282684326172 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 184.38, 23.77)" d="M 0 111.9401321411133 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 268.27,
                  height: 268.27,
                ),
              ),
              Positioned(
                right: -19,
                top: 31.0,
                child: SvgPicture.string(
                  '<svg viewBox="329.0 31.0 65.0 65.0" ><path transform="translate(329.0, 31.0)" d="M 48.75 0 L 65 32.5 L 48.75 65 L 16.24999809265137 65 L 0 32.5 L 16.25000381469727 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(333.88, 47.58)" d="M 0 0 L 27.625 11.05000019073486 L 55.25 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(361.5, 58.63)" d="M 0 37.04999923706055 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 65.0,
                  height: 65.0,
                ),
              ),

              //card and footer ui
              Positioned(
                bottom: 5.0,
                child: Column(
                  children: <Widget>[
                    buildCard(size),
                    buildFooter(size),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(Size size) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: size.width * 0.9,
        height: size.height * 0.87,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //logo & text
            logo(size.height / 10, size.height / 10),

            richText(18),
            SizedBox(
              height: size.height * 0.05,
            ),

            nameTextField(size),
            SizedBox(
              height: size.height * 0.03,
            ),

            emailTextField(size),
            SizedBox(
              height: size.height * 0.02,
            ),

            passwordTextField(size),
            SizedBox(
              height: size.height * 0.03,
            ),

            dateTextField(size),
            SizedBox(
              height: size.height * 0.03,
            ),

            bioTextField(size),
            SizedBox(
              height: size.height * 0.03,
            ),
            //sign in button
            signInButton(size),


          ],
        ),
      ),
    );
  }

  Widget buildFooter(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          height: size.height * 0.02,
        ),
        Row(
          children: [
            Text(style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ), "Zaten Hesabınız Var Mı ?"),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: Text(
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFFFE9879),
                    fontWeight: FontWeight.w500,
                  ),
                  "Giriş Yap!"
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget logo(double height_, double width_) {
    return Image.asset(
      'assets/logo.png',
      height: height_,
      width: width_,
    );
  }

  Widget richText(double fontSize) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: fontSize,
          color: const Color(0xFF21899C),
          letterSpacing: 3.0,
        ),
        children: const [
          TextSpan(
            text: 'HERO',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFFFE9879),
            ),
          ),
          TextSpan(
            text: 'GAMES',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget emailTextField(Size size) {
    return buildTextField(
      size: size,
      controller: emailController,
      hintText: 'Email',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icons.mail_outline_rounded,
    );
  }

  Widget passwordTextField(Size size) {
    return buildTextField(
      size: size,
      controller: passController,
      hintText: 'Şifre',
      obscureText: true,
      keyboardType: TextInputType.text,
      prefixIcon: Icons.lock,
    );
  }

  Widget nameTextField(Size size) {
    return buildTextField(
      size: size,
      controller: nameController,
      hintText: 'Ad Soyad',
      keyboardType: TextInputType.name,
      prefixIcon: Icons.person_2,
    );
  }

  Widget dateTextField(Size size) {
    return buildTextField(
      size: size,
      controller: dateController,
      hintText: 'Doğum Tarihi',
      keyboardType: TextInputType.datetime,
      prefixIcon: Icons.date_range,
    );
  }

  Widget bioTextField(Size size) {
    return buildTextField(
      size: size,
      controller: bioController,
      hintText: 'Biyografi',
      keyboardType: TextInputType.text,
      prefixIcon: Icons.person_pin,
    );
  }

  Widget buildTextField({
    required size,
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    IconData? prefixIcon,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: size.height / 12,
        child: TextField(
          controller: controller,
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: const Color(0xFF151624),
          ),
          cursorColor: const Color(0xFF151624),
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.inter(
              fontSize: 16.0,
              color: const Color(0xFF151624).withOpacity(0.5),
            ),
            filled: true,
            fillColor: controller.text.isEmpty
                ? const Color.fromRGBO(248, 247, 251, 1)
                : Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                color: controller.text.isEmpty
                    ? Colors.transparent
                    : const Color.fromRGBO(44, 185, 176, 1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(
                color: Color.fromRGBO(44, 185, 176, 1),
              ),
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: controller.text.isEmpty
                  ? const Color(0xFF151624).withOpacity(0.5)
                  : const Color.fromRGBO(44, 185, 176, 1),
              size: 16,
            ),
            suffix: Container(
              alignment: Alignment.center,
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: const Color.fromRGBO(44, 185, 176, 1),
              ),
              child: controller.text.isEmpty
                  ? const Center()
                  : const Icon(
                Icons.check,
                color: Colors.white,
                size: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget signInButton(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 13,
      width: size.width * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: const Color(0xFF21899C),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C2E84).withOpacity(0.2),
            offset: const Offset(0, 15.0),
            blurRadius: 60.0,
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size.fromWidth(size.width * 0.7),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
           AuthService().signUp(context,name: nameController.text, email: emailController.text, password: passController.text, datetime: dateController.text, bio: bioController.text);
        },
        child: Text(
          'Kayıt Ol',
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

}
