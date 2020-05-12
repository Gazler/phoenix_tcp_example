# TcpExample

Example of a raw TCP handler for Phoenix channels.

The server is located at `lib/tcp_example/server.ex`

Start with `iex -S mix phx.server`, the tcp port will be output in a log warning.

Navigate to http://localhost:4000 and open the developer console.

You can connect to the TCP socket using telnet:

```
telnet 127.0.0.1 THE_PORT_NUMBER
```

Use the following message to join a Phoenix channel:

```
{"topic": "topic:subtopic", "event": "phx_join", "payload": {}, "ref": "1", "join_ref": "1"}
```

Use the following message to broadcast an event:

```
{"topic": "topic:subtopic", "event": "shout", "payload": {"message": "weee"}, "ref": "2", "join_ref": "1"}
```

The messages will be logged in the JavaScript console of the browser.


If the TCP socket crashes, a new port number will be assigned.
