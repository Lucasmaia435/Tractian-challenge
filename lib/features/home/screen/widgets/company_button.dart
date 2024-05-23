import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_test/core/colors.dart';
import 'package:tractian_test/features/assets/screen/assets_screen.dart';
import 'package:tractian_test/features/home/models/companie_model.dart';

class CompanyButton extends StatelessWidget {
  const CompanyButton({super.key, required this.company});

  final CompanyModel company;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AssetsScreen(
              companyId: company.id,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: TractianColors.primaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            SvgPicture.asset("assets/company.svg"),
            const SizedBox(
              width: 16,
            ),
            Text(
              "${company.name} Unit",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
