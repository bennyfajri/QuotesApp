import 'package:flutter/material.dart';

import '../model/quote.dart';
import '../screen/quote_detail_screen.dart';
import '../screen/quotes_list_screen.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  String? selectedQuote;

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        pages: [
          MaterialPage(
            key: const ValueKey("QuotesListPage"),
            child: QuotesListScreen(
              quotes: quotes,
              onTapped: (quoteId) {
                selectedQuote = quoteId;
                notifyListeners();
              },
            ),
          ),
          if (selectedQuote != null)
            MaterialPage(
              key: ValueKey("QuotesDetailPage-$selectedQuote"),
              child: QuoteDetailsScreen(
                quoteId: selectedQuote!,
              ),
            ),
        ],
        onPopPage: (route, result) {
          final didPop = route.didPop(result);
          if (!didPop) {
            return false;
          }

          selectedQuote = null;
          notifyListeners();

          return true;
        });
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }
}
