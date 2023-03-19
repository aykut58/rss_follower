import 'package:easy_localization/easy_localization.dart';
import 'package:rrs_okuyucu_app/core/init/locale_keys.g.dart';
class DateUtil 
{
  static String setSubTitleText(DateTime dateTime1) 
        {
          
          DateTime dateTime2 = DateTime.now();


          Duration difference = dateTime2.difference(dateTime1.toLocal());
          if(difference.inMinutes <= 59) 
          {
              return "${difference.inMinutes} ${LocaleKeys.home_page_dakika_once.tr()}";
          }
          else if (difference.inHours <= 24)
          {
              return"${difference.inHours} ${LocaleKeys.home_page_saat_once.tr()}";

          }
          else 
          {
              return"${difference.inDays} ${LocaleKeys.home_page_gun_once.tr()}";
          }
         
        }
}