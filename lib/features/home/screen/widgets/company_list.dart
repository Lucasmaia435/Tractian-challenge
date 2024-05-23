import 'package:flutter/material.dart';
import 'package:tractian_test/features/home/models/companie_model.dart';
import 'package:tractian_test/features/home/screen/widgets/company_button.dart';

class CompanyList extends StatelessWidget {
  const CompanyList({super.key, required this.companies});

  final List<CompanyModel> companies;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: companies.length,
      itemBuilder: (_, i) => CompanyButton(
        company: companies[i],
      ),
      separatorBuilder: (_, __) => const SizedBox(
        height: 40,
      ),
    );
  }
}
