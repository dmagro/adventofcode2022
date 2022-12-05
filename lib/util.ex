defmodule Util do
  def readFile(file_path) do
    case(File.read(file_path)) do
      {:ok, contents} -> contents
      {:error, reason} -> spawn_link fn -> exit(reason) end
    end
  end
end
