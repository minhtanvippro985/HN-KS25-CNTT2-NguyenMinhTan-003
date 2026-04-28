CREATE TABLE users(
	user_id VARCHAR(5) PRIMARY KEY NOT NULL,
full_name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE,
phone VARCHAR(15) NOT NULL,
account_type VARCHAR(50) ,
join_date DATE NOT NULL
);

CREATE TABLE auction_items(
	item_id VARCHAR(5) PRIMARY KEY NOT NULL,
item_name VARCHAR(100) UNIQUE,
category VARCHAR(50) NOT NULL,
start_price DECIMAL(15 , 2) NOT NULL,
end_time DATETIME NOT NULL,
status VARCHAR(20) NOT NULL DEFAULT 'Active'
);

CREATE TABLE bids(
	bid_id INT PRIMARY KEY AUTO_INCREMENT,
item_id VARCHAR(5) ,
FOREIGN KEY (item_id) REFERENCES auction_items(item_id),
user_id VARCHAR(5) ,
FOREIGN KEY (user_id) REFERENCES users(user_id),
bid_amount DECIMAL(15 , 2) NOT NULL CHECK (bid_amount > 0),
bid_time DATETIME
);

CREATE TABLE winners(
	winner_id INT PRIMARY KEY AUTO_INCREMENT,
item_id VARCHAR(5) ,
FOREIGN KEY (item_id) REFERENCES auction_items(item_id),
user_id VARCHAR(5) ,
FOREIGN KEY (user_id) REFERENCES users(user_id),
final_price DECIMAL(15 , 2) NOT NULL,
win_date DATE
);

INSERT INTO users(user_id , full_name , email , phone , account_type , join_date) VALUES
('U01', 'Nguyễn Anh Quân', 'quan.na@gmail.com', '0912345678', 'Premium', '2025-01-10'),
('U02', 'Trần Minh Tú', 'tu.tm@gmail.com', '0987654321', 'Standard', '2025-02-15'),
('U03', 'Lê Thu Thủy', 'thuy.lt@gmail.com', '0978123456', 'Premium', '2025-03-20'),
('U04', 'Phạm Gia Bảo', 'bao.pg@gmail.com', '0909876543', 'Standard', '2025-04-12');

INSERT INTO auction_items(item_id , item_name , category , start_price , end_time , status) VALUES
('I01', 'Rolex Datejust 1970', 'Jewelry', 50000000, '2025-11-20 20:00:00', 'Active'),
('I02', 'Tranh sơn dầu Phố Cổ', 'Art', 15000000, '2025-11-21 18:00:00', 'Active'),
('I03', 'Macbook Pro M3 Max', 'Tech', 35000000, '2025-11-15 10:00:00', 'Closed'),
('I04', 'Rượu vang đỏ 1990', 'Collectible', 10000000, '2025-12-05 21:00:00', 'Active');

INSERT INTO bids(item_id , user_id , final_price , win_date) VALUES
('I01', 'U01', 55000000, '2025-11-10 09:00:00'),
('I02', 'U02', 16000000, '2025-11-10 10:30:00'),
('I01', 'U03', 60000000, '2025-11-11 14:00:00'),
('I03', 'U04', 36000000, '2025-11-12 08:00:00'),
('I02', 'U01', 17500000, '2025-11-12 15:20:00');

UPDATE Auction_Items
SET  start_price = start_price * 0,15
WHERE item_id = ''I01";

UPDATE Users
SET account_type = "VIP"
WHERE user_id = "U02";

DELETE FROM Bids 
WHERE bid_amount < 15000000;

SELECT*FROM Auction_items
WHERE category = 'TECH' OR category = 'Jewelry';

SELECT*FROM Users 
WHERE full_name LIKE '%a%';

SELECT * FROM Auction_items 
ORDER BY end_time ASC;

SELECT * FROM Auction_items
ORDER BY start_price DESC 
LIMIT 3;

SELECT item_name, category FROM Auction_items 
LIMIT 2 OFFSET 1;

DELETE FROM bids 
WHERE item_id IN (SELECT item_id FROM auction_items WHERE status = 'Canceled');

SELECT Lower(full_name) FROM Users  ;

SELECT 
    i.item_name, 
    u.full_name AS bidder_name
FROM Auction_items i
LEFT JOIN Bids b ON i.item_id = b.item_id
LEFT JOIN Users u ON b.user_id = u.user_id;

SELECT 
    i.item_id, 
    i.item_name, 
    SUM(b.bid_amount) AS total_bid_amount
FROM Auction_items i
LEFT JOIN Bids b ON i.item_id = b.item_id
GROUP BY i.item_id, i.item_name;