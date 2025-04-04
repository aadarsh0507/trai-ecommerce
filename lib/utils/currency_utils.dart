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
    return '₹${inrAmount.toStringAsFixed(2)}';
  }
}