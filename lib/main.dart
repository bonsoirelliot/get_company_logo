import 'package:flutter/material.dart';
import 'package:get_company_logo/search_bloc.dart';
import 'search_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final _bloc = SearchBloc();
  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get the company logo'),
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder(
              stream: _bloc.company,
              initialData: 'https://logo.clearbit.com/flutter.dev',
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Image.network(snapshot.data),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: 'Company Name',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 14,
              width: MediaQuery.of(context).size.width / 2,
              child: RaisedButton(
                onPressed: () {
                  _bloc.searchEventSink.add(SearchEvent(controller.value.text));
                },
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 20),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
