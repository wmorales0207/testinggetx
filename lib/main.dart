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
          title: GetX<Favorite>(
              init: Favorite(),
              builder: (_) => Text(
                  'The fruit is ${_.fruit.value.name}') // de esta manera se hace referencia al dato que viene de

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
  final fruit = Fruit().obs; //

  changeFruit(String newFruit) {
    fruit.update((thisfruit) {
      thisfruit!.name = newFruit;
    });
  }
}

/**Para implementar un OSB un obs es necesario la creacion de un clase o modelo   mueva la informacion , especie de DTO  
 * en la clase favorite que es quien tiene la logica que se implementa el OBS*(observer) que es el objeto que trnasportara la informacion. y 
 * por otro lado se implementa wel GetX que captura y muentra la inforacion osea el resultado la logica 
 * 
 * Por lo que entiendo exisen 3 Objetos u operaciones que permiten la injeccion de dependencia o el uso de GETX
 * 
 * Uses a callback to update [value] internally, similar to [refresh], but provides the current value 
 * as the argument. Makes sense for custom Rx types (like Models).
 * 
 * 1 - Una clase modelo que contenga la info que se va a mover
 * 2 Una clase que instenacie esa clase modelo o asigne de la siguente forma final fruit = Fruit().obs , se hace la llamada 
 * al update fruit.update((thisfruit) {
      thisfruit!.name = newFruit;
    })
    y el valor de la clase modeloo se actualiza

 * 3-  en el lugar donde se dese mostra el resultado se hace la llamdad de la siguente manera 
 * GetX<Favorite>(
              init: Favorite(),
              builder: (_) => Text(
                  'The fruit is ${_.fruit.value.name}')
                  usando el value.Propiedad de la clase modelo.. que es donde esta el dato actualizado
*/
class Fruit {
  String name;
  Fruit({this.name = 'Unknow'});
}
