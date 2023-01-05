import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/feature/presentation/setting_screen/NSF_editing/fullNameModel.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

class NfsEditing extends StatefulWidget {
  const NfsEditing({super.key});

  @override
  State<NfsEditing> createState() => _NfsEditingState();
}

class _NfsEditingState extends State<NfsEditing> {
  final _name = TextEditingController();
  final _surname = TextEditingController();
  final _patronymic = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 28),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.color22A2BD,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
          ),
          child: const Center(
            child: Text(
              'Сохранить',
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          splashRadius: 25,
        ),
        title: Text(
          'Изменить ФИО',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
              color: AppColors.colorFFFFFF,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            const SizedBox(height: 60),
            FullNameModel(
              controller: _name,
              fullName: 'Имя',
            ),
            const SizedBox(height: 10),
            FullNameModel(
              controller: _surname,
              fullName: 'Фамилия',
            ),
            const SizedBox(height: 10),
            FullNameModel(
              controller: _patronymic,
              fullName: 'Отчество',
            ),
          ],
        ),
      ),
    );
  }
}
