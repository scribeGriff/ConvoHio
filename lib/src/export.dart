// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/ConvoWeb
// All rights reserved.  Please see the LICENSE.md file.

part of convohio;

/**
 *   Class _Export saves data to a file or sends the data
 *   to the web using a websocket.
 */

//Save data to a file.
void exportToFile(var data, String filename) =>
    new _Export(data).toFile(filename);

//Send data to a websocket.
void exportToWeb(var data, String host, int port) =>
    new _Export(data).toWeb(host, port);

class _Export {

  HashMap mapData;
  List listData;
  bool isMap = false;
  bool isComplex = false;

  _Export(var data) {
    if (data.runtimeType == HashMap) {
      isMap = true;
      mapData = data;
    } else if (data.runtimeType == List) {
      listData = data;
      if (data.every((element) => element is Complex)) {
        isComplex = true;
      }
    } else {
      throw new ArgumentError("input data is not valid.");
    }
  }

  void toFile(String filename) {
    List<String> tokens = filename.split(new RegExp(r'\.(?=[^.]+$)'));
    if (tokens.length == 1) tokens.add('txt');
    if (isMap) {
      mapData.forEach((k, v) {
        File fileHandle = new File('${tokens[0]}_k$k.${tokens[1]}');
        IOSink dataFile = fileHandle.openWrite();
        // TODO this is specific to the format of psums from fsps().
        // Needs to be more general.
        for (var i = 0; i < mapData[k].length; i++) {
          dataFile.write('${mapData[k][i].real}\t'
              '${mapData[k][i].imag}\n');
        }
        dataFile.close();
      });
    } else {
      File fileHandle = new File('${tokens[0]}_data.${tokens[1]}');
      IOSink dataFile = fileHandle.openWrite();
      if (isComplex) {
        for (var i = 0; i < listData.length; i++) {
          listData[i] = listData[i].cround2;
          dataFile.write("${listData[i].real}\t${listData[i].imag}\n");
        }
      } else {
        for (var i = 0; i < listData.length; i++) {
          dataFile.write('${listData[i]}\n');
        }
      }
      dataFile.close();
    }
  }

  void toWeb(String host, int port) {
    //connect with ws://localhost:8080/ws
    //for echo - http://www.websocket.org/echo.html
    if (host == 'local') host = '127.0.0.1';
    HttpServer.bind(host, port).then((server) {
      print('Opening connection at $host:$port');
      server.transform(new WebSocketTransformer()).listen((WebSocket webSocket) {
        webSocket.listen((message) {
          var msg = JSON.decode(message);
          print("Received the following message: \n"
                "${msg["request"]}\n${msg["date"]}");
          if (isMap) {
            webSocket.add(JSON.encode(mapData));
          } else {
            if (isComplex) {
              List real = new List(listData.length);
              List imag = new List(listData.length);
              for (var i = 0; i < listData.length; i++) {
                listData[i] = listData[i].cround2;
                real[i] = listData[i].real;
                imag[i] = listData[i].imag;
              }
              webSocket.add(JSON.encode({"real": real, "imag": imag}));
            } else {
              webSocket.add(JSON.encode({"real": listData, "imag": null}));
            }
          }
        },
        onDone: () {
            print('Connection closed by client: Status - ${webSocket.closeCode}'
                ' : Reason - ${webSocket.closeReason}');
            server.close();
        });
      });
    });
  }
}

