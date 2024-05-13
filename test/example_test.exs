defmodule ExampleTest do
  defmodule Item do
    defstruct name: nil, sell_in: nil, quality: nil
  end

  use ExUnit.Case

  # begin-snippet: guilded_rose_example
  test "Approval test" do
    input_builder = fn %{name: name, sell_in: sell_in, quality: quality} ->
      %Item{name: name, sell_in: sell_in, quality: quality}
    end

    test_data =
      [
        name: [
          "Others",
          "Aged Brie",
          "Backstage passes to a TAFKAL80ETC concert",
          "Sulfuras, Hand of Ragnaros"
        ],
        sell_in: [-1, 0, 1, 10, 50],
        quality: [0, 1, 49, 50]
      ]
      |> ExApproval.gen_test_data_set(input_builder)

    received_output =
      update_quality(test_data)
      |> inspect(pretty: true, infinity: true)

    File.write!(Namer.received_name("ex_approval", "example", "txt", "test"), received_output)

    approved_output = File.read!(Namer.approved_name("ex_approval", "example", "txt", "test"))

    assert(
      approved_output |> String.replace("\r\n", "\n") ==
        received_output |> String.replace("\r\n", "\n")
    )
  end

  # end-snippet

  def update_quality(data), do: data
end
