//import 'package:flutter/cupertino.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'dart:async';
//import 'dart:io';
//import 'dart:ui';
//import 'package:flutter/material.dart';
//import 'package:path_provider/path_provider.dart';
////--------------------------[Notificaciones Fecha]----------------------------------//
//  Future<NotificationDetails> _dateAndHour(BuildContext context, Image icon, Image picture, ) async {
//
//      final iconPath = await saveImage(context, icon);
//      final picturePath = await saveImage(context, picture);
//      final bigPictureStyleInformation  = BigPictureStyleInformation(
//        picturePath,
//        BitmapSource.FilePath,
//        largeIcon: iconPath,
//        largeIconBitmapSource: BitmapSource.FilePath,
//      );
//
//      var androidChannel = AndroidNotificationDetails(
//        'channel-id',
//        'channel-name',
//        'channel-description',
//        importance: Importance.Max,
//        priority: Priority.Max,
//        style: AndroidNotificationStyle.BigPicture,
//        styleInformation: bigPictureStyleInformation,
//      );
//      return NotificationDetails(androidChannel, null );
//    }
//    Future showDateNotification(
//        BuildContext context,
//        FlutterLocalNotificationsPlugin notifications, {
//          @required String title,
//          @required String body,
//          @required DateTime datetime,
//          @required Image icon,
//          @required Image picture,
//
//          int id = 0,
//        }) async=>
//        notifications.schedule(id, title, body, datetime, await _dateAndHour(context, icon, picture));
////--------------------------[Notificaciones con Imagen e icono]----------------------------------//
//  Future<NotificationDetails> _imageAndIcon(BuildContext context, Image icon, Image picture) async {
//    final iconPath = await saveImage(context, icon);
//    final picturePath = await saveImage(context, picture);
//
//    final bigPictureStyleInformation  = BigPictureStyleInformation(
//      picturePath,
//      BitmapSource.FilePath,
//      largeIcon: iconPath,
//      largeIconBitmapSource: BitmapSource.FilePath,
//    );
//
//    final androidPlatformChannelSpecifics  = AndroidNotificationDetails(
//      'big text channel id',
//      'big text channel name',
//      'big text channel description',
//      style: AndroidNotificationStyle.BigPicture,
//      styleInformation: bigPictureStyleInformation,
//    );
//    return NotificationDetails(androidPlatformChannelSpecifics, null );
//  }
//  Future showIconAndImageNotification(
//      BuildContext context,
//      FlutterLocalNotificationsPlugin notifications, {
//        @required String title,
//        @required String body,
//        @required Image icon,
//        @required Image picture,
////      @required NotificationDetails type,
//        int id = 0,
//      }) async=>
//      notifications.show(id, title, body, await _imageAndIcon(context, icon, picture));
//// --------------------------[Notificaciones con Imagen]----------------------------------//
//  Future<NotificationDetails> _image(BuildContext context, Image picture) async {
//    final picturePath = await saveImage(context, picture);
//    final bigPictureStyleInformation  = BigPictureStyleInformation(
//      picturePath,
//      BitmapSource.FilePath,
//    );
//
//    final androidPlatformChannelSpecifics  = AndroidNotificationDetails(
//      'silent channel id',
//      'silent channel name',
//      'silent channel description',
//      style: AndroidNotificationStyle.BigPicture,
//      styleInformation: bigPictureStyleInformation,
//    );
//    return NotificationDetails(androidPlatformChannelSpecifics, null );
//  }
//  Future showImageNotification(
//      BuildContext context,
//      FlutterLocalNotificationsPlugin notifications, {
//        @required String title,
//        @required String body,
//        @required Image picture,
////      @required NotificationDetails type,
//        int id = 0,
//      }) async=>
//      notifications.show(id, title, body, await _image(context, picture));
//
////--------------------------[Notificaciones con Icono]-------------------------------------//
//  Future<NotificationDetails> _icon(BuildContext context, Image icon) async {
//    final iconPath = await saveImage(context, icon);
//    final androidPlatformChannelSpecifics  = AndroidNotificationDetails(
//      'silent channel id',
//      'silent channel name',
//      'silent channel description',
//      largeIcon: iconPath,
//      largeIconBitmapSource: BitmapSource.FilePath,
//    );
//    return NotificationDetails(androidPlatformChannelSpecifics, null );
//  }
//
//  Future showIconNotification(
//      BuildContext context,
//      FlutterLocalNotificationsPlugin notifications, {
//        @required String title,
//        @required String body,
//        @required Image icon,
////      @required NotificationDetails type,
//        int id = 0,
//      }) async=>
//      notifications.show(id, title, body, await _icon(context, icon));
////----------------------------[Notificaciones Silenciadas]-------------------------//
//  NotificationDetails get _noSound {
//    final androidChannelSpecifics = AndroidNotificationDetails(
//      'silent channel id',
//      'silent channel name',
//      'silent channel description',
//      playSound: false,
//      ongoing: true,
//    );
//    final iOSChannelSpecifics = IOSNotificationDetails(presentSound: false);
//
//    return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
//  }
//  Future showSilentNotification(
//      FlutterLocalNotificationsPlugin notifications, {
//        @required String title,
//        @required String body,
//        int id = 0,
//      }) =>
//      _showNotification(notifications,
//          title: title, body: body, id: id, type: _noSound);
////------------------------[Notificacion en OnGoing]-------------------------------//
//
//  NotificationDetails get _ongoing {
//    final androidChannelSpecifics = AndroidNotificationDetails(
//      'your channel id',
//      'your channel name',
//      'your channel description',
//      importance: Importance.Max,
//      priority: Priority.High,
//      ongoing: true,
//      autoCancel: false,
//    );
//    final iOSChannelSpecifics = IOSNotificationDetails();
//    return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
//  }
//
//  Future showOngoingNotification(
//      FlutterLocalNotificationsPlugin notifications, {
//        @required String title,
//        @required String body,
//        int id = 0,
//      }) =>
//      _showNotification(notifications,
//          title: title, body: body, id: id, type: _ongoing);
//////----------------------------------------------------------------------------//
//  ///-----------------------[Mostrar la Notificacion]----------------------------//
//  Future _showNotification(
//      FlutterLocalNotificationsPlugin notifications, {
//        @required String title,
//        @required String body,
//        @required NotificationDetails type,
//        int id = 0,
//      }) =>
//      notifications.show(id, title, body, type);
//
//////----------------------------------------------------------------------------//
//////----------------------------------------------------------------------------///
/////----------------LO USO PARA PODER IMPLEMENTAR LAS IMAGENES-------------------//
//Future<String> saveImage(BuildContext context, Image image) {
//  final completer = Completer<String>();
//  image.image.resolve(ImageConfiguration()).addListener(ImageStreamListener((ImageInfo image, bool synchronousCall) async {
//    final byteData = await image.image.toByteData(format: ImageByteFormat.png);
////    final byData = await ImageInfo.image.toByteData(format: ImageByteFormat.png);
//    final pngBytes = byteData.buffer.asUint8List();
//
//    final fileName = pngBytes.hashCode;
//    final directory = await getApplicationDocumentsDirectory();
//    final filePath = '${directory.path}/$fileName';
//    final file = File(filePath);
//    await file.writeAsBytes(pngBytes);
//
//    completer.complete(filePath);
//  }));
//  return completer.future;
//}
//
//
//
