import 'package:flutter/material.dart';

class RecomendedColorData {
  static Color getColorByName(String name) {
    // Implement the logic to return the right color based on the name
    switch (name.toLowerCase()) {
      case 'mocha':
        return const Color(0XFFA52A2A); // Mocha color
      case 'deep chestnut':
        return const Color(0XFFCD5C5C); // Deep Chestnut color
      case 'berry':
        return const Color(0XFF8B0000); // Berry color
      case 'plum':
        return Color.fromARGB(255, 207, 93, 191); // Plum color
      case 'cocoa':
        return const Color(0XFF6F4E37); // Cocoa color
      case 'dark cocoa':
        return const Color(0XFF4B2E2E); // Dark Cocoa color
      case 'burgundy':
        return const Color(0XFF800020); // Burgundy color
      case 'dark purple':
        return Color.fromARGB(255, 108, 43, 120); // Dark Purple color
      case 'walnut':
        return const Color(0XFF5C4033); // Walnut color
      case 'dark walnut':
        return const Color(0XFF3B2F2F); // Dark Walnut color
      case 'deep berry':
        return const Color(0XFF551A8B); // Deep Berry color
      case 'deep bronze':
        return const Color(0XFF674C47); // Deep Bronze color
      case 'deep neutral':
        return const Color(0XFF645452); // Deep Neutral color
      case 'cranberry':
        return const Color(0XFF950714); // Cranberry color
      case 'dark almond':
        return const Color(0XFF5A2E2E); // Dark Almond color
      case 'dark red':
        return Color.fromARGB(255, 196, 4, 4); // Dark Red color
      case 'deep plum':
        return Color.fromARGB(255, 139, 68, 178); // Deep Plum color
      case 'ivory':
        return const Color(0XFFFFFFF0); // Ivory color
      case 'light beige':
        return const Color(0XFFF5F5DC); // Light Beige color
      case 'soft pink':
        return const Color(0XFFFFB6C1); // Soft Pink color
      case 'nude pink':
        return const Color(0XFFFFDEAD); // Nude Pink color
      case 'porcelain':
        return const Color(0XFFFFF9E3); // Porcelain color
      case 'fair':
        return const Color(0XFFFFE4C4); // Fair color
      case 'light coral':
        return const Color(0XFFF08080); // Light Coral color
      case 'soft rose':
        return const Color(0XFFFAEBD7); // Soft Rose color
      case 'alabaster':
        return const Color(0XFFFAF0E6); // Alabaster color
      case 'baby pink':
        return const Color(0XFFFFB6C1); // Baby Pink color
      case 'soft peach':
        return const Color(0XFFFFE5B4); // Soft Peach color
      case 'snow':
        return const Color(0XFFFFFAFA); // Snow color
      case 'light rose':
        return const Color(0XFFFFE4E1); // Light Rose color
      case 'pinky nude':
        return const Color(0XFFFDC9B0); // Pinky Nude color
      case 'light ivory':
        return const Color(0XFFFFE4C4); // Light Ivory color
      case 'very light':
        return const Color(0XFFF5F5F5); // Very Light color
      case 'light pink':
        return const Color(0XFFFFAEB9); // Light Pink color
      case 'peach':
        return const Color(0XFFFFDAB9); // Peach color
      case 'coral':
        return const Color(0XFFFF7F50); // Coral color
      case 'buff':
        return const Color(0XFFF0E68C); // Buff color
      case 'light neutral':
        return const Color(0XFFD3D3D3); // Light Neutral color
      case 'peachy pink':
        return const Color(0XFFF8B195); // Peachy Pink color
      case 'cool ivory':
        return const Color(0XFFFFF5EE); // Cool Ivory color
      case 'warm peach':
        return const Color(0XFFFFE4B5); // Warm Peach color
      case 'pink':
        return const Color(0XFFFFC0CB); // Pink color
      case 'warm ivory':
        return const Color(0XFFFFEBCD); // Warm Ivory color
      case 'soft beige':
        return const Color(0XFFF5F5DC); // Soft Beige color
      case 'medium beige':
        return const Color(0XFFCFB53B); // Medium Beige color
      case 'rosy pink':
        return const Color(0XFFFF69B4); // Rosy Pink color
      case 'mauve':
        return const Color(0XFFE0B0FF); // Mauve color
      case 'sand':
        return const Color(0XFFDEC4A1); // Sand color
      case 'medium':
        return const Color(0XFFD2B48C); // Medium color
      case 'rose':
        return const Color(0XFFFF007F); // Rose color
      case 'berry':
        return const Color(0XFF8B0000); // Berry color
      case 'beige':
        return const Color(0XFFF5F5DC); // Beige color
      case 'honey':
        return const Color(0XFFFFDD44); // Honey color
      case 'warm rose':
        return const Color(0XFFFFC0CB); // Warm Rose color
      case 'raspberry':
        return const Color(0XFFE30B5D); // Raspberry color
      case 'natural beige':
        return const Color(0XFFD2B48C); // Natural Beige color
      case 'rosy beige':
        return const Color(0XFFBC8F8F); // Rosy Beige color
      case 'mauve pink':
        return const Color(0XFFD8BFD8); // Mauve Pink color
      case 'warm beige':
        return const Color(0XFFD3BBA7); // Warm Beige color
      case 'medium warm':
        return const Color(0XFFE1C699); // Medium Warm color
      case 'warm pink':
        return const Color(0XFFFFC0CB); // Warm Pink color
      case 'berry pink':
        return const Color(0XFF8B0000); // Berry Pink color
      default:
        return const Color(0XFF000000); // Fallback color (black)
    }
  }
}
