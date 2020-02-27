alias CollaborativeFiltering.{Repo, Similarity}

import Ecto.Query, only: [from: 2]

query = from s in Similarity, 
		where: s.movie_1_id == "1597",
		where: s.movie_2_id != "1597", 
		select: [s.movie_1_id, s.movie_2_id, s.score], 
		order_by: [desc: s.score],	
		limit: 4

Repo.all(query)
	|> Enum.map(fn x -> 
			to_string(Enum.at(x, 0))
			<> " " 
			<> to_string(Enum.at(x, 1)) 
			<> " "
			<> to_string(Enum.at(x, 2)) 
			<> "\n"
		end)
	|> IO.puts
