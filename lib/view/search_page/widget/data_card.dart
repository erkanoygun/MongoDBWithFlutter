import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/home_page_view_model.dart';

class QueryDataCard extends StatelessWidget {
  const QueryDataCard({Key? key, required this.myState}) : super(key: key);
  final HomePageViewModel myState;
  static const String dataNotFoundText = "Data Not Found";

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageViewModel>(
      builder: (context, value, child) {
        return value.isDataLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : value.queryAllData.isNotEmpty
                ? ListView.builder(
                    itemCount: value.queryAllData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                "${value.queryAllData[index].name} ${value.queryAllData[index].surname}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                value.queryAllData[index].number,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(dataNotFoundText),
                  );
      },
    );
  }
}
