require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database  => "kddDB.sqlite3.db"
)

class Album < ActiveRecord::Base
	has_and_belongs_to_many :genres
	belongs_to :artist
	has_many :tracks

	attr_accessible :id, :artist_id, :genres
end

class Track < ActiveRecord::Base
	belongs_to :album
	belongs_to :artist
	has_and_belongs_to_many :genres

	attr_accessible :id, :artist_id, :album_id, :genres
end

class Artist < ActiveRecord::Base
	has_many :tracks
	has_many :albums

	attr_accessible :id
end

class Genre < ActiveRecord::Base
	has_and_belongs_to_many :albums
	has_and_belongs_to_many :tracks

	attr_accessible :id
end

Genre.delete_all
Album.delete_all
Artist.delete_all
Track.delete_all

puts "Loading genres..."
# loads genres into the database
File.open("track1/genreData1.txt").each do |record|
	Genre.create(:id => record)
end

puts "Loading artists..."
# loads artists into the database
File.open("track1/artistData1.txt").each do |record|
	Artist.create(:id => record)
end

puts "Loading albums..."
# loads albums into the database
File.open("track1/albumData1.txt").each do |line|
	tokens = line.split("|")
	genres = tokens[2..tokens.length]

	genres.map! {|g| Genre.find(g)}
	Album.create(:id => tokens[0], :artist_id => tokens[1], :genres => genres)
end

puts "Loading tracks..."
# loads tracks into the database
File.open("track1/trackData1.txt").each do |line|
	tokens = line.split("|")
	genres = tokens[3..tokens.length]

	genres.map! {|g| Genre.find(g)}
	Track.create(:id => tokens[0], :album_id => tokens[1], :artist_id => tokens[2], :genres => genres)
end
