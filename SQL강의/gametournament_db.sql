-- 데이터베이스 생성
CREATE DATABASE GameTournamentDB;
USE GameTournamentDB;

-- 팀 테이블 생성
CREATE TABLE Teams (
   team_id INT PRIMARY KEY AUTO_INCREMENT,
   team_name VARCHAR(50) NOT NULL
);

-- 선수 포지션 테이블 생성
CREATE TABLE PlayerPositions (
   position_id INT PRIMARY KEY AUTO_INCREMENT,
   position_name VARCHAR(50) NOT NULL
);

-- 리그 테이블 생성
CREATE TABLE Leagues (
   league_id INT PRIMARY KEY AUTO_INCREMENT,
   league_name VARCHAR(50) NOT NULL
);

-- 경기 테이블 생성
CREATE TABLE Matches (
   match_id INT PRIMARY KEY AUTO_INCREMENT,
   league_id INT,
   team_a INT,
   team_b INT,
   season VARCHAR(10),
   start_date DATE,
   end_date DATE,
   result VARCHAR(10),  -- 'Win' or 'Lose'
   score VARCHAR(10),
   FOREIGN KEY (league_id) REFERENCES Leagues(league_id),
   FOREIGN KEY (team_a) REFERENCES Teams(team_id),
   FOREIGN KEY (team_b) REFERENCES Teams(team_id)
);

-- 팀 데이터 삽입
INSERT INTO Teams (team_name) VALUES 
('Dragons'), 
('Warriors'), 
('Knights'), 
('Titans'), 
('Phoenix');

-- 선수 포지션 데이터 삽입
INSERT INTO PlayerPositions (position_name) VALUES 
('Goalkeeper'), 
('Defender'), 
('Midfielder'), 
('Forward'), 
('Striker');

-- 리그 데이터 삽입
INSERT INTO Leagues (league_name) VALUES 
('Spring League'), 
('Fall League');

-- 경기 데이터 삽입 (총 30개)
INSERT INTO Matches (league_id, team_a, team_b, season, start_date, end_date, result, score) VALUES 
(1, 1, 2, '2024', '2024-03-01', '2024-03-01', 'Win', '2-1'),
(1, 2, 3, '2024', '2024-03-02', '2024-03-02', 'Lose', '1-3'),
(1, 3, 4, '2024', '2024-03-03', '2024-03-03', 'Win', '2-0'),
(1, 4, 5, '2024', '2024-03-04', '2024-03-04', 'Lose', '0-1'),
(1, 1, 3, '2024', '2024-03-05', '2024-03-05', 'Win', '3-2'),
(1, 2, 5, '2024', '2024-03-06', '2024-03-06', 'Win', '1-0'),
(1, 4, 1, '2024', '2024-03-07', '2024-03-07', 'Lose', '1-2'),
(1, 5, 3, '2024', '2024-03-08', '2024-03-08', 'Win', '2-1'),
(1, 1, 4, '2024', '2024-03-09', '2024-03-09', 'Win', '3-1'),
(1, 2, 1, '2024', '2024-03-10', '2024-03-10', 'Lose', '0-2'),

(2, 3, 5, '2024', '2024-09-01', '2024-09-01', 'Win', '1-0'),
(2, 4, 2, '2024', '2024-09-02', '2024-09-02', 'Win', '2-0'),
(2, 5, 1, '2024', '2024-09-03', '2024-09-03', 'Lose', '1-3'),
(2, 1, 2, '2024', '2024-09-04', '2024-09-04', 'Win', '2-1'),
(2, 3, 4, '2024', '2024-09-05', '2024-09-05', 'Lose', '1-2'),
(2, 5, 2, '2024', '2024-09-06', '2024-09-06', 'Win', '3-1'),
(2, 1, 4, '2024', '2024-09-07', '2024-09-07', 'Lose', '0-1'),
(2, 3, 1, '2024', '2024-09-08', '2024-09-08', 'Win', '2-1'),
(2, 4, 5, '2024', '2024-09-09', '2024-09-09', 'Lose', '1-2'),
(2, 2, 3, '2024', '2024-09-10', '2024-09-10', 'Win', '2-1'),

