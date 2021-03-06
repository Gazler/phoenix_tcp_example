defmodule TcpExampleWeb.UserSocket do
  use Phoenix.Socket

  #doc
  """
  {"topic": "topic:subtopic", "event": "phx_join", "payload": {}, "ref": "1", "join_ref": "1"}
  ["topic:", "topic:subtopic", "event": "shout", "payload": {"message": "test"}, "ref": "2", "join_ref: "1"]
  """

  ## Channels
  channel "topic:*", TcpExampleWeb.RoomChannel
  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  @impl true
  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     TcpExampleWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  @impl true
  def id(_socket), do: nil
end
