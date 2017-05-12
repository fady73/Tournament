-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament;
--Creating table for registered players
create table players (
                      id        serial primary key,
                      name      text);
--Creating table for tracking  winners and losers
create table match (
                    match_id   serial primary key,
                    winner     int references players(id),
                    loser      int references players(id)
                  );
create view standings as
--http://stackoverflow.com/questions/29936536/how-to-count-two-separate-columns-in-the-same-table-and-sum-them-into-a-new-colu
                  SELECT    id, name,
                            COUNT(CASE id WHEN winner THEN 1 ELSE NULL END) AS wins,
                            COUNT(match_id) AS matches
                  FROM      players
                  LEFT JOIN match ON id IN (winner, loser)
                  GROUP BY  id, name;