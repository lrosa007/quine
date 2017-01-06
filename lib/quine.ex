defmodule Quine do
  use Maru.Router

  plug Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Poison,
    parsers: [:urlencoded, :json, :multipart]

  get "/code" do
    json conn, %{code: File.read! "lib/quine.ex" }
  end

  get "/home" do
    html conn, home_page
  end

  rescue_from :all do
    conn
    |> put_status(404)
    |> text("Page Not Found")
  end

  defp home_page do
    """
    <html>
      <head>
      </head>
      <body>
        <h1>Maru Quine</h1>

        <p>Take home code challenge for Kipu</p>

        <h2>Intro</h2>

        <p>Hello, I am a server hosted on heroku. The micro-framework used in my creation was <a href="https://github.com/elixir-maru/maru)">Maru</a>.
        This mini app only has two routes <code>/code</code> and <code>/home</code>. The first route simply returns
        some JSON containing the source code for this app and the second route displays this page
        you are looking at right now.</p>

        <h2>Source Code:</h2>
        <main>
          <pre>
            <code id="code" class="elixir">
            </code>
          <pre>
        </main>

        <script>
          document.getElementById("code").append("something");
        </script>
      </body>
    </html>
    """
  end
end
