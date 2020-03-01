import 'package:flutter/material.dart';

class MenuEjercicios extends StatefulWidget {
  @override
  _MenuEjerciciosState createState() => _MenuEjerciciosState();
}

class _MenuEjerciciosState extends State<MenuEjercicios> with SingleTickerProviderStateMixin {

  var cards = [
//  Color(0xfffd5d51)
    CuponCard(index: 0, color1: Colors.amber, color2: Color(0xfffd5d51) , cuponImage: "assets/images/brazo-mancuernas.jpg", cuponTitle: "Brazo", cuponDetails: "ejercicio n1 hacer mancuernas", cuponCode: "pesa2020", cuponValid: "until now",),
    CuponCard(index: 1, color1: Colors.blueGrey, color2: Color(0xFF33ddff), cuponImage: "assets/images/bailarina-alegre.jpg", cuponTitle: "Bailar", cuponDetails: "bailar es lo mejor que hay", cuponCode: "pesa2020", cuponValid: "until now"),
  ];
  int currentIndex;
  AnimationController controller;
  CurvedAnimation curvedAnimation;
  Animation<Offset> animation;
  @override
  void initState() {
    super.initState();
    currentIndex =0;
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    curvedAnimation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    animation = Tween(begin: Offset(0.0, 0.05), end: Offset(0.0, 0.0)).animate(curvedAnimation);


  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Stack(
            overflow: Overflow.visible,
            children: cards.reversed.map((card){
              if(cards.indexOf(card)<=2){
                  return GestureDetector(
                    onHorizontalDragEnd: cuponDrag,
                    child: FractionalTranslation(
                      translation: stackedCard(card),
                      child: card,
                    ),
                  );
                } else {
                  return Container();
                }
            }).toList(),
          ),
      ),
    );
  }


  void cuponDrag(DragEndDetails details) {
    controller.reverse().whenComplete((){
      setState(() {
        controller.reset();
        CuponCard removedCard = cards.removeAt(0);
        cards.add(removedCard);
        currentIndex = cards[0].index;
      });

    });
  }
//
  Offset stackedCard(CuponCard card) {
    int diff = card.index - currentIndex;
    if( card.index == currentIndex+1){
      return animation.value;
    }else if (diff>0 && diff<=2) {
      return Offset(0.0, 0.05 * diff);
    }else{
      return Offset(0.0, 0.0);
    }
  }
}
//
//
//
class CuponCard extends StatelessWidget {
  final int index;
  final Color color1,color2;
  final String cuponImage, cuponTitle, cuponDetails, cuponCode, cuponValid;

  CuponCard({this.index, this.color1, this.color2, this.cuponImage,
    this.cuponTitle, this.cuponDetails, this.cuponCode, this.cuponValid});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(0.0),
        topRight: Radius.circular(20.0),
        bottomLeft: Radius.circular(00.0),
        bottomRight: Radius.circular(30.0),
      ),
      child: Container(
        width: 300.0,
        height: 400.0,
        decoration: BoxDecoration(
            gradient: new LinearGradient(colors: [color1,color2],begin: Alignment.centerRight, end: new Alignment(-1.0, -1.0),)
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: CircleAvatar(
                backgroundColor: color1,
//                backgroundImage: NetworkImage(cuponImage),
                backgroundImage: AssetImage(cuponImage),
                radius: 75.0,
              ),
            ),
            SizedBox(height: 20.0,),
            Container(child: Text(cuponTitle, style: TextStyle( color: Colors.white,fontWeight: FontWeight.bold, fontSize: 24.0))),
            SizedBox(height: 20.0,),
            Padding(padding: const EdgeInsets.only(left: 30.0, right: 8.0),
                child: Text(cuponDetails, style: TextStyle( color: Colors.white,fontWeight: FontWeight.bold, fontSize: 10.0))),
            SizedBox(height: 10.0,),
            Divider(color: Colors.blueGrey,),
            Container(child: Text(cuponCode, style: TextStyle( color: Colors.white,fontWeight: FontWeight.bold, fontSize: 10.0))),
            SizedBox(height: 10.0,),
            Container(child: Text(cuponValid, style: TextStyle( color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20.0))),

          ],
        ),

      ),
    );
  }
}