(1, 1, 5, '2024', '2024-03-11', '2024-03-11', 'Win', '4-2'),
(1, 2, 4, '2024', '2024-03-12', '2024-03-12', 'Lose', '1-3'),
(1, 3, 1, '2024', '2024-03-13', '2024-03-13', 'Win', '2-0'),
(1, 4, 2, '2024', '2024-03-14', '2024-03-14', 'Lose', '0-1'),
(1, 5, 3, '2024', '2024-03-15', '2024-03-15', 'Win', '3-1'),
(2, 1, 5, '2024', '2024-09-11', '2024-09-11', 'Lose', '1-2'),
(2, 2, 4, '2024', '2024-09-12', '2024-09-12', 'Win', '3-2'),
(2, 3, 2, '2024', '2024-09-13', '2024-09-13', 'Lose', '0-1'),        
(2, 4, 3, '2024', '2024-09-14', '2024-09-14', 'Win', '2-0'),
(2, 5, 1, '2024', '2024-09-15', '2024-09-15', 'Lose', '0-3');


select * from Matches;
USE GameTournamentDB;

CREATE TABLE Player (
   player_id INT AUTO_INCREMENT PRIMARY KEY,
   player_name VARCHAR(50) NOT NULL,
   team_id INT,
   position_id INT,
   FOREIGN KEY (team_id) REFERENCES Teams(team_id),
   FOREIGN KEY (position_id) REFERENCES PlayerPositions(position_id)
);

-- Team 1 선수 추가 (유럽 선수들)
INSERT INTO Player (player_name, team_id, position_id) VALUES
('Cristiano Ronaldo', 1, 1),  -- GoalKeeper
('Manuel Neuer', 1, 1),       -- GoalKeeper
('Sergio Ramos', 1, 2),       -- Defender
('Gerard Pique', 1, 3),       -- Midfielder
('Karim Benzema', 1, 4),      -- Forward
('Virgil van Dijk', 1, 2),    -- Defender
('Luka Modric', 1, 3),        -- Midfielder
('Neymar Jr', 1, 4),          -- Forward
('Raphael Varane', 1, 2),     -- Defender
('Toni Kroos', 1, 3),         -- Midfielder
('Lionel Messi', 1, 4),       -- Forward
('Thibaut Courtois', 1, 5),   -- Substitute
('Paul Pogba', 1, 5),         -- Substitute
('Trent Alexander-Arnold', 1, 2), -- Defender
('Kevin De Bruyne', 1, 3),    -- Midfielder
('Robert Lewandowski', 1, 4), -- Forward
('David Alaba', 1, 5),        -- Substitute
('Aymeric Laporte', 1, 2),    -- Defender
('Kylian Mbappe', 1, 3),      -- Midfielder
('Eden Hazard', 1, 5);        -- Substitute

-- Team 2 선수 추가 (유럽 선수들)
INSERT INTO Player (player_name, team_id, position_id) VALUES
('Alisson Becker', 2, 1),     -- GoalKeeper
('Gianluigi Donnarumma', 2, 1), -- GoalKeeper
('Leonardo Bonucci', 2, 2),   -- Defender
('Jordi Alba', 2, 3),         -- Midfielder
('Erling Haaland', 2, 4),     -- Forward
('Harry Maguire', 2, 2),      -- Defender
('Marco Verratti', 2, 3),     -- Midfielder
('Jadon Sancho', 2, 4),       -- Forward
('Mats Hummels', 2, 2),       -- Defender
('Joshua Kimmich', 2, 3),     -- Midfielder
('Romelu Lukaku', 2, 4),      -- Forward
('Jan Oblak', 2, 5),          -- Substitute
('N Golo Kante', 2, 5),       -- Substitute
('Andy Robertson', 2, 2),     -- Defender
('Thomas Muller', 2, 3),      -- Midfielder
('Sadio Mane', 2, 4),         -- Forward
('Thiago Silva', 2, 5),       -- Substitute
('Achraf Hakimi', 2, 2),      -- Defender
('Antoine Griezmann', 2, 3),  -- Midfielder
('Phil Foden', 2, 5);         -- Substitute

