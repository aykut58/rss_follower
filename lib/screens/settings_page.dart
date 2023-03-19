// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, unused_element
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rrs_okuyucu_app/core/init/locale_keys.g.dart';
import 'package:rrs_okuyucu_app/providers/lang_provider.dart';
import '../providers/theme_provider.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final crudModelProvider = Provider.of<LangProvider>(context);
    return Scaffold
    (
      appBar: AppBar(title: Text(LocaleKeys.ayarlar_title).tr(),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children: 
              [
                Text(LocaleKeys.ayarlar_dil.tr(),style: const TextStyle(fontSize: 20),),
                SizedBox(width: 10,),
              DropdownButton<Locale>(
          value: context.locale,
          onChanged: (Locale? newValue) {
            if (newValue != null) {
              crudModelProvider.setLocale(newValue, context);
            }
          },
          items: <Locale>[
            Locale('en', ''),
            Locale('tr', ''),
          ].map<DropdownMenuItem<Locale>>((Locale value) {
            return DropdownMenuItem<Locale>(
              value: value,
              child: Text(value == Locale('en', '') ? 'English' : 'Türkçe'),
            );
          }).toList(),
        ),
              ]
      ),
                  SizedBox(height: 10,),
              Row
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: 
                    [
                      Text(LocaleKeys.ayarlar_tema.tr(),style:  TextStyle(fontSize: 20),),
                      SizedBox(width: 10,),
                      Switch(
                        value: Provider.of<ThemeProvider>(context).isDarkModeEnabled,
                        onChanged: (value) {
                          
                
                            Provider.of<ThemeProvider>(context).setTheme(value);

                        },
                      ),
                      
                    ],
                  ),
          
              ],
            ),
            

              
              
            

          
        ),
      );
    
  }
}