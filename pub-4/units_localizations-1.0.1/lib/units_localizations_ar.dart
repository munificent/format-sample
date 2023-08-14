import 'package:intl/intl.dart' as intl;

import 'units_localizations.dart';

/// The translations for Arabic (`ar`).
class UnitsLocalizationsAr extends UnitsLocalizations {
  UnitsLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String knots(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'عُقدة',
      one: 'عُقدة',
      zero: 'عُقدة',
    );
    return '$_temp0';
  }

  @override
  String kilometersPerHours(Object kilometers, Object hours) {
    return '$kilometers في $hours';
  }

  @override
  String milesPerHours(Object miles, Object hours) {
    return '$miles في $hours';
  }

  @override
  String metersPerSeconds(Object meters, Object seconds) {
    return '$meters في $seconds';
  }

  @override
  String kilometersPerLiters(Object kilometers, Object liters) {
    return '$kilometers لكل $liters';
  }

  @override
  String metersPerLiters(Object meters, Object liters) {
    return '$meters لكل $liters';
  }

  @override
  String milesPerImperialGallons(Object miles, Object gallons) {
    return '$miles لكل امبراطوري $gallons';
  }

  @override
  String milesPerUsGallons(Object miles, Object gallons) {
    return '$miles لكل امريكي $gallons';
  }

  @override
  String miles(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'ميل',
      one: 'ميل',
      zero: 'ميل',
    );
    return '$_temp0';
  }

  @override
  String inches(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'بوصة',
      one: 'بوصة',
      zero: 'بوصة',
    );
    return '$_temp0';
  }

  @override
  String meters(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'متر',
      one: 'متر',
      zero: 'متر',
    );
    return '$_temp0';
  }

  @override
  String kilometers(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'كيلومتر',
      one: 'كيلومتر',
      zero: 'كيلومتر',
    );
    return '$_temp0';
  }

  @override
  String gramsPerMeters(Object grams, Object meters) {
    return '$grams لكل $meters';
  }

  @override
  String gramsPerMiles(Object grams, Object miles) {
    return '$grams لكل $miles';
  }

  @override
  String kilogramsPerKilometers(Object kilograms, Object kilometers) {
    return '$kilograms لكل $kilometers';
  }

  @override
  String kilogramsPerMeters(Object kilograms, Object meters) {
    return '$kilograms لكل $meters';
  }

  @override
  String gramsPerKilometers(Object grams, Object kilometers) {
    return '$grams لكل $kilometers';
  }

  @override
  String micrograms(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'ميكروغرام',
      one: 'ميكروغرام',
      zero: 'ميكروغرام',
    );
    return '$_temp0';
  }

  @override
  String milligrams(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'مليغرام',
      one: 'مليغرام',
      zero: 'مليغرام',
    );
    return '$_temp0';
  }

  @override
  String grams(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'جرام',
      one: 'جرام',
      zero: 'جرام',
    );
    return '$_temp0';
  }

  @override
  String tons(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'طن',
      one: 'طن',
      zero: 'طن',
    );
    return '$_temp0';
  }

  @override
  String ounce(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'اونصه',
      one: 'اونصه',
      zero: 'اونصه',
    );
    return '$_temp0';
  }

  @override
  String stone(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'حجر',
      one: 'حجر',
      zero: 'حجر',
    );
    return '$_temp0';
  }

  @override
  String pounds(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'رطل',
      one: 'رطل',
      zero: 'رطل',
    );
    return '$_temp0';
  }

  @override
  String kilograms(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'كيلوجرام',
      one: 'كيلوجرام',
      zero: 'كيلوجرام',
    );
    return '$_temp0';
  }

  @override
  String pascals(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'باسكال',
      one: 'باسكال',
      zero: 'باسكال',
    );
    return '$_temp0';
  }

  @override
  String bars(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'بار',
      one: 'بار',
      zero: 'بار',
    );
    return '$_temp0';
  }

  @override
  String poundForcePerSquareInch(Object pounds, Object inches) {
    return '$pounds رطل لكل بوصة مربعة $inches';
  }

  @override
  String celsius(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'درجة مئوية',
      one: 'درجة مئوية',
      zero: 'درجة مئوية',
    );
    return '$_temp0';
  }

  @override
  String fahrenheit(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'فهرنهايت',
      one: 'فهرنهايت',
      zero: 'فهرنهايت',
    );
    return '$_temp0';
  }

  @override
  String kelvin(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'كلفن',
      one: 'كلفن',
      zero: 'كلفن',
    );
    return '$_temp0';
  }

  @override
  String rankine(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'رانكين',
      one: 'رانكين',
      zero: 'رانكين',
    );
    return '$_temp0';
  }

  @override
  String romer(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: 'رومر',
      one: 'رومر',
      zero: 'رومر',
    );
    return '$_temp0';
  }

  @override
  String century(num time) {
    String _temp0 = intl.Intl.pluralLogic(
      time,
      locale: localeName,
      other: 'قرون',
      one: 'قرن',
      zero: 'قرون',
    );
    return '$_temp0';
  }

  @override
  String decade(num time) {
    String _temp0 = intl.Intl.pluralLogic(
      time,
      locale: localeName,
      other: 'عقود',
      one: 'عقد',
      zero: 'عقود',
    );
    return '$_temp0';
  }

  @override
  String year(num time) {
    String _temp0 = intl.Intl.pluralLogic(
      time,
      locale: localeName,
      other: 'سنة',
      one: 'سنة',
      zero: 'سنة',
    );
    return '$_temp0';
  }

  @override
  String month(num time) {
    String _temp0 = intl.Intl.pluralLogic(
      time,
      locale: localeName,
      other: 'شهر',
      one: 'شهر',
      zero: 'شهر',
    );
    return '$_temp0';
  }

  @override
  String monthAbbreviation(num time) {
    String _temp0 = intl.Intl.pluralLogic(
      time,
      locale: localeName,
      other: 'شهر',
      one: 'شهر',
      zero: 'شهر',
    );
    return '$_temp0';
  }

  @override
  String week(num time) {
    String _temp0 = intl.Intl.pluralLogic(
      time,
      locale: localeName,
      other: 'اسبوع',
      one: 'اسبوع',
      zero: 'اسبوع',
    );
    return '$_temp0';
  }

  @override
  String day(num time) {
    String _temp0 = intl.Intl.pluralLogic(
      time,
      locale: localeName,
      other: 'يوم',
      one: 'ايام',
      zero: 'يوم',
    );
    return '$_temp0';
  }

  @override
  String hour(num time) {
    String _temp0 = intl.Intl.pluralLogic(
      time,
      locale: localeName,
      other: 'ساعة',
      one: 'ساعة',
      zero: 'ساعة',
    );
    return '$_temp0';
  }

  @override
  String minute(num time) {
    String _temp0 = intl.Intl.pluralLogic(
      time,
      locale: localeName,
      other: 'دقيقة',
      one: 'دقيقة',
      zero: 'دقيقة',
    );
    return '$_temp0';
  }

  @override
  String second(num time) {
    String _temp0 = intl.Intl.pluralLogic(
      time,
      locale: localeName,
      other: 'ثانية',
      one: 'ثانية',
      zero: 'ثانية',
    );
    return '$_temp0';
  }

  @override
  String millisecond(num time) {
    String _temp0 = intl.Intl.pluralLogic(
      time,
      locale: localeName,
      other: 'ميلي ثانية',
      one: 'ميلي ثانية',
      zero: 'ميلي ثانية',
    );
    return '$_temp0';
  }

  @override
  String microsecond(num time) {
    String _temp0 = intl.Intl.pluralLogic(
      time,
      locale: localeName,
      other: 'ميكروثانية',
      one: 'ميكروثانية',
      zero: 'ميكروثانية',
    );
    return '$_temp0';
  }

  @override
  String imperialGallonsPerMiles(Object gallons, Object miles) {
    return '$gallons امبراطوري لكل $miles';
  }

  @override
  String usGallonsPerMiles(Object gallons, Object miles) {
    return '$gallons امريكي لكل $miles';
  }

  @override
  String litersPerMeters(Object liters, Object meters) {
    return '$liters لكل $meters';
  }

  @override
  String litersPerKilometers(Object liters, Object kilometers) {
    return '$liters لكل $kilometers';
  }

  @override
  String cubicFoot(num volume) {
    String _temp0 = intl.Intl.pluralLogic(
      volume,
      locale: localeName,
      other: 'قدم مكعب',
      one: 'قدم مكعب',
      zero: 'قدم مكعب',
    );
    return '$_temp0';
  }

  @override
  String cubicInch(num volume) {
    String _temp0 = intl.Intl.pluralLogic(
      volume,
      locale: localeName,
      other: 'بوصة مكعب',
      one: 'بوصة مكعب',
      zero: 'بوصة مكعب',
    );
    return '$_temp0';
  }

  @override
  String cubicMeter(num volume) {
    String _temp0 = intl.Intl.pluralLogic(
      volume,
      locale: localeName,
      other: 'متر مكعب',
      one: 'متر مكعب',
      zero: 'متر مكعب',
    );
    return '$_temp0';
  }

  @override
  String cup(num volume) {
    String _temp0 = intl.Intl.pluralLogic(
      volume,
      locale: localeName,
      other: 'اكواب',
      one: 'كوب',
      zero: 'اكواب',
    );
    return '$_temp0';
  }

  @override
  String fluidOunces(num volume) {
    String _temp0 = intl.Intl.pluralLogic(
      volume,
      locale: localeName,
      other: 'أوقية سوائل',
      one: 'سائل أوقية',
      zero: 'أوقية سوائل',
    );
    return '$_temp0';
  }

  @override
  String quart(num volume) {
    String _temp0 = intl.Intl.pluralLogic(
      volume,
      locale: localeName,
      other: 'كوارت',
      one: 'كوارت',
      zero: 'كوارت',
    );
    return '$_temp0';
  }

  @override
  String pint(num volume) {
    String _temp0 = intl.Intl.pluralLogic(
      volume,
      locale: localeName,
      other: 'نصف لتر',
      one: 'نصف لتر',
      zero: 'نصف لتر',
    );
    return '$_temp0';
  }

  @override
  String tablespoon(num volume) {
    String _temp0 = intl.Intl.pluralLogic(
      volume,
      locale: localeName,
      other: 'ملعقة كبيرة',
      one: 'ملعقة كبيرة',
      zero: 'ملعقة كبيرة',
    );
    return '$_temp0';
  }

  @override
  String teaspoon(num volume) {
    String _temp0 = intl.Intl.pluralLogic(
      volume,
      locale: localeName,
      other: 'ملعقة صغيرة',
      one: 'ملعقة صغيرة',
      zero: 'ملعقة صغيرة',
    );
    return '$_temp0';
  }

  @override
  String gallons(num volume) {
    String _temp0 = intl.Intl.pluralLogic(
      volume,
      locale: localeName,
      other: 'جالون',
      one: 'جالون',
      zero: 'جالون',
    );
    return '$_temp0';
  }

  @override
  String milliliters(num volume) {
    String _temp0 = intl.Intl.pluralLogic(
      volume,
      locale: localeName,
      other: 'مليلتر',
      one: 'مليلتر',
      zero: 'مليلتر',
    );
    return '$_temp0';
  }

  @override
  String liters(num volume) {
    String _temp0 = intl.Intl.pluralLogic(
      volume,
      locale: localeName,
      other: 'لتر',
      one: 'لتر',
      zero: 'لتر',
    );
    return '$_temp0';
  }
}
