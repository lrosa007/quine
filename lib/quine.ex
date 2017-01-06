defmodule Quine do
  use Maru.Router

  plug Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Poison,
    parsers: [:urlencoded, :json, :multipart]

  get "/code" do
    conn
    |> put_status(200)
    |> json(%{code: File.read! "lib/quine.ex" })
  end

  get "/home" do
    conn
    |> put_status(200)
    |> html(home_page)
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/fetch/2.0.1/fetch.min.js"></script>
      </head>
      <body>
        <h1>Maru Quine</h1>

        <p>Take home code challenge for Kipu</p>

        <h2>Intro</h2>

        <p>Hello, I am a server hosted on heroku. The micro-framework used in my creation was <a href="https://github.com/elixir-maru/maru)">Maru</a>.
        I only have two routes <code>/code</code> and <code>/home</code>. The first route simply returns
        some JSON containing my source code and the second route displays this page you are looking at right now.</p>

        <main>
          <div id="countdown">
          </div>
          <pre>
            <code id="code" class="elixir">
            </code>
          </pre>
        </main>

        <script>
          const request = (url, options) =>
            fetch(url, options)
              .then(checkStatus)
              .then(parseJSON)
              .then((data) => document.getElementById("code").textContent = data.code)
              .catch((err) => { err });

          const parseJSON = (response) => response.json()

          const checkStatus = (response) => {
            if (response.status >= 200 && response.status < 300) {
              return response;
            }

           const error = new Error(response.statusText);
           error.response = response;
           throw error;
          }

          const counter = (n) => {
            let counterDiv = document.getElementById("countdown");

            if (n == 0) {
              counterDiv.textContent = "";
              request("http://localhost:8000/code");
              return;
            }

            counterDiv.textContent = n;

            setTimeout(() => {
              counter(n-1);
            }, 1000);
          }

          counter(3);
        </script>
      </body>
    </html>
    """
  end
end
