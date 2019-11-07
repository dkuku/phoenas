defmodule NasWeb.PageController do
  use NasWeb, :controller

  def index(conn, _params) do
    home = Path.expand("~")
    {:ok, files} = File.ls(home)

    render(conn, "index.html", path: home, files: files)
  end
  
  def show(conn, %{"name" => name, "path" => path}) do
    
    full_path = path <> "/" <> name
    case File.dir?(full_path) do
      true -> 
        {:ok, files} = File.ls(full_path)
        render(conn, "index.html", files: files, path: full_path)
      _ -> 
    conn 
    |> put_resp_header("content-disposition", 
                       ~s(attachment; filename="#{name}"))
    |> send_file(200, full_path)
        #file = File.read!(name)
        #render(conn, "show.html", file: file)
    end
  end
end
