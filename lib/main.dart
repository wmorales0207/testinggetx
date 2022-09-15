import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(GetXApp());

class GetXApp extends StatelessWidget {
  //final Favorite favorite = Get.put(
    //  Favorite()); // aca se hace la injeccion de dependendencia de la clase que sera usada para mover la informacion (favorite).
  /**  Como esta es la unica clase que tendra el GETX , se puede quitar y se resolvera el problema con la linea en el unit
       * del GetBuilder 
       */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: GetBuilder<Favorite>(
            init: Favorite(),// esta linea se sustituyo por final Favorite favorite = Get.put(   ya 
            builder: (_) => Text(
                'My Favorite fruit is  ${_.fruit}'), //// aca se muestra la modificacion, se mustra el resultado de la clic del botton
          ),
        ),
        body: Center(
          child: Column(
            children: [
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              FruitButton('Aplle'),
              const Divider(
                height: 5,
                color: Colors.transparent,
              ),
              FruitButton('favorite: favorite'),
              Divider(
                height: 5,
                color: Colors.transparent,
              ),
              FruitButton('Bananas'),
            ],
          ),
        ),
      ),
    );
  }
}

class FruitButton extends StatelessWidget {
  final String fruit;

  FruitButton(this.fruit);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (() {
        /* Cuando se le da el buton el on pressed ejecuta el metodo de favorite y el update que tiene ese metodo hace que se repinte la pantalla*/
        //favorite.changeFruit(fruit);
        Get.find<Favorite>().changeFruit(
            fruit); // El Get de esta manera hace la gestion de llevar la info a la clase que tiene la logica que recbe el parametro
      }),
      child: Text(fruit),
    );
  }
}

class Favorite extends GetxController {
  // esta es la clase de la que se hereda para iimplementar GetX
  String fruit = 'unknow';

  changeFruit(String newFruit) {
    this.fruit = newFruit;

    update(); // este metodo redibuja cada vez que se llama
  }
}
