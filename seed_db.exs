alias CollaborativeFiltering.{Repo, Similarity}

defmodule Db do
	def insert_row(row) do
		data = %Similarity{
			movie_1_id: to_string(Enum.at(row, 0)), 
			movie_2_id: to_string(Enum.at(row, 1)), 
			score: String.to_float(Enum.at(row, 2))
		}
		Repo.insert(data)
	end
end

File.stream!("test_output.csv") 
	|> CSV.decode! 
	|> Enum.map(fn x -> Db.insert_row(x) end)
