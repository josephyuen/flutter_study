import 'package:flutter/material.dart';
import 'package:flutter_study/common/style/GSYStyle.dart';
import 'package:flutter_study/utils/CommonUtils.dart';
import 'package:flutter_study/widget/ClickEffectImage.dart';

class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ExpansionTile'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ),
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);
  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Chapter A',
    <Entry>[
      Entry(
        'Section A0',
        <Entry>[
          Entry('Item A0.1'),
          Entry('Item A0.2'),
          Entry('Item A0.3'),
        ],
      ),
      Entry('Section A1'),
      Entry('Section A2'),
    ],
  ),
  Entry(
    'Chapter B',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      ),
    ],
  ),
  Entry(
     'Chapter X',
     <Entry>[] 
  )

];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return new Container(
        margin: EdgeInsets.only(top: 15.0, left: 20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ClickEffectImage(
                  width: 20.0,
                  height: 20.0,
                  assetsImgPath: GSYICons.IC_TODO_REC,
                  onClick: (){CommonUtils.showToast(infoMsg: "点击了完成按钮，😃😃😃");},
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(root.title, style: TextStyle(fontSize: 16.0)),
                  ),
                  flex: 1,
                ),
                ClickEffectImage(
                  width: 20.0,
                  height: 20.0,
                  assetsImgPath: GSYICons.IC_DELETE,
                  onClick: () {
                    // _deleteCurTodo(index);
                  },
                ),
                SizedBox(width: 20.0,)
              ],
            ),
            SizedBox(height: 10.0,),
            Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0),
              child: Align(
                alignment: Alignment.topLeft,
                // child: Text(
                //    item.content,
                //   style: TextStyle(color: Colors.black, fontSize: 15.0),
                // ),
              ),
            ),
          ],
        ),
      );
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

void main() {
  runApp(ExpansionTileSample());
}
