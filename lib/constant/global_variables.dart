import 'package:amazon_clone/constant/app_assets.dart';

class GlobalVariables {
  static String uri = 'http://192.168.1.6:3000';

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': AppAssets.icMobiles,
    },
    {
      'title': 'Essentials',
      'image': AppAssets.icEssentials,
    },
    {
      'title': 'Appliances',
      'image': AppAssets.icAppliances,
    },
    {
      'title': 'Books',
      'image': AppAssets.icBooks,
    },
    {
      'title': 'Fashion',
      'image': AppAssets.icFashion,
    },
  ];
}
