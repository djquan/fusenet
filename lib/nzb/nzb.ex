import SweetXml
alias SweetXml

defmodule Fusenet.Nzb do
  def parse(input) do
    xml = input |> xpath(~x"//nzb")

    meta = %{
      title: xml |> xpath(~x"./head/meta[@type='title']/text()"s),
      password: xml |> xpath(~x"./head/meta[@type='password']/text()"s),
      tag: xml |> xpath(~x"./head/meta[@type='tag']/text()"s),
      category: xml |> xpath(~x"./head/meta[@type='category']/text()"s)
    }

    files =
      xml
      |> xpath(~x"./file"l)
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

        IO.inspect(segments)

        %{
          subject: li |> xpath(~x"./@subject"s),
          segments: segments
        }
      end)

    %{
      head: meta,
      files: files
    }
  end
end
