import 'package:flutter/material.dart';

import '../../theme/color_data.dart';
import '../models/intro_model.dart';
import '../models/model_country.dart';
import '../models/model_currency.dart';
import '../models/model_item.dart';
import '../models/model_portfolio.dart';
import '../models/model_price_alert.dart';

class DataFile {
  static List<ModelIntro> introList = [
    ModelIntro(
        1,
        Colors.white,
        "onboarding_1.png",
        "Your Wallet, Reimagined",
        "Create and manage virtual\ncards effortlessly.",
        "Next"),
    ModelIntro(
        2,
        Colors.white,
        "onboarding_2.png",
        "Go Global with Confidence",
        "Pay anywhere, anytime, without\nborders.",
        "Next"),
    ModelIntro(
        3,
        Colors.white,
        "onboarding_3.png",
        "Seamless Local Transfers",
        "Send and receive money across\nNigeria instantly.",
        "Get Started"),
  ];
  //
  // static List<ModelCountry> countryList = [
  //   ModelCountry("image_fghanistan.jpg", "Afghanistan (AF)", "+93"),
  //   ModelCountry("image_ax.jpg", "Aland Islands (AX)", "+358"),
  //   ModelCountry("image_albania.jpg", "Albania (AL)", "+355"),
  //   ModelCountry("image_andora.jpg", "Andorra (AD)", "+376"),
  //   ModelCountry("image_islands.jpg", "Aland Islands (AX)", "+244"),
  //   ModelCountry("image_angulia.jpg", "Anguilla (AL)", "+1"),
  //   ModelCountry("image_armenia.jpg", "Armenia (AN)", "+374"),
  //   ModelCountry("image_austia.jpg", "Austria (AT)", "+372"),
  // ];

  static List<ModelItem> itemList = [
    ModelItem("home.svg", "Home"),
    ModelItem("send.svg", "Send"),
    ModelItem("cards.svg", "Cards"),
    ModelItem("profile.svg", "Profile")
  ];

  static List<ModelPortfolio> portfolioList = [
    ModelPortfolio("btc.svg", "Bitcoin", "-0.22", 56.33, "BTS"),
    ModelPortfolio("eth.svg", "Ethereum", "+0.22", 25.56, "ETH"),
    ModelPortfolio("eur.svg", "European Unicon", "-0.36", 69.25, "EUR"),
    ModelPortfolio("ltc.svg", "Litecoin", "+0.35", 33.53, "LIT"),
    ModelPortfolio("eur.svg", "European Unicon", "-0.45", 74.52, "EUR"),
    ModelPortfolio("bnb.svg", "Binance Coin", "+0.35", 26.53, "BIN"),
    ModelPortfolio("usd.svg", "United States Dollar", "-0.24", 74.52, "UNI")
  ];

  static List<ModelCurrency> currencyList = [
    ModelCurrency("btc.svg", "Bitcoin"),
    ModelCurrency("eth.svg", "Ethereum"),
    ModelCurrency("eur.svg", "European Unicon"),
    ModelCurrency("ltc.svg", "Litecoin"),
    ModelCurrency("eur.svg", "European Unicon"),
    ModelCurrency("bnb.svg", "Binance Coin"),
    ModelCurrency("usd.svg", "United States Dollar")
  ];

  static List<ModelPriceAlert> priceAlertList = [
    ModelPriceAlert("btc.svg", "Bitcoin", "Price rises to", "\$575.02"),
    ModelPriceAlert("btc.svg", "Bitcoin", "Price rises to", "\$386.02"),
    ModelPriceAlert("btc.svg", "Bitcoin", "Price rises to", "\$785.02"),
    ModelPriceAlert("eth.svg", "Ethereum", "Price rises to", "\$547.02")
  ];
}
