defmodule Fusenet.NzbTest do
  use ExUnit.Case, async: true

  test "deserialization of a valid input" do
    input = File.read!("test/nzb/test.nzb")

    result = Fusenet.Nzb.parse(input)

    expected = %{
      head: %{
        title: "Your File!",
        password: "secret",
        tag: "HD",
        category: "TV"
      },
      files: [
        %{
          subject: "Here's your file!  abc-mr2a.r01 (1/2)",
          poster: "Joe Bloggs <bloggs@nowhere.example>",
          date: "1071674882",
          groups: [
            "alt.binaries.newzbin",
            "alt.binaries.mojo"
          ],
          segments: [
            %{
              number: 1,
              bytes: 102_394,
              path: "123456789abcdef@news.newzbin.com"
            },
            %{
              number: 2,
              bytes: 4501,
              path: "987654321fedbca@news.newzbin.com"
            }
          ]
        },
        %{
          subject: "Here's your file!  abc-mr2a.r02 (1/2)",
          poster: "Joe Bloggs <bloggs@nowhere.example>",
          date: "1071674882",
          groups: [
            "alt.binaries.newzbin",
            "alt.binaries.mojo"
          ],
          segments: [
            %{
              number: 1,
              bytes: 102_393,
              path: "123456799abcdef@news.newzbin.com"
            },
            %{
              number: 2,
              bytes: 4502,
              path: "987654329fedbca@news.newzbin.com"
            }
          ]
        }
      ]
    }

    assert(result == expected)
  end
end
