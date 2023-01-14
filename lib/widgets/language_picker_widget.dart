import 'package:flutter/material.dart';
import 'package:fud_chatapp/l10n/l10n.dart';
import 'package:fud_chatapp/services/locale_provider.dart';
import 'package:provider/provider.dart';
class LanguagePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? Locale('en');

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: locale,
        icon: Container(width: 12),
        items: L10n.all.map(
              (locale) {
            final flag = L10n.getFlag(locale.languageCode);

            return DropdownMenuItem(
              child: Center(
                child: Text(
                  flag,
                  style: TextStyle(fontSize: 32),
                ),
              ),
              value: locale,
              onTap: () {
                final provider =
                Provider.of<LocaleProvider>(context, listen: false);

                provider.setLocale(locale);
               // Navigator.pop(context);
              },
            );
          },
        ).toList(),
        onChanged: (_) {},
      ),
    );
  }
}