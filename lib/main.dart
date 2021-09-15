import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/search_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Provider<SearchBloc>(
          create: (context) => SearchBloc(),
          dispose: (context, bloc) => bloc.dispose(),
          child: SearchPage(),
        ));
  }
}

class SearchPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController queryInputController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final searchBloc = Provider.of<SearchBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('テストアプリ'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '検索キーワード',
                    ),
                    controller: queryInputController,
                  ),
                ),
              ),
              ElevatedButton(
                child: const Text('検索'),
                onPressed: () =>
                    searchBloc.changeQuery.add(queryInputController.text),
              ),
            ]),
          ),
          StreamBuilder(
            stream: searchBloc.result,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                // snapshot..errorを使ったWidgetを返す
                return Container();
              }
              if (snapshot.data != null) {
                // snapshot.dataを使ったWidgetを返す
                return Container();
              } else {
                // 何かWidgetを返す
                return Container();
              }
            },
          )
        ]),
      ),
    );
  }
}
