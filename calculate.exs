defmodule Similarity do
	def add_viewer(map, movie, viewer) do
		current_set = Map.get(map, movie)
		case current_set do
			nil -> 
				viewer_set = MapSet.new([viewer])
				Map.put(map, movie, viewer_set)
			_ -> 
				viewer_set = MapSet.put(current_set, viewer)
				Map.replace!(map, movie, viewer_set)
		end
	end

	def cosine(set_a, set_b) do
		intersection_size = 
			MapSet.intersection(set_a, set_b)
			|> MapSet.size()
		intersection_size / ( :math.sqrt(MapSet.size(set_a)) * :math.sqrt(MapSet.size(set_b)) )
	end
end

defmodule Util do
	def print_set (map) do
		MapSet.to_list(map)
		|> Enum.join(", ")
	end

	def print_map(map, f) do
		Enum.map(map, fn {k, v} -> "\n" 
			<> to_string(k) 
			<> ": " 
			<> to_string(f.(v)) end)
		|> Enum.join(" ")

	end
end

map = File.stream!("ratings_test.csv") 
	|> CSV.decode! 
	|> Enum.take(23) # => [[customer, movie, ...], [customer, movies, ...] ]
	|> List.foldl(%{}, fn x, acc -> Similarity.add_viewer(acc, Enum.at(x, 1), Enum.at(x, 0)) end)

map |> Util.print_map(&Util.print_set/1)
	|> IO.puts


IO.puts "\n--------------------"
a = MapSet.new([1, 2, 3])
b = MapSet.new([2, 3, 4, 5])
Similarity.cosine(a, b) |> IO.puts


IO.puts "\n--------------------"
