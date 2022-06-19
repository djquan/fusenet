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

        %{
          subject: li |> xpath(~x"./@subject"s),
          poster: li |> xpath(~x"./@poster"s),
          date: li |> xpath(~x"./@date"s),
          segments: segments,
          groups: li |> xpath(~x"groups/group/text()"ls)
        }
      end)

    %{
      head: meta,
      files: files
    }
  end
end
