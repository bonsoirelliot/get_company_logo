import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'search_event.dart';

class SearchBloc {
  String name;
  final _searchStateController = StreamController<String>();
  StreamSink<String> get _inSearch => _searchStateController.sink;
  // For state, exposing only a stream which outputs data
  Stream<String> get company => _searchStateController.stream;

  final _searchEventController = StreamController<SearchEvent>();
  Sink<SearchEvent> get searchEventSink => _searchEventController.sink;

  SearchBloc() {
    _searchEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(SearchEvent event) async {
    String name = event.name;
    String _url =
        'https://autocomplete.clearbit.com/v1/companies/suggest?query=$name';
    var response = await http.get(_url);

    try {
      String logo = json.decode(response.body)[0]['logo'] as String;
      _inSearch.add(logo);
    } catch (error) {
      print(error);
    }
  }
}
