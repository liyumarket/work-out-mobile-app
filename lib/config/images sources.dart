// local Assets Imgs
import 'dart:math';

class ImgSrc {
  ImgSrc();

  List<String> imgList = <String>[
    ImgSrc.homeImage1,
    ImgSrc.homeImage2,
    ImgSrc.homeImage3,
    ImgSrc.homeImage4,
    ImgSrc.homeImage11,
    ImgSrc.homeImage5,
    ImgSrc.homeImage6,
    ImgSrc.homeImage7,
    ImgSrc.homeImage8,
    ImgSrc.homeImage9,
    ImgSrc.homeImage10,
  ];

  static String welcome = 'imgs/welcomeOverlayImg.png';
  static String getStarted = 'imgs/GetStartedOverlay.png';
  static String login = 'imgs/loginOverlayImg.png';
  static String primaryLaungage = "imgs/en.png";
  static String secondaryLaungage = "imgs/fr.png";
  static String imgVerification = "imgs/email_verif.png";
  static String homepageOverlay = 'imgs/welcomePageOverlay.png';

  static String noImgAvailable = "imgs/No_image_available.png";
  static String homeImage1 = "imgs/1.jpg";
  static String homeImage2 = "imgs/2.jpg";
  static String homeImage3 = "imgs/3.jpg";
  static String homeImage4 = "imgs/4.jpg";
  static String homeImage5 = "imgs/5.jpg";
  static String homeImage6 = "imgs/6.jpg";
  static String homeImage7 = "imgs/7.jpg";
  static String homeImage8 = "imgs/8.jpg";
  static String homeImage9 = "imgs/9.jpg";
  static String homeImage10 = "imgs/10.jpg";
  static String homeImage11 = "imgs/11.jpg";

  String randomFromAssetsList() {
    return imgList[Random().nextInt(imgList.length)];
  }
}
