import 'package:flutter/material.dart';

class CurrencyUtils {
  // Current USD to INR conversion rate (as of 2024)
  static const double usdToInrRate = 83.12;

  // Convert USD to INR
  static double convertUsdToInr(double usdAmount) {
    return usdAmount * usdToInrRate;
  }

  // Format price in INR with ₹ symbol
  static String formatInrPrice(double usdAmount) {
    double inrAmount = convertUsdToInr(usdAmount);
    // Format with no decimal places if it's a whole number
    // Otherwise use only 1 decimal place to save space
    if (inrAmount == inrAmount.roundToDouble()) {
      return '₹${inrAmount.toInt()}';
    } else {
      return '₹${inrAmount.toStringAsFixed(1)}';
    }
  }
}