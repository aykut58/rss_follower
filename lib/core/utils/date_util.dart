import 'package:easy_localization/easy_localization.dart';
import 'package:rrs_okuyucu_app/core/init/locale_keys.g.dart';
class DateUtil 
{
  static String setSubTitleText(DateTime dateTime1) 
        {
          
          DateTime dateTime2 = DateTime.now();
          DateTime dateTime3 = dateTime1.add(Duration(hours: dateTime1.timeZoneOffset.inHours * -1 ));
          Duration difference = dateTime2.difference(dateTime3);
          if(difference.inMinutes == 1)
          {
            return LocaleKeys.home_page_bir_dakika_once.tr();
          }
          else if(difference.inMinutes <= 59) 
          {
            return "${difference.inMinutes} ${LocaleKeys.home_page_dakika_once.tr()}";
          }
          else if(difference.inHours <= 1)
          {
            return LocaleKeys.home_page_bir_saat_once.tr();
          }
          else if (difference.inHours <= 24)
          {
            return"${difference.inHours} ${LocaleKeys.home_page_saat_once.tr()}";
          }
          else if (difference.inDays == 1) 
          {
            return LocaleKeys.home_page_bir_gun_once.tr();
          }
          else 
          {
            return"${difference.inDays} ${LocaleKeys.home_page_gun_once.tr()}";
          }
         
        }
}