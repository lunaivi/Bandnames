import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 4),
    Band(id: '3', name: 'Heroes de silencio', votes: 2),
    Band(id: '4', name: 'Bon Jovi', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'BandNames',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Center(
        child: ListView.builder(
            itemCount: bands.length,
            itemBuilder: (context, i) => _bandTile(bands[i])),
      ),
      //este botton es para  agragar elementos al listado
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addNewBand();
        },
      ),
    );
  }

//lista de bandtile
  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),

      direction: DismissDirection
          .startToEnd, //Esto es  para bloque la direcion en el dismissible
      onDismissed: (direction) {
        // este es un metodo que se dispara con el argumentos
        print('direction: $direction');
        print('id: ${band.id}');
        print('name: ${band.name}');
        print('votes: ${band.votes}');

        //TODO: llamar el borrado en el server
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          // Align es para elinear el text el container
          alignment: Alignment.centerLeft,
          child: Text(
            'Delete Band',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

//metodo addNewBand
  addNewBand() {
//TextEditingController(); :es para obteene informacion del Textfield
    final textController = new TextEditingController();
    if (Platform.isAndroid
        // == Platform.isIOS
        ) {
      //Platform.isAndroid:es para flutter decte el sistema operativo del si
      //android
      showDialog(
          //este es un mensaje que sala al presiona el botom +
          context: context,
          builder: (context) {
            //alecrtDialog es la el dialogo
            return AlertDialog(
              title: const Text('new  band name:'),
              content: TextField(
// Controla el texto que se está editando. Si es nulo, este widget creará su propio [TextEditingController
                controller: textController,
              ),

              //actions es para la accion
              actions: <Widget>[
                //Crea un botón de Material Design.
// Para crear un botón de Material personalizado, considere usar [TextButton],
// [ElevatedButton] o [OutlinedButton].

// Los argumentos [autofocus] y [clipBehavior] no deben ser nulos. Además, [elevation],
// [hoverElevation], [focusElevation],[highlightElevation] y [disabledElevation]
// no deben ser negativos, si se especifica.

                MaterialButton(
                    child: const Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addBandTolist(textController.text)

                    // cuando usar la variable  el atributo TextEditingController(); para usar  cuando ya halla caturado datos del textfield
                    //utilisa el punto text para usar la variable ejemplo print(textController.text);
                    // print(textController.text);

                    ),
              ],
            );
          });
    } else {
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: const Text('New band name: '),
              content: CupertinoTextField(
                //en cupertino a la variable textController no que poner punto .text
                controller: textController,
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () => addBandTolist(textController.text),
                  child: Text('Add'),
                ),
                CupertinoDialogAction(
                  //esto es para cerrar el alertdialoge
                  isDestructiveAction: true,
                  child: const Text('Dismiss'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    }
    ;
  }

//
  void addBandTolist(String name) {
    print(name);
    if (name.length > 1) {
      //podenmos agraga
      this.bands.add(
            new Band(
              id: DateTime.now().toString(),
              name: name,
              votes: 0,
            ),
          );
    }
    ;
//Navigator.pop(context); es para cerrar el dialogo
    Navigator.pop(context);
  }
}
