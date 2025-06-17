import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TODO',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF212121),
        canvasColor: const Color(0xFF303030),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();

  final List<String> _todoItems = [];

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "新しいTODOを入力",
                    ),
                  ),
                ),
                const SizedBox(width: 8.0,),
                TextButton(
                  onPressed: buttonPressed,
                  child: const Text("追加",
                    style: const TextStyle(
                      fontSize: 20.0, // フォントサイズを調整
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                    ),
                  ),
                  
                )
              ],
            ),
          ),
        ),
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _todoItems.length,
              itemBuilder: (BuildContext context, int index){
                final item = _todoItems[index];
                return Dismissible(
                  key : Key(item + index.toString()),
                  onDismissed: (direction){
                    setState(() {
                      _todoItems.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('"$item" を削除しました'))
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right:20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                    ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 4.0),
                    child: ListTile(
                      title: Text(
                        item, //itemsリストからひっぱってきた要素
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.grey),
                        onPressed: (){
                          setState(() {
                            _todoItems.removeAt(index); 
                          });
                        },
                      ),
                    ),
                  ),
                );
              } ),
            )
        ],
      ),
    );
  }


  void buttonPressed() {
    // TextFieldが空でないことを確認
    if (_controller.text.isNotEmpty) {
      setState(() {
        // リストに新しいTODOアイテムを追加
        _todoItems.add(_controller.text);
        // TextFieldをクリア
        _controller.clear();
      });
    }
  }
}
