if Code.ensure_loaded?(Plug) do
  defmodule Cldr.Plug.SetSession do
    @moduledoc """
    Sets a session key for the CLDR locale.

    The session
    key is fixed to be `cldr_locale` in order that downstream
    functions like those in `liveview` don't have to
    be passed options.

    ## Examples

        # Define a router module that
        # sets the locale for the current process
        # and then also sets it in the session
        defmodule MyAppWeb.Router do
          use MyAppWeb, :router

          pipeline :browser do
            plug :accepts, ["html"]
            plug :fetch_session
            plug Cldr.Plug.SetLocale,
        	    apps: [:cldr, :gettext],
        	    from: [:path, :query],
        	    gettext: MyApp.Gettext,
        	    cldr: MyApp.Cldr
            plug Cldr.Plug.SetSession
            plug :fetch_flash
            plug :protect_from_forgery
            plug :put_secure_browser_headers
          end
        end

    """

    import Plug.Conn
    alias Cldr.Plug.SetLocale

    @doc false
    def init(_options) do
      []
    end

    @doc false
    def call(conn, _options) do
      case SetLocale.get_cldr_locale(conn) do
        %Cldr.LanguageTag{cldr_locale_name: cldr_locale} ->
          conn
          |> fetch_session()
          |> put_session(SetLocale.session_key(), cldr_locale)

        _other ->
          conn
      end
    end
  end
end
