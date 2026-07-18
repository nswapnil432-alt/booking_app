import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/local_storage_key_strings.dart';

class NetworkConnectivityService {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isDialogShowing = false;
  bool _isInitialized = false;
  Timer? _delayTimer;

  void initialize(BuildContext context) {
    // Add delay to ensure MaterialApp is fully loaded
    _delayTimer = Timer(const Duration(seconds: 2), () {
      _isInitialized = true;
      // Check initial connectivity after delay
      _checkInitialConnectivity();

      // Listen to connectivity changes
      _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
        (List<ConnectivityResult> results) {
          _handleConnectivityChange(results);
        },
      );
    });
  }

  Future<void> _checkInitialConnectivity() async {
    try {
      final List<ConnectivityResult> results =
          await Connectivity().checkConnectivity();
      _handleConnectivityChange(results);
    } catch (e) {
      // LoggerService.log('Error checking initial connectivity: $e');
    }
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) {
    if (!_isInitialized) return;

    // Check if any of the results indicate connectivity
    bool hasConnection = results.any((result) => result != ConnectivityResult.none);

    if (!hasConnection) {
      // Add small delay to ensure we have proper context
      Future.delayed(const Duration(milliseconds: 500), () {
        _navigateToNoNetworkScreen();
      });
    } else {
      _returnFromNoNetworkScreen();
    }
  }

  void _navigateToNoNetworkScreen() {
    if (_isDialogShowing || !_isInitialized) return;

    // Get context from global navigation key
    final BuildContext? context = LocalStorageKeyStrings.appNavKey.currentContext;
    if (context == null || !context.mounted) return;

    _isDialogShowing = true;
    // context.push(AppRoutes.noInternet);
  }

  void _returnFromNoNetworkScreen() {
    if (!_isDialogShowing) return;

    final BuildContext? context = LocalStorageKeyStrings.appNavKey.currentContext;
    if (context == null || !context.mounted) return;

    try {
      // Safely pop only if the current route is the no-internet screen
      final router = GoRouter.of(context);
      final currentLocation = router.routerDelegate.currentConfiguration.last.matchedLocation;
      
      // if (currentLocation == AppRoutes.noInternet) {
      //   context.pop();
      // }
      
      _isDialogShowing = false;
      
      // Show success message when connection is restored
      Future.delayed(const Duration(milliseconds: 300), () {
        _showConnectionRestoredMessage();
      });
    } catch (e) {
      _isDialogShowing = false;
    }
  }

  void _showConnectionRestoredMessage() {
    final BuildContext? context = LocalStorageKeyStrings.appNavKey.currentContext;
    if (context == null || !context.mounted) return;

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.wifi, color: Colors.white),
              SizedBox(width: 8),
              Text('Internet connection restored'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } catch (e) {
      // Error showing snackbar
    }
  }


  void dispose() {
    _delayTimer?.cancel();
    if (_isInitialized) {
      _connectivitySubscription.cancel();
    }

    _isInitialized = false;
  }
}
