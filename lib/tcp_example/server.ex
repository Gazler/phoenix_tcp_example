defmodule TcpExample.Server do
  require Logger
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_) do
    port = 0
    ip = {127, 0, 0, 1}

    {:ok, listen_socket} =
      :gen_tcp.listen(port, [:binary, {:packet, 0}, {:active, true}, {:ip, ip}])
    Logger.warn(inspect(:inet.port(listen_socket)))
    {:ok, %{}, {:continue, listen_socket}}
  end

  def handle_continue(listen_socket, state) do
    {:ok, socket} = :gen_tcp.accept(listen_socket)
    config = %{
      endpoint: TcpExampleWeb.Endpoint,
      transport: :tcp,
      options: [serializer: [{Phoenix.Socket.V1.JSONSerializer, "~> 1.0.0"}]],
      params: %{},
      connect_info: []
    }
    handler = TcpExampleWeb.UserSocket
    {:ok, state} = handler.connect(config)
    {:ok, state} = handler.init(state)
    {:noreply, %{socket: socket, handler: handler, state: state}}
  end

  def handle_info({:tcp, _, packet}, state) do
    IO.inspect packet
    if String.trim(packet) != "" do
      handle_reply(state, state.handler.handle_in({packet, []}, state.state))
    else
      {:noreply, state}
    end
  end

  def handle_info(message, state) do
    IO.inspect message
    {:noreply, state}
  end

  defp handle_reply(state, {:ok, new_state}), do: {:noreply, %{state | state: new_state}}
  defp handle_reply(state, {:push, data, new_state}),
    do: handle_reply(state, {:reply, :ok, data, new_state})

  defp handle_reply(state, {:reply, _status, {:text, data}, new_state}) do
    IO.inspect data
    :gen_tcp.send(state.socket, data)
    {:noreply, %{state | state: new_state}}
  end

  defp handle_reply(state, {:stop, reason, new_state}), do: {:stop, reason, %{state | new_state: state}}
end