-- Team 3 선수 추가 (한국 선수들)
INSERT INTO Player (player_name, team_id, position_id) VALUES
('Son Heung-Min', 3, 1),      -- GoalKeeper
('Kim Seung-Gyu', 3, 1),      -- GoalKeeper
('Kim Min-Jae', 3, 2),        -- Defender
('Hong Chul', 3, 3),          -- Midfielder
('Lee Kang-In', 3, 4),        -- Forward
('Kwon Kyung-Won', 3, 2),     -- Defender
('Jung Woo-Young', 3, 3),     -- Midfielder
('Hwang Hee-Chan', 3, 4),     -- Forward
('Kim Young-Gwon', 3, 2),     -- Defender
('Lee Jae-Sung', 3, 3),       -- Midfielder
('Cho Gue-Sung', 3, 4),       -- Forward
('Jo Hyeon-Woo', 3, 5),       -- Substitute
('Kim Tae-Hwan', 3, 5),       -- Substitute
('Park Ji-Sung', 3, 2),       -- Defender
('Hwang In-Beom', 3, 3),      -- Midfielder
('Jeong Woo-Yeong', 3, 4),    -- Forward
('Yoon Bit-Garam', 3, 5),     -- Substitute
('Lee Dong-Jun', 3, 2),       -- Defender
('Nam Tae-Hee', 3, 3),        -- Midfielder
('Lee Chung-Yong', 3, 5);     -- Substitute

-- Team 4 선수 추가 (유럽 선수들)
INSERT INTO Player (player_name, team_id, position_id) VALUES
('Ederson Moraes', 4, 1),     -- GoalKeeper
('Marc-Andre ter Stegen', 4, 1), -- GoalKeeper
('Kalidou Koulibaly', 4, 2),  -- Defender
('Dani Carvajal', 4, 3),      -- Midfielder
('Pierre-Emerick Aubameyang', 4, 4), -- Forward
('Gerard Pique', 4, 2),       -- Defender
('Ilkay Gundogan', 4, 3),     -- Midfielder
('Riyad Mahrez', 4, 4),       -- Forward
('John Stones', 4, 2),        -- Defender
('Rodri', 4, 3),              -- Midfielder
('Raheem Sterling', 4, 4),    -- Forward
('Lucas Hernandez', 4, 5),    -- Substitute
('Benjamin Pavard', 4, 5),    -- Substitute
('Cesar Azpilicueta', 4, 2),  -- Defender
('Houssem Aouar', 4, 3),      -- Midfielder
('Joao Felix', 4, 4),         -- Forward
('Timo Werner', 4, 5),        -- Substitute
('Angel Di Maria', 4, 2),     -- Defender
('Lautaro Martinez', 4, 3),   -- Midfielder
('Sergio Aguero', 4, 5);      -- Substitute

-- Team 5 선수 추가 (한국 선수들)
INSERT INTO Player (player_name, team_id, position_id) VALUES
('Kim Jin-Hyeon', 5, 1),      -- GoalKeeper
('Lee Bum-Soo', 5, 1),        -- GoalKeeper
('Jang Hyun-Soo', 5, 2),      -- Defender
('Lee Yong', 5, 3),           -- Midfielder
('Ji Dong-Won', 5, 4),        -- Forward
('Yun Young-Sun', 5, 2),      -- Defender
('Lee Keun-Ho', 5, 3),        -- Midfielder
('Kim Shin-Wook', 5, 4),      -- Forward
('Hong Jeong-Ho', 5, 2),      -- Defender
('Koo Ja-Cheol', 5, 3),       -- Midfielder
('Cho Young-Wook', 5, 4),     -- Forward
('Song Bum-Keun', 5, 5),      -- Substitute
('Oh Ban-Suk', 5, 5),         -- Substitute
('Kang Soo-Il', 5, 2),        -- Defender
('Na Sang-Ho', 5, 3),         -- Midfielder
('Cho Jae-Wan', 5, 4),        -- Forward
('Park Chu-Young', 5, 5),     -- Substitute
('Yun Suk-Young', 5, 2),      -- Defender
('Kim Bo-Kyung', 5, 3),       -- Midfielder
('Lee Dong-Gook', 5, 5);      -- Substitute

