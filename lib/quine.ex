defmodule Quine do
  use Maru.Router

  plug Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Poison,
    parsers: [:urlencoded, :json, :multipart]

  get "/code" do
    json conn, %{hello: :world}
  end

  get "/home" do
    html conn, """
    <html>
      <body>
        Whats up F
      </body>
    </html>
    """
  end

  rescue_from :all do
    conn
    |> put_status(404)
    |> text("Page Not Found")
  end
end
