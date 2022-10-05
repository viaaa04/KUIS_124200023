import 'package:flutter/material.dart';
import 'package:kuis_groceries/detail_belanjaan.dart';
import 'package:kuis_groceries/model/groceries.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Groceries"),
        backgroundColor: Colors.purple,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
          if (constraint.maxWidth <= 600) {
            return GroceryList();
          } else if (constraint.maxWidth <= 1200) {
            return GroceryGrid(gridCount: 3);
          } else {
            return GroceryGrid(gridCount: 4);
          }
        },
      ),
    );
  }
}

class GroceryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final Groceries place = groceryList[index];
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailScreen(place: place);
            }));
          },
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(flex: 1, child: Image.asset(place.productImage)),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            place.name,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(place.storeName)
                        ],
                      ),
                    ))
              ],
            ),
          ),
        );
      },
      itemCount: groceryList.length,
    );
  }
}

class GroceryGrid extends StatelessWidget {
  final int gridCount;

  GroceryGrid({required this.gridCount});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        isAlwaysShown: true,
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: GridView.count(
            crossAxisCount: gridCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: groceryList
                .map((place) => InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return DetailScreen(place: place);
                    }));
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                        child: Image.asset(
                          place.stock,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        place.name,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Text(place.storeName),
                    )
                  ],
                ),
              ),
            ))
                .toList(),
          ),
        ));
  }
}
