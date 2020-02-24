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

File.stream!("ratings_small.csv") 
	|> CSV.decode! 
	|> Enum.take(254) # => [[customer, movie, ...], [customer, movies, ...] ]
	|> List.foldl(%{}, fn x, acc -> Similarity.add_viewer(acc, Enum.at(x, 1), Enum.at(x, 0)) end)
	|> Util.print_map(&Util.print_set/1)
	|> IO.puts