-- 2023년 경기 데이터 추가
INSERT INTO Matches (league_id, team_a, team_b, season, start_date, end_date, result, score)
VALUES
(1, 1, 2, 2023, '2023-03-01', '2023-03-01', 'Win', '2-1'),
(1, 3, 4, 2023, '2023-04-10', '2023-04-10', 'Lose', '0-3'),
(2, 2, 5, 2023, '2023-05-15', '2023-05-15', 'Win', '1-0'),
(2, 1, 3, 2023, '2023-06-20', '2023-06-20', 'Win', '3-2'),
(1, 4, 2, 2023, '2023-07-10', '2023-07-10', 'Draw', '1-1'),
(2, 5, 1, 2023, '2023-08-18', '2023-08-18', 'Lose', '1-3'),
(1, 3, 5, 2023, '2023-09-25', '2023-09-25', 'Win', '2-0'),
(2, 4, 1, 2023, '2023-10-30', '2023-10-30', 'Win', '4-1'),
(1, 2, 3, 2023, '2023-11-05', '2023-11-05', 'Lose', '1-2'),
(2, 5, 3, 2023, '2023-12-10', '2023-12-10', 'Draw', '2-2');

-- 2022년 경기 데이터 추가
INSERT INTO Matches (league_id, team_a, team_b, season, start_date, end_date, result, score)
VALUES
(1, 2, 4, 2022, '2022-03-12', '2022-03-12', 'Win', '3-2'),
(1, 5, 3, 2022, '2022-04-15', '2022-04-15', 'Lose', '1-4'),
(2, 3, 1, 2022, '2022-05-20', '2022-05-20', 'Win', '2-1'),
(2, 2, 5, 2022, '2022-06-30', '2022-06-30', 'Win', '3-0'),
(1, 4, 1, 2022, '2022-07-18', '2022-07-18', 'Draw', '2-2'),
(2, 5, 2, 2022, '2022-08-25', '2022-08-25', 'Lose', '0-1'),
(1, 3, 4, 2022, '2022-09-05', '2022-09-05', 'Win', '2-1'),
(2, 1, 5, 2022, '2022-10-12', '2022-10-12', 'Win', '4-3'),
(1, 2, 3, 2022, '2022-11-22', '2022-11-22', 'Draw', '0-0'),
(2, 4, 3, 2022, '2022-12-18', '2022-12-18', 'Lose', '1-3');

-- 2021년 경기 데이터 추가
INSERT INTO Matches (league_id, team_a, team_b, season, start_date, end_date, result, score)
VALUES
(1, 3, 1, 2021, '2021-03-01', '2021-03-01', 'Win', '1-0'),
(1, 5, 2, 2021, '2021-04-02', '2021-04-02', 'Lose', '0-2'),
(2, 4, 5, 2021, '2021-05-15', '2021-05-15', 'Win', '3-1'),
(2, 1, 3, 2021, '2021-06-20', '2021-06-20', 'Win', '4-2'),
(1, 2, 4, 2021, '2021-07-05', '2021-07-05', 'Draw', '1-1'),
(2, 3, 2, 2021, '2021-08-10', '2021-08-10', 'Win', '2-0'),
(1, 5, 1, 2021, '2021-09-30', '2021-09-30', 'Lose', '0-1'),
(2, 4, 3, 2021, '2021-10-18', '2021-10-18', 'Draw', '1-1'),
(1, 2, 5, 2021, '2021-11-25', '2021-11-25', 'Win', '3-0'),
(2, 1, 4, 2021, '2021-12-05', '2021-12-05', 'Lose', '1-2');

