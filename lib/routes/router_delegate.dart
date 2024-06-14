import 'package:declarative_navigation/screen/form_screen.dart';
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
  bool isForm = false;

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
              toFormScreen: (){
                isForm = true;
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
          if (isForm)
            MaterialPage(
              key: const ValueKey("FormScreen"),
              child: FormScreen(
                onSend: () {
                  isForm = false;
                  notifyListeners();
                },
              ),
            )
        ],
        onPopPage: (route, result) {
          final didPop = route.didPop(result);
          if (!didPop) {
            return false;
          }

          selectedQuote = null;
          isForm = false;
          notifyListeners();

          return true;
        });
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }
}
