import 'package:flutter/material.dart';
import 'package:mongo_app/view/search_page/widget/data_card.dart';
import 'package:mongo_app/view_model/home_page_view_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  late final HomePageViewModel myState;
  CustomSearchDelegate({required this.myState});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query.isEmpty ? null : query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    myState.queryData(query);
    return QueryDataCard(
      myState: myState,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
