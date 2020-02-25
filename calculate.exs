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
			|> Float.round(2)
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

map = File.stream!("popular_movie_ratings.csv") 
	|> CSV.decode! 
	|> Enum.take(13295) # => [[customer, movie, ...], [customer, movies, ...] ]
	|> List.foldl(%{}, fn x, acc -> Similarity.add_viewer(acc, Enum.at(x, 1), Enum.at(x, 0)) end)


IO.puts "Writing to csv"

{:ok, file} = File.open("test_output.csv", [:write])
x = for {k1, v1} <- map, do:
	for {k2, v2} <- map, do: 
		IO.binwrite(file, to_string(k1) <> "," <> to_string(k2) <> "," <> to_string(Similarity.cosine(v1, v2)) <> "\n")

File.close(file)