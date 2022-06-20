import SweetXml
alias SweetXml

defmodule Fusenet.Nzb do
  def parse(input) do
    xml = input |> xpath(~x"//nzb")

    %{
      head: xml |> xpath(~x"./head") |> extract_headers(),
      files: xml |> xpath(~x"./file"l) |> extract_files()
    }
  end

  defp extract_headers(header) do
    %{
      title: header |> xpath(~x"./meta[@type='title']/text()"s),
      password: header |> xpath(~x"./meta[@type='password']/text()"s),
      tag: header |> xpath(~x"./meta[@type='tag']/text()"s),
      category: header |> xpath(~x"./meta[@type='category']/text()"s)
    }
  end

  defp extract_files(files) do
    files
    |> Enum.map(fn li ->
      segments =
        li
        |> xpath(~x"./segments/segment"l)
        |> Enum.map(fn li2 ->
          %{
            path: li2 |> xpath(~x"./text()"s),
            bytes: li2 |> xpath(~x"./@bytes"i),
            number: li2 |> xpath(~x"./@number"i)
          }
        end)

      %{
        subject: li |> xpath(~x"./@subject"s),
        poster: li |> xpath(~x"./@poster"s),
        date: li |> xpath(~x"./@date"s),
        segments: segments,
        groups: li |> xpath(~x"groups/group/text()"ls)
      }
    end)
  end
end
