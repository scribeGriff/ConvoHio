part of convohio;

/* ****************************************************** *
 *   Class _Export saves data to a file or sends the data *
 *   to the web using a websocket.                        *
 *   Library: ConvoHio (c) 2012 scribeGriff               *
 * ****************************************************** */

//Save data to a file.
void exportToFile(var data, String filename) =>
    new _Export(data).toFile(filename);

//Send data to a websocket.
void exportToWeb(var data, String host, int port) =>
    new _Export(data).toWeb(host, port);

class _Export {

  Map mapData;
  List listData;
  bool isMap = false;
  bool isComplex = false;

  _Export(var data) {

    if (data.runtimeType == Map) {
      isMap = true;
      mapData = data;
    } else if (data.runtimeType == List) {
      listData = data;
      if (data.every(f(element) => element is Complex)) {
        isComplex = true;
      }
    } else {
      print("Data must be of type List or Map");
      return;
    }
  }

  void toFile(String filename) {

    List<String> tokens = filename.split(new RegExp(r'\.(?=[^.]+$)'));
    if (tokens.length == 1) tokens.add('txt');
    if (isMap) {
      mapData.forEach((k, v) {
        File fileHandle = new File('${tokens[0]}_k$k.${tokens[1]}');
        RandomAccessFile dataFile = fileHandle.openSync(FileMode.WRITE);
        // TODO this is specific to the format of psums from fsps().
        // Needs to be more general.
        for (var i = 0; i < mapData[k].length; i++) {
          dataFile.writeStringSync('${mapData[k][i].real}\t'
              '${mapData[k][i].imag}\n');
        }
        dataFile.closeSync();
      });
    } else {
      File fileHandle = new File('${tokens[0]}_data.${tokens[1]}');
      RandomAccessFile dataFile = fileHandle.openSync(FileMode.WRITE);
      if (isComplex) {
        for (var i = 0; i < listData.length; i++) {
          listData[i] = listData[i].cround2;
          dataFile.writeStringSync("${listData[i].real}\t${listData[i].imag}\n");
        }
      } else {
        for (var i = 0; i < listData.length; i++) {
          dataFile.writeStringSync('${listData[i]}\n');
        }
      }
      dataFile.closeSync();
    }
  }

  void toWeb(String host, int port) {

    //connect with ws://localhost:8080/ws
    //for echo - http://www.websocket.org/echo.html
    if (host == 'local') host = '127.0.0.1';

    HttpServer _server = new HttpServer();
    WebSocketHandler _wsHandler = new WebSocketHandler();
    _server.addRequestHandler((req) => req.path == "/ws", _wsHandler.onRequest);

    // Open the connection.
    _wsHandler.onOpen = (WebSocketConnection wsConn) {
      print('Opening connection at $host:$port');

      // Receive message and send reply.
      wsConn.onMessage = (message) {
        var msg = JSON.parse(message);
        print("Received the following message: \n"
            "${msg["request"]}\n${msg["date"]}");
        if (isMap) {
          wsConn.send(JSON.stringify(mapData));
        } else {
          if (isComplex) {
            List real = new List(listData.length);
            List imag = new List(listData.length);
            for (var i = 0; i < listData.length; i++) {
              listData[i] = listData[i].cround2;
              real[i] = listData[i].real;
              imag[i] = listData[i].imag;
            }
            wsConn.send(JSON.stringify({"real": real, "imag": imag}));
          } else {
            wsConn.send(JSON.stringify({"real": listData, "imag": null}));
          }
        }
      };

      // Close the connection.
      wsConn.onClosed = (int status, String reason) {
        print('Connection closed: Status - $status : Reason - $reason');
      };
    };

    _server.listen(host, port);
  }
}
