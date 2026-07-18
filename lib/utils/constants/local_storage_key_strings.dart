//
import 'package:flutter/widgets.dart';

class LocalStorageKeyStrings {
      const LocalStorageKeyStrings._();

    /// Key used to store and retrieve the user's login status in local storage.
  static const isLogin = 'isLogin';
  static const accessToken = 'accessToken';
  static const loggedInUserId = 'loggedInUserId';
  static const refreshToken = 'refreshToken';
  static const loginResp = 'loginResp';
  static const clientId='clientId';
  static const userName='userName';
  static const clientName='clientName';
  static const clientLogo='clientLogo';
  static const searchManagerName='searchManager';
  static const searchManagerId='searchManagerId';
  static const userRole='userRole';
  static const profileImage='profileImage';
  static const shiftId='shiftId';
  static const shiftName='shiftName';
  static const roleId='roleId';
  static const roleName='roleName';
  static const designationName='designationName';
  static const admissionId='admissionId';
  static const tripsId='tripId';
  static const hostelAddmissionId='hostelAddmissionId';
  static const tripType='tripType';
  static const currentRouteStopIndex='currentRouteStopIndex';
  static const isRemoteLocation='isRemoteLocation';
  static const userProfile = 'userProfile';

  static GlobalKey<NavigatorState> appNavKey = GlobalKey<NavigatorState>();
}