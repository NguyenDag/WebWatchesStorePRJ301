--create database Watches_Store
USE [master]
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Watches_Store')
BEGIN
	ALTER DATABASE Watches_Store SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE Watches_Store SET ONLINE;
	DROP DATABASE Watches_Store;
END

GO

CREATE DATABASE Watches_Store
GO

USE Watches_Store
GO

/*******************************************************************************
	Drop tables if exists
*******************************************************************************/
DECLARE @sql nvarchar(MAX) 
SET @sql = N'' 

SELECT @sql = @sql + N'ALTER TABLE ' + QUOTENAME(KCU1.TABLE_SCHEMA) 
    + N'.' + QUOTENAME(KCU1.TABLE_NAME) 
    + N' DROP CONSTRAINT ' -- + QUOTENAME(rc.CONSTRAINT_SCHEMA)  + N'.'  -- not in MS-SQL
    + QUOTENAME(rc.CONSTRAINT_NAME) + N'; ' + CHAR(13) + CHAR(10) 
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS RC 

INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KCU1 
    ON KCU1.CONSTRAINT_CATALOG = RC.CONSTRAINT_CATALOG  
    AND KCU1.CONSTRAINT_SCHEMA = RC.CONSTRAINT_SCHEMA 
    AND KCU1.CONSTRAINT_NAME = RC.CONSTRAINT_NAME 

EXECUTE(@sql) 

GO
DECLARE @sql2 NVARCHAR(max)=''

SELECT @sql2 += ' Drop table ' + QUOTENAME(TABLE_SCHEMA) + '.'+ QUOTENAME(TABLE_NAME) + '; '
FROM   INFORMATION_SCHEMA.TABLES
WHERE  TABLE_TYPE = 'BASE TABLE'

Exec Sp_executesql @sql2 
GO
-- select CURRENT_date

-- Create Suppliers table
CREATE TABLE Suppliers (
  supID INT PRIMARY KEY IDENTITY(1,1),--id
  supName VARCHAR(255),--ten nha cung cap
  supAddress VARCHAR(255),--dia chi nha cung cap
  supPhone VARCHAR(20),--so dthoai nha cc
  supEmail VARCHAR(255)-- dia chi mail
);

-- Create Accounts table
CREATE TABLE Accounts (
  accID INT PRIMARY KEY IDENTITY(1,1),
  username VARCHAR(255),
  [password] VARCHAR(255),
  [role] INT, -- 0 for admin, 1 for user
  accname nVARCHAR(255),--ten
  accAddress nVARCHAR(255),--dia chi
  cusPhone VARCHAR(20),--sdt
  cusEmail VARCHAR(255),--mail
  avatar VARCHAR(255) DEFAULT 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/avatar.jpg?alt=media&token=d12c1af5-8bdf-4795-8536-4892c42e9b46',
  gender varchar(10)
);

-- Create Admins table (removed, as Admins are now part of the Accounts table)

-- Create Categories table
CREATE TABLE Categories (
  catID INT PRIMARY KEY IDENTITY(1,1),
  catName VARCHAR(255),
  catDescription TEXT
);

-- Create Products table
CREATE TABLE Products (
  proID INT PRIMARY KEY IDENTITY(1,1),
  proName VARCHAR(255),
  catID INT,
  supID INT,
  proDescription TEXT,
  "quantityPerUnit" nvarchar (20) NULL ,--số lượng sản phẩm trong một đơn vị
  	"unitPrice" money,--gia san phẩm
	"unitsInStock" smallint,--số lượng sản phẩm trong kho
	unitsOnOrder smallint,--số lượng sản phẩm đang được đặt
	"unitsOrdered" smallint,
	discount real default 0,
  discontinued bit,--trạng thái của sản phẩm (đã ngừng bán hoặc chưa)
  FOREIGN KEY (catID) REFERENCES Categories(catID),
  FOREIGN KEY (supID) REFERENCES Suppliers(supID)
);

CREATE TABLE Cart (
  cartID INT PRIMARY KEY IDENTITY(1,1),   -- Khóa chính cho giỏ hàng
  accID INT,                               -- ID tài khoản người dùng
  proID INT,                               -- ID sản phẩm
  quantity INT DEFAULT 1,                  -- Số lượng sản phẩm trong giỏ
  FOREIGN KEY (accID) REFERENCES Accounts(accID),  -- Khóa ngoại liên kết tới bảng Accounts
  FOREIGN KEY (proID) REFERENCES Products(proID)   -- Khóa ngoại liên kết tới bảng Products
);

CREATE TABLE DiscountCodes (
    discountCodeID INT PRIMARY KEY IDENTITY(1,1),  -- Tự động tăng
    code NVARCHAR(50) NOT NULL UNIQUE,
    discount_type NVARCHAR(20) NOT NULL CHECK (discount_type IN ('percentage', 'fixed')),  -- Kiểm tra kiểu
    valueOfCode DECIMAL(10, 2) NOT NULL,
    [start_date] DATETIME,
    end_date DATETIME
);

CREATE TABLE UserDiscounts (
    idDiscountOfUser INT PRIMARY KEY IDENTITY(1,1),          -- Khóa chính, tự động tăng
    userID INT NOT NULL,                       -- Khóa ngoại đến bảng account
    discountCodeID INT NOT NULL,              -- Khóa ngoại đến bảng discount_codes
    used BIT DEFAULT 0,                         -- Đã sử dụng hay chưa
    FOREIGN KEY (userID) REFERENCES Accounts(accID),            -- Ràng buộc khóa ngoại đến bảng account
    FOREIGN KEY (discountCodeID) REFERENCES DiscountCodes(discountCodeID)  -- Ràng buộc khóa ngoại đến bảng discount_codes
);

-- Create ProductImages table
CREATE TABLE ProductImages (
  imgID INT PRIMARY KEY IDENTITY(1,1),
  proID INT,
  imgURL VARCHAR(255),
  imgDescription TEXT,
  isRepresentative BIT DEFAULT 0,
  FOREIGN KEY (proID) REFERENCES Products(proID)
);

-- Create ProductReviews table
CREATE TABLE ProductReviews (
  revID INT PRIMARY KEY IDENTITY(1,1),
  proID INT,
  accID INT,
  revText TEXT,
  revRating INT,
  FOREIGN KEY (proID) REFERENCES Products(proID),
  FOREIGN KEY (accID) REFERENCES Accounts(accID)
);

-- Create OrderStatus table
CREATE TABLE OrderStatus (
  sttID INT PRIMARY KEY IDENTITY(1,1),
  sttName VARCHAR(255),
  sttDescription TEXT
);

-- Create ShippingInformation table
CREATE TABLE Shipping (
  shipID INT PRIMARY KEY IDENTITY(1,1),
  shipMethod VARCHAR(255),
  shipCost DECIMAL(10, 2),
  shipDate VARCHAR(100),
);

-- Create Orders table
CREATE TABLE Orders (
  orderID INT PRIMARY KEY IDENTITY(1,1),
  accID INT,
  orderDate DATETIME DEFAULT GETDATE(),
  totalCost DECIMAL(10, 2),
  sttID INT,
  shipID INT,
  FOREIGN KEY (accID) REFERENCES Accounts(accID),
  FOREIGN KEY (sttID) REFERENCES OrderStatus(sttID),
  FOREIGN KEY (shipID) REFERENCES Shipping(shipID)
);

-- Create OrderDetails table
CREATE TABLE OrderDetails (
  oDetailID INT PRIMARY KEY IDENTITY(1,1),
  orderID INT,
  proID INT,
  "unitPrice" money,--gia san phẩm thực tế
  quantity INT,
  
  FOREIGN KEY (orderID) REFERENCES Orders(orderID),
  FOREIGN KEY (proID) REFERENCES Products(proID)
);

-- Create PaymentInformation table
CREATE TABLE PaymentInformation (
  payID INT PRIMARY KEY IDENTITY(1,1),
  orderID INT,
  payMethod VARCHAR(255),
  payDate DATETIME DEFAULT GETDATE(),
  payAmount DECIMAL(10, 2),
  FOREIGN KEY (orderID) REFERENCES Orders(orderID)
);

-- Create WarrantyInformation table bao hanh
CREATE TABLE WarrantyInformation (
  warID INT PRIMARY KEY IDENTITY(1,1),
  proID INT,
  warPeriod INT,
  warDescription TEXT,
  FOREIGN KEY (proID) REFERENCES Products(proID)
);

--DATABASE chèn Value

INSERT INTO Suppliers (supName, supAddress, supPhone, supEmail)
VALUES
('Wholesale Central', 'US', '03746836584', 'vancleef@email.com'),
('Montblanc', 'Switzerland', '0987629321', 'Montblanc@email.com'),
('Chinabrands', 'China', '0846836658', 'Chinabrands@email.com'),
('Nihaojewelry', 'China', '0468276271', 'Nihaojewelry@email.com'),
('PinkTree', 'US', '0347982989', 'PinkTree@email.com'),
('Piaget', 'Switzerland', '034548543345', 'Piaget@email.com'),
('Cartier', 'France', '06564576754', 'Cartier@email.com'),
('Harry Winston', 'France', '07534685674', 'Winston@email.com'),
('Blancpain', 'Switzerland', '07685456897', 'Blancpain@email.com'),
('Longines', 'Switzerland', '04578456778', 'Longines@email.com'),
('Zenith', 'Switzerland', '04586856878', 'Zenith@email.com'),
('Tudor', 'Switzerland', '08568456475', 'Tudor@email.com'),
('Omega', 'Switzerland', '0474346547', 'Omega@email.com'),
('Rolex', 'Switzerland', '05783279547', 'Rolex@email.com'),
('Patek Philippe', 'Switzerland', '0945878988', 'Philippe@email.com');

INSERT INTO Accounts (username, [password], [role], accname, accAddress, cusPhone, cusEmail, gender)
VALUES
('admin', '123', 0, 'Tran Van Admin', 'Ha Noi', '0123456789', 'admin@email.com', 'male'),
('user1', '123', 1, 'User  1', 'Address 2', '0987654321', 'user1@email.com', 'female'),
('user2', '123', 1, 'User  2', 'Address 3', '0123456789', 'user2@email.com', 'male'),
('user3', '123', 1, 'User  3', 'Address 4', '0987654321', 'user3@email.com', 'male'),
('user4', '123', 1, 'User  4', 'Address 5', '0123456789', 'user4@email.com', 'female'),
('user5', '123', 1, 'User  5', 'Address 6', '0987654321', 'user5@email.com', 'female'),
('user6', '123', 1, 'User  6', 'Address 7', '0123456789', 'user6@email.com', 'male'),
('user7', '123', 1, 'User  7', 'Address 8', '0987654321', 'user7@email.com', 'female'),
('user8', '123', 1, 'User  8', 'Address 9', '0123456789', 'user8@email.com', 'male'),
('user9', '123', 1, 'User  9', 'Address 10', '0987654321', 'user9@email.com', 'male');

INSERT INTO Categories (catName, catDescription) VALUES
('Watches for Men', 'A diverse collection of stylish and functional watches designed specifically for men, featuring various styles such as dress, casual, and sports watches.'),
('Watches for Women', 'An elegant selection of watches for women, showcasing designs that blend fashion and functionality, perfect for any occasion.'),
('Watches for Children', 'Fun and colorful watches designed for children, combining durability and playful designs that cater to young tastes and preferences.'),
('Watches for Couples', 'Charming matching watches for couples, symbolizing love and unity, available in various styles to suit both partners.'),
('Accessories', 'A range of accessories including watch bands, cases, and tools to enhance your watch experience and personal style.');

INSERT INTO Products (proName, catID, supID, proDescription, quantityPerUnit, unitPrice, unitsInStock, unitsOnOrder, unitsOrdered, discount, discontinued)
VALUES
('Patek Philippe Calatrava - Timeless Elegance for the Modern Man', 1, 1, 'The Patek Philippe Calatrava is an elegant Swiss timepiece for men, known for its timeless design and exceptional craftsmanship, making it a must-have for any watch collector.', '1', 1000, 246, 3, 123, 10, 1),
('Audemars Piguet Royal Oak - Iconic Luxury Sports Watch with a Distinctive Design', 1, 1, 'The Audemars Piguet Royal Oak is an iconic luxury sports watch, distinguished by its unique octagonal bezel and stylish design, perfect for both casual and formal occasions.', '1', 800, 268, 52, 342, 15, 1),
('Vacheron Constantin Overseas - Premium Travel Watch for the Discerning Gentleman', 1, 1, 'The Vacheron Constantin Overseas is a premium travel watch for men, featuring a sporty design and robust functionality, ideal for the modern globetrotter.', '1', 1200, 343, 2, 354, 20, 1),
('Rolex Daytona - The Classic Racing Chronograph for Enthusiasts', 1, 1, 'The Rolex Daytona is a classic racing chronograph watch, celebrated for its precision and performance, embodying the spirit of motorsport and luxury.', '1', 900, 1053, 16, 230, 34, 1),
('Omega Speedmaster - The Legendary Moonwatch for Adventurers and Explorers', 1, 1, 'The Omega Speedmaster is the legendary Moonwatch, designed for adventurers and space enthusiasts alike, known for its durability and iconic status in horology.', '1', 700, 1542, 28, 245, 5, 1),
('Cartier Tank - A Timeless Luxury Watch for Women with Iconic Design', 2, 2, 'The Cartier Tank is a timeless luxury watch for women, characterized by its rectangular case and sophisticated design, perfect for elegant occasions.', '1', 600, 145, 120, 532, 17, 1),
('Chanel J12 - Stylish Ceramic Watch for Women with a Modern Twist', 2, 2, 'The Chanel J12 is a stylish ceramic watch for women, blending modern aesthetics with classic design, suitable for both casual and formal wear.', '1', 5000, 618, 12, 345, 45, 1),
('Louis Vuitton Tambour - A Fashion Statement in Luxury Timepieces for Women', 2, 2, 'The Louis Vuitton Tambour is a fashionable luxury watch for women, showcasing the brand’s signature style and attention to detail, ideal for the fashion-forward.', '1', 400, 420, 15, 432, 20, 1),
('Gucci Bamboo - Chic and Elegant Timepiece for the Sophisticated Woman', 2, 2, 'The Gucci Bamboo is a chic and elegant women’s timepiece, featuring innovative design and luxury materials, perfect for enhancing any outfit.', '1', 3000, 425, 18, 324, 10, 1),
('Prada Sport - Sporty and Stylish Watch for the Active Woman', 2, 2, 'The Prada Sport is a sporty and stylish watch for women, combining functionality with high fashion, suitable for active lifestyles.', '1', 250, 630, 20, 2342, 0, 1),
('Breitling Navitimer - The Classic Pilot’s Watch for Aviation Enthusiasts', 1, 3, 'The Breitling Navitimer is a classic pilot’s watch for men, renowned for its precision and aviation features, essential for aviation enthusiasts.', '1', 1100, 548, 5, 3542, 24, 1),
('IWC Portugieser - Elegant and Sophisticated Timepiece for the Modern Gentleman', 1, 3, 'The IWC Portugieser is an elegant and sophisticated watch for men, featuring a timeless design and exceptional Swiss engineering, perfect for formal occasions.', '1', 1000, 312, 8, 345, 60, 1),
('Jaeger-LeCoultre Reverso - Iconic Reversible Watch for Versatile Style', 1, 15, 'The Jaeger-LeCoultre Reverso is an iconic reversible watch for men, known for its unique design and versatility, ideal for both day and night wear.', '1', 600, 315, 10, 345, 20, 1),
('Panerai Luminor - Robust and Reliable Watch for Diving Enthusiasts', 1, 3, 'The Panerai Luminor is a robust and reliable watch for men, designed for dive enthusiasts with its water-resistant features and bold aesthetics.', '1', 800, 818, 12, 5434, 30, 1),
('TAG Heuer Carrera - Sporty and Stylish Watch for Racing Aficionados', 1, 3, 'The TAG Heuer Carrera is a sporty and stylish watch for men, embodying the spirit of motorsport with its precision engineering and racing heritage.', '1', 700, 520, 15, 336, 10, 1),
('Bvlgari Serpenti - Luxurious and Elegant Timepiece for the Modern Woman', 2, 4, 'The Bvlgari Serpenti is a luxurious and elegant watch for women, featuring a unique serpentine design that symbolizes femininity and allure.', '1', 600, 125, 18, 453, 5, 1),
('Hublot Big Bang - Bold and Innovative Watch for the Fashion-Forward Man', 1, 4, 'The Hublot Big Bang is a bold and innovative watch for men, known for its striking design and fusion of materials, perfect for the modern man.', '1', 1200, 120, 6, 4376, 12, 1),
('Tissot Le Locle - Classic and Elegant Watch for the Discerning Gentleman', 3, 15, 'The Tissot Le Locle is a classic and elegant watch for men, featuring Swiss craftsmanship and a timeless design, ideal for everyday wear.', '1', 920, 122, 8, 576, 15, 1),
('Longines HydroConquest - Sporty and Water-Resistant Timepiece for Adventurers', 1, 4, 'The Longines HydroConquest is a sporty and water-resistant watch for men, designed for aquatic adventures with a stylish appearance.', '1', 800, 195, 10, 876, 35, 1),
('Rado DiaMaster - Elegant and Sophisticated Watch for Modern Men', 3, 4, 'The Rado DiaMaster is an elegant and sophisticated watch for men, featuring a scratch-resistant surface and contemporary design, perfect for formal settings.', '1', 700, 188, 12, 987, 40, 1),
('Citizen Campanola - A Masterpiece of Craftsmanship for Watch Collectors', 3, 5, 'The Citizen Campanola is a luxury watch for men, known for its intricate craftsmanship and artistic design, appealing to collectors and connoisseurs.', '1', 1600, 220, 15, 534, 42, 1),
('Seiko Prospex - High-Performance Watch for the Outdoor Enthusiast', 3, 5, 'The Seiko Prospex is a premium watch for men, combining advanced features with a rugged design, ideal for outdoor and water sports enthusiasts.', '1', 500, 250, 18, 454, 31, 1),
('Fossil Grant - Stylish Timepiece for the Modern Man', 4, 5, 'The Fossil Grant is a stylish watch for men, featuring a classic design with modern touches, making it suitable for both casual and formal occasions.', '1', 400, 304, 20, 564, 17, 1),
('Skagen Ancher - Minimalist Watch for Everyday Elegance', 4, 5, 'The Skagen Ancher is a minimalist watch for men, known for its sleek design and Danish craftsmanship, perfect for everyday wear.', '1', 1800, 138, 12, 567, 22, 1),
('Daniel Wellington Classic - Timeless Design for the Discerning Gentleman', 4, 5, 'The Daniel Wellington Classic is a timeless watch for men, featuring a simple yet elegant design, suitable for any occasion.', '1', 3500, 335, 25, 456, 44, 1),
('Emporio Armani Sport - Modern Watch for the Active Lifestyle', 4, 6, 'The Emporio Armani Sport is a modern watch for men, combining sporty aesthetics with luxury materials, perfect for the active lifestyle.', '1', 1700, 240, 30, 864, 24, 1),
('Gucci G-Timeless - Fashionable Timepiece for the Stylish Man', 4, 6, 'The Gucci G-Timeless is a fashionable watch for men, known for its unique design and signature Gucci motifs, suitable for stylish outings.', '1', 2500, 445, 35, 354, 12, 1),
('Hugo Boss Orange - Contemporary Watch for the Trendy Man', 4, 6, 'The Hugo Boss Orange is a contemporary watch for men, featuring a bold design and vibrant colors, ideal for casual wear.', '1', 2000, 350, 40, 355, 10, 0),
('Lacoste 12.12 - Sporty Watch for the Modern Man', 4, 6, 'The Lacoste 12.12 is a sporty watch for men, combining classic tennis style with modern functionality, perfect for everyday use.', '1', 1800, 355, 45, 432, 80, 0),
('Montblanc TimeWalker - Luxury Watch for the Discerning Gentleman', 4, 6, 'The Montblanc TimeWalker is a luxury watch for men, known for its elegant design and precise movement, ideal for the discerning gentleman.', '1', 1500, 260, 50, 765, 35, 1),
('Raymond Weil Toccata - Sophisticated Timepiece for the Modern Man', 4, 7, 'The Raymond Weil Toccata is a sophisticated watch for men, combining classic aesthetics with modern technology, suitable for formal events.', '1', 1200, 265, 55, 875, 46, 1),
('Tissot PRX - Stylish Retro Watch for Everyday Elegance', 4, 7, 'The Tissot PRX is a stylish watch for men, featuring a retro design and contemporary functionality, perfect for both casual and formal settings.', '1', 1000, 270, 60, 565, 12, 0),
('Longines Flagship - Classic Timepiece for the Discerning Gentleman', 3, 7, 'The Longines Flagship is a classic watch for men, known for its timeless elegance and Swiss craftsmanship, ideal for business and formal wear.', '1', 900, 375, 65, 951, 43, 1),
('Rado Captain Cook - Vintage-Inspired Watch for Diving Enthusiasts', 3, 14, 'The Rado Captain Cook is a vintage-inspired watch for men, offering a blend of style and functionality, perfect for diving and water sports.', '1', 800, 380, 70, 765, 60, 1),
('Citizen BM8475-03E - Rugged Watch for Outdoor Adventures', 3, 7, 'The Citizen BM8475-03E is a rugged watch for men, designed for outdoor adventures with its durable construction and reliable performance.', '1', 700, 385, 75, 973, 74, 1),
('Seiko Prospex SLT033J1 - High-Performance Diving Watch for Enthusiasts', 3, 8, 'The Seiko Prospex SLT033J1 is a high-performance watch for men, engineered for diving with advanced water resistance and durability.', '1', 600, 390, 80, 762, 20, 0),
('Fossil Townsman - Trendy Timepiece for Everyday Style', 3, 8, 'The Fossil Townsman is a trendy watch for men, featuring a modern design and versatile style, suitable for everyday wear.', '1', 500, 395, 85, 957, 23, 0),
('Skagen Falster - Smartwatch Combining Technology and Style', 3, 8, 'The Skagen Falster is a smart watch for men, combining technology with Scandinavian design, perfect for the tech-savvy individual.', '1', 400, 100, 90, 836, 43, 0),
('Daniel Wellington Petite - Delicate Watch for the Modern Woman', 2, 8, 'The Daniel Wellington Petite is a delicate watch for women, known for its minimalist design and elegant aesthetics, suitable for any outfit.', '1', 350, 405, 95, 876, 46, 1),
('Emporio Armani Lady - Sophisticated Watch for the Elegant Woman', 2, 14, 'The Emporio Armani Lady is a sophisticated watch for women, featuring a stylish design and luxurious materials, perfect for formal occasions.', '1', 300, 1140, 100, 124, 50, 0),
('Gucci G-Frame - Fashionable Timepiece for the Stylish Woman', 2, 9, 'The Gucci G-Frame is a fashionable watch for women, known for its unique shape and high-quality craftsmanship, ideal for stylish outings.', '1', 2500, 435, 105, 785, 50, 1),
('Hugo Boss Lady - Elegant Watch for Every Occasion', 2, 9, 'The Hugo Boss Lady is an elegant watch for women, featuring a classic design and sophisticated details, perfect for any occasion.', '1', 200, 120, 110, 953, 11, 1),
('Lacoste 12.12 Lady - Chic Watch for the Modern Woman', 2, 9, 'The Lacoste 12.12 Lady is a chic watch for women, blending sporty elements with a fashionable look, suitable for casual wear.', '1', 1800, 125, 115, 463, 1, 0),
('Montblanc Bohème - Exquisite Luxury Watch for Women', 2, 9, 'The Montblanc Bohème is a luxurious watch for women, known for its exquisite design and exceptional craftsmanship, ideal for elegant occasions.', '1', 1500, 130, 120, 475, 0, 1),
('Raymond Weil Tango - Stylish Watch for the Fashion-Forward Woman', 2, 14, 'The Raymond Weil Tango is a stylish watch for women, combining contemporary design with versatile functionality, perfect for daily wear.', '1', 1200, 135, 125, 343, 8, 1),
('Tissot Le Locle Lady - Classic Elegance for the Modern Woman', 2, 10, 'The Tissot Le Locle Lady is a classic watch for women, blending elegance with Swiss precision, ideal for both business and social events.', '1', 1000, 140, 130, 243, 0, 0),
('Longines DolceVita - Glamorous Timepiece for the Stylish Woman', 2, 10, 'The Longines DolceVita is a sophisticated watch for women, known for its glamorous design and timeless appeal, perfect for any occasion.', '1', 900, 145, 135, 352, 0, 1),
('Rado Integral - Modern Watch for the Contemporary Woman', 2, 10, 'The Rado Integral is a modern watch for women, featuring a sleek design and high-quality materials, ideal for the contemporary woman.', '1', 600, 160, 150, 434, 0, 0),
('Citizen EW1554-53A - Stylish Watch for Everyday Elegance', 2, 13, 'The Citizen EW1554-53A is a stylish watch for women, known for its elegant design and reliable performance, suitable for everyday wear.', '1', 800, 150, 140, 433, 0, 0),
('Seiko Prospex Lady - High-Performance Watch for Adventurous Women', 2, 10, 'The Seiko Prospex Lady is a high-performance watch for women, designed for diving enthusiasts with its robust features and stylish appearance.', '1', 700, 155, 145, 575, 34, 1),
('Fossil Jacqueline - Chic Timepiece for the Modern Woman', 5, 11, 'The Fossil Jacqueline is a chic watch for women, featuring a modern design and versatile style, perfect for everyday wear.', '1', 600, 160, 150, 754, 0, 0),
('Skagen Ancher Lady - Minimalist Elegance for Everyday Wear', 5, 11, 'The Skagen Ancher Lady is a minimalist watch for women, known for its sleek design and Danish craftsmanship, suitable for any outfit.', '1', 510, 165, 155, 534, 0, 0),
('Daniel Wellington Petite Lady - Delicate Watch for the Stylish Woman', 5, 15, 'The Daniel Wellington Petite Lady is a delicate watch, featuring a simple yet elegant design, perfect for the sophisticated woman.', '1', 450, 170, 160, 463, 0, 1),
('Emporio Armani Lady Sport - Modern Watch for the Active Woman', 5, 11, 'The Emporio Armani Lady Sport is a modern watch for women, combining sporty aesthetics with luxury materials, ideal for active lifestyles.', '1', 400, 175, 165, 547, 18, 0),
('Gucci G-Frame Lady - Luxury Watch for the Fashion-Forward Woman', 5, 13, 'The Gucci G-Frame Lady is a luxurious watch for women, known for its unique design and high-quality craftsmanship, suitable for stylish outings.', '1', 3500, 180, 170, 563, 0, 1),
('Hugo Boss Lady Sport - Trendy Watch for the Active Lifestyle', 5, 12, 'The Hugo Boss Lady Sport is a trendy watch for women, featuring a sporty design with elegant touches, perfect for casual and active lifestyles.', '1', 350, 185, 175, 654, 0, 1),
('Lacoste 12.12 Lady Sport - Chic and Sporty Timepiece for Active Women', 5, 12, 'The Lacoste 12.12 Lady Sport is a chic and sporty watch for women, combining fashion with functionality, ideal for everyday wear.', '1', 320, 190, 180, 543, 0, 1),
('Montblanc Star - Exquisite Timepiece for the Elegant Woman', 5, 12, 'The Montblanc Star is an exquisite luxury watch for women, known for its elegant design and superior craftsmanship, perfect for special occasions.', '1', 1500, 195, 185, 432, 0, 1),
('Raymond Weil Noemia - Sophisticated Watch for the Modern Woman', 5, 12, 'The Raymond Weil Noemia is a sophisticated watch for women, featuring a sleek design and luxurious details, ideal for any event.', '1', 1200, 200, 190, 321, 0, 1),
('Tissot Everytime - Timeless Watch for Everyday Elegance', 5, 13, 'The Tissot Everytime is a timeless watch for women, known for its classic design and reliable performance, suitable for daily wear.', '1', 800, 205, 195, 210, 0, 1);

INSERT INTO DiscountCodes ( code, discount_type, valueOfCode, [start_date], end_date) VALUES
('Code 1', 'percentage', 10, '2024-01-01', '2024-12-31'),
('Code 2 WATCH15', 'percentage', 15, '2024-02-01', '2024-05-31'),
('Code 3 WATCH20', 'fixed', 20, '2024-03-01', '2024-06-30'),
('Code 4 WATCH25', 'percentage', 25, '2024-04-01', '2024-09-30'),
('Code 5 WATCH30', 'fixed', 30, '2024-05-01', '2024-08-31'),
('Code 6 WATCH40', 'percentage', 40, '2024-06-01', '2024-10-31'),
('Code 7 WATCH50', 'fixed', 50, '2024-07-01', '2024-12-31'),
('Code 8 WATCH60', 'percentage', 60, '2024-08-01', '2024-11-30'),
('Code 9 WATCH70', 'percentage', 10, '2024-09-01', '2024-10-31'),
('Code 10 WATCH80', 'fixed', 20, '2024-10-01', '2024-12-31'),
('Code 11WATCH90', 'fixed', 15, '2024-11-01', '2024-12-31'),
('Code 12 WATCH95', 'percentage', 17, '2024-12-01', '2024-12-31'),
('Code 13 WATCH100', 'fixed', 50, '2024-01-01', '2024-03-31'),
('Code 14 WATCH110', 'percentage', 10, '2024-02-01', '2024-08-31'),
('Code 15 WATCH120', 'fixed', 12, '2024-03-01', '2024-09-30');

INSERT INTO UserDiscounts (userID, discountCodeID, used) VALUES
(1, 1, 1),
(1, 2, 0),
(1, 3, 0),
(2, 4, 0),
(2, 5, 1),
(2, 6, 1),
(3, 7, 10),
(3, 8, 0),
(3, 9, 0),
(4, 10, 0),
(4, 11, 1),
(5, 12, 0),
(5, 13, 0),
(5, 14, 1),
(2, 15, 0),
(2, 1, 1),
(3, 2, 0),
(3, 3, 0),
(3, 4, 0),
(4, 5, 1),
(4, 5, 0),
(4, 6, 0),
(5, 7, 1),
(5, 8, 0),
(5, 9, 0),
(5, 10, 1),
(1, 11, 0),
(2, 12, 1),
(3, 13, 0),
(4, 14, 0),
(5, 15, 1);

INSERT INTO ProductImages (proID, imgURL, imgDescription, isRepresentative)
VALUES
( 1, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/11.jpg?alt=media&token=4808897c-d90d-44d8-90d7-00acab5a265a', 'Image of watch for men 1',1),
( 1, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/12.jpg?alt=media&token=1822ff2c-53c9-4916-8f8a-dc945a1086b3', 'Image of watch for women 1', 0),
( 1, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/13.jpg?alt=media&token=14b3e533-a356-4f17-9922-b915357369d7', 'Image of Couple Watch 1', 0),

( 2, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/2.2.jpg?alt=media&token=9bfaa766-d178-4baa-883b-d3dbdebe816e', 'Image of Accessory 1', 1),
( 2, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/2%2C3.jpg?alt=media&token=d316b9a4-0aa4-4262-ab38-9f5306f3c64f', 'Image of watch for men 2', 0),
( 2, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/2.4.jpg?alt=media&token=ed8a32c4-e89e-4f9a-b869-be27eaef3e6a', 'Image of Womens Watch 2', 0),

( 3, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/3.1.jpg?alt=media&token=625b3a3e-773b-4efc-bc75-43e7c8321b83', 'Image of Couple Watch 2', 1),
( 3, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/3.2.jpg?alt=media&token=e9d2ffd5-e4a5-4c93-998d-06e60b70c4ee', 'Image of Kids Watch 2', 0),
( 3, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/3.3.jpg?alt=media&token=d2139fd3-70b0-47af-9b66-8f04caa50207', 'Image of Accessory 2', 0),

( 4, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/4.1.jpg?alt=media&token=1633c188-71e5-49cf-ae35-2ad444f98f4d', 'Image of watch for men 3', 1),
( 4, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/4.2.jpg?alt=media&token=37b2a0cf-407f-40e1-a22d-f9906dc4071d', 'Image of watch for women 3', 0),
( 4, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/4.3.jpg?alt=media&token=4ff4b1f7-a415-4c7a-8462-e4a7c58adfa0', 'Image of Couple Watch 3', 0),

( 5, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/5.1.jpg?alt=media&token=c9212e3d-1b60-4566-a285-9e87afad93e3', 'Image of Kids Watch 3', 1),
( 5, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/5.2.jpg?alt=media&token=907d796c-3098-4907-aa2b-f9d54c4902f3', 'Image of Accessory 3', 0),
( 5, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/5.3.jpg?alt=media&token=047d2c18-9c0a-4099-afd8-40228b499dec', 'Image of Accessory 3', 0),

( 6, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/6.1.jpg?alt=media&token=90a97372-8df1-4ae5-bd18-a81912e14dc2', 'Image of watch for men 1',1),
( 6, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/6.2.jpg?alt=media&token=ea956094-bc83-4bc0-ba0e-def64c0381fd', 'Image of watch for women 1', 0),
( 6, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/6.4.jpg?alt=media&token=cb5eb693-7e90-4910-af88-7927ab5c0a60', 'Image of Couple Watch 1', 0),

( 7, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/7.1.jpg?alt=media&token=41362b65-dfbf-4a9b-b6bb-450023b34569', 'Image of Accessory 1', 1),
( 7, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/7.2.jpg?alt=media&token=31f23a87-0d46-48c2-99d0-cf49294e104c', 'Image of watch for men 2', 0),
( 7, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/7.3.jpg?alt=media&token=88d71e3a-732a-4b95-9bfe-90fd80f253d2', 'Image of Womens Watch 2', 0),

( 8, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/8.1.jpg?alt=media&token=90b206b0-77ea-499d-b0ea-10ee48130f5c', 'Image of Couple Watch 2', 1),
( 8, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/8.2.jpg?alt=media&token=0ea6d063-aa65-48ab-b3ae-d26d1f9917bd', 'Image of Kids Watch 2', 0),
( 8, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/8.3.jpg?alt=media&token=854c4775-6684-48ab-b6c8-15b0775eed6e', 'Image of Accessory 2', 0),

( 9, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/9.1.jpg?alt=media&token=c1ab3f93-b882-42d1-a9f0-414871ed259b', 'Image of watch for men 3', 1),
( 9, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/9.2.jpg?alt=media&token=eabd91be-16e3-444a-9e2b-5a637d62120c', 'Image of watch for men 3', 0),
( 9, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/9.3.jpg?alt=media&token=e6da827a-9cd6-4de1-8c54-3be992b561bf', 'Image of watch for men 3', 0),

( 10, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/10.1.jpg?alt=media&token=6d0b3ce9-bbea-4a41-9af2-14559e1b0f9c', 'Image of Kids Watch 3', 1),
( 10, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/10.2.jpg?alt=media&token=919d2a90-3743-4362-9c21-51d4c6e80340', 'Image of Kids Watch 3', 0),
( 10, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/10.3.jpg?alt=media&token=4ae4eb13-894e-4dd2-be2b-a9025a736229', 'Image of Kids Watch 3', 0),

( 11, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/11.1.jpg?alt=media&token=b19c9101-aa13-47d3-91d3-763b2f3032dc', 'Image of watch for men 1',1),
( 11, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/11.2.jpg?alt=media&token=e7c7b684-df92-4e87-86a0-b3a28c847ef2', 'Image of watch for men 1',0),
( 11, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/11.3.jpg?alt=media&token=99740324-4d0c-49c4-8a02-7d9ca2f08825', 'Image of watch for men 1',0),

( 12, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/12.1.jpg?alt=media&token=7a73d56d-abbc-43f3-a229-dd9adfbd280f', 'Image of Accessory 1', 1),
( 12, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/12.2.jpg?alt=media&token=da1af693-8a5b-49a8-9379-4d7432ab9b00', 'Image of Accessory 1', 0),
( 12, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/12.3.jpg?alt=media&token=13da6915-b551-4d27-b9db-890b21de524c', 'Image of Accessory 1', 0),

( 13, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/13.1.jpg?alt=media&token=0e0ad1e2-ca9c-4e90-b73e-894593a96ac8', 'Image of Couple Watch 2', 1),
( 13, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/13.2.jpg?alt=media&token=773a9c03-01c7-437c-809f-ad6038db1bb5', 'Image of Couple Watch 2', 0),
( 13, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/13.3.jpg?alt=media&token=9cfa4e9d-391f-4aa8-9531-c78576b3464e', 'Image of Couple Watch 2', 0),

( 14, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/14.1.jpg?alt=media&token=ac23da06-256f-4d57-8b9b-80040145c142', 'Image of watch for men 3', 1),
( 14, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/14.2.jpg?alt=media&token=ab9428d7-e4ec-4b98-9831-53bc625425c0', 'Image of watch for men 3', 0),
( 14, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/14.3.jpg?alt=media&token=9bc71c2b-7d95-4e86-a764-37f478936c6a', 'Image of watch for men 3', 0),

( 15, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/15.1.jpg?alt=media&token=d4606aa6-dc7a-4a96-8b65-db408d9d3d6e', 'Image of watch for men 1',1),
( 15, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/15.2.jpg?alt=media&token=2a915b58-f6be-4471-acf2-30d472c8ad1e', 'Image of watch for men 1',0),
( 15, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/15.3.jpg?alt=media&token=b1362eb1-a468-4109-bbb7-fce249a5d3fc', 'Image of watch for men 1',0),

( 16, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/16.1.jpg?alt=media&token=43621ce1-5045-42e8-bbef-e165500d8f7c', 'Image of watch for men 1',1),
( 16, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/16.2.jpg?alt=media&token=73cf3bb6-8cb9-4ab8-a96e-1bfd428222f7', 'Image of watch for men 1',0),
( 16, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/16.3.jpg?alt=media&token=6af2fabf-517e-4599-8ff5-e11267c63ebb', 'Image of watch for men 1',0),

( 17, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/17.1.jpg?alt=media&token=77c1125e-078c-4a75-b2e9-4f857a289ed8', 'Image of watch for men 1',1),
( 17, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/17.2.jpg?alt=media&token=bb4b8351-8ed1-4377-82cf-3f1d05c7a64c', 'Image of watch for men 1',0),
( 17, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/17.3.jpg?alt=media&token=78b4240e-a5d0-4771-8481-9095f0970150', 'Image of watch for men 1',0),
( 17, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/17.4.jpg?alt=media&token=604f07f9-d274-4d47-9b22-48ee29783a41', 'Image of watch for men 1',0),

( 18, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/18.1.jpg?alt=media&token=4e253f40-8be5-4025-b828-cbce0f08229a', 'Image of watch for men 1',1),
( 18, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/18.2.jpg?alt=media&token=032b206f-6709-4c8f-b956-0ad23976aae9', 'Image of watch for men 1',0),
( 18, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/18.3.jpg?alt=media&token=45a91e52-bc6a-4eb4-be32-84edd725bde3', 'Image of watch for men 1',0),

( 19, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/19.1.jpg?alt=media&token=9d70f38d-ee00-47d0-bd0e-6092918bb8c8', 'Image of watch for men 1',1),
( 19, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/19.2.jpg?alt=media&token=2120d98f-e991-44f8-8f1c-5bd46aa5093d', 'Image of watch for men 1',0),
( 19, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/19.3.jpg?alt=media&token=3f4142ce-5d7e-472b-8a49-fcf2007f4e27', 'Image of watch for men 1',0),

( 20, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/20.1.jpg?alt=media&token=54ae4201-f725-45c5-9c96-4b23c30094fa', 'Image of watch for men 1',1),
( 20, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/20.2.jpg?alt=media&token=12532087-53d7-462e-9ad4-8eb303eac918', 'Image of watch for men 1',0),
( 20, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/20.3.jpg?alt=media&token=6b45a1a9-b854-4b71-847f-cfc1d4f3460f', 'Image of watch for men 1',0),

( 21, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/21.1.jpg?alt=media&token=64efce3e-ffbf-4d1c-b436-78f33cf96c74', 'Image of watch for men 1',1),
( 21, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/21.2.jpg?alt=media&token=2c6a6add-35fc-49d5-9cb6-473d026779ef', 'Image of watch for men 1',0),
( 21, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/21.3.jpg?alt=media&token=af0686fe-80d8-49b6-899d-ad54386c7659', 'Image of watch for men 1',0),

( 22, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/22.1.jpg?alt=media&token=bea48aa0-33b4-4d70-9a36-f569996495e1', 'Image of watch for men 1',1),
( 22, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/22.2.jpg?alt=media&token=501a5b8d-b05c-40b8-930f-2ccdb68bbe02', 'Image of watch for men 1',0),
( 22, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/22.3.jpg?alt=media&token=8db2fb2a-c888-444a-b042-5778f7833b23', 'Image of watch for men 1',0),

( 23, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/23.1.jpg?alt=media&token=6cb64f85-4d55-4f10-aca1-b214cfc1d80f', 'Image of watch for men 1',1),
( 23, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/23.2.jpg?alt=media&token=d547a9bd-ddea-4eb1-bd27-cbd3720f1d84', 'Image of watch for men 1',0),
( 23, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/23.3.jpg?alt=media&token=660cb117-34df-4d46-b475-9d39bdfbd992', 'Image of watch for men 1',0),

( 24, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/24.1.jpg?alt=media&token=224c39b1-35a9-4d4e-90aa-54f58d0dcafa', 'Image of watch for men 1',1),
( 24, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/24.2.jpg?alt=media&token=762dd4cd-b7fa-4c33-b40f-f3d6df962a04', 'Image of watch for men 1',0),
( 24, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/24.3.jpg?alt=media&token=d1a36247-9b31-4664-ad02-110b1d44ae3c', 'Image of watch for men 1',0),

( 25, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/25.1.jpg?alt=media&token=f469afa0-f0ab-44b1-b462-ea115a4c1c75', 'Image of watch for men 1',1),
( 25, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/25.2.jpg?alt=media&token=91909e20-b20e-4326-90a6-7c0ce615d781', 'Image of watch for men 1',0),
( 25, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/25.3.jpg?alt=media&token=450b73bb-4f2c-4cae-8eaa-7a02de581251', 'Image of watch for men 1',0),

( 26, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/26.1.jpg?alt=media&token=a761bc48-8249-4110-9d3f-067237e6573e', 'Image of watch for men 1',1),
( 26, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/26.2.jpg?alt=media&token=a4da5c6e-20dd-466b-80e4-1a9dbc16c5f6', 'Image of watch for men 1',0),
( 26, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/26.3.jpg?alt=media&token=bee561bc-5555-4452-9a65-38f33af618b3', 'Image of watch for men 1',0),

( 27, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/27.1.jpg?alt=media&token=9e36eb15-302d-4c8f-a00e-5726c6cf0c4c', 'Image of watch for men 1',1),
( 27, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/27.2.jpg?alt=media&token=c795e095-1242-4a4e-9bb7-7477f8226f2f', 'Image of watch for men 1',0),
( 27, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/27.3.jpg?alt=media&token=fa8fef2a-9115-4b62-81fb-b053adffbd34', 'Image of watch for men 1',0),

( 28, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/28.1.jpg?alt=media&token=31531256-1390-4a5a-8d06-51647498bffe', 'Image of watch for men 1',1),
( 28, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/28.2.jpg?alt=media&token=7e048679-7760-4cbb-b004-195e54a8b8e3', 'Image of watch for men 1',0),
( 28, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/28.3.jpg?alt=media&token=6aa7e65a-1e33-4ecc-a1be-22009be8725e', 'Image of watch for men 1',0),

( 29, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/29.1.jpg?alt=media&token=33af0177-4148-47eb-a4cb-d3151b0cd8a6', 'Image of watch for men 1',1),
( 29, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/29.2.jpg?alt=media&token=fe84a41e-e806-466c-a12d-47aac90c52e0', 'Image of watch for men 1',0),
( 29, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/29.3.jpg?alt=media&token=d8a6f852-0fb6-4c4a-b6b7-738995f212e0', 'Image of watch for men 1',0),

( 30, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/30.1.jpg?alt=media&token=52944d53-2f31-4c69-a601-4c567626f87f', 'Image of watch for men 1',1),
( 30, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/30.2.jpg?alt=media&token=9e8e42f6-b1f6-4df6-9218-b39c3a5f4fa2', 'Image of watch for men 1',0),
( 30, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/30.3.jpg?alt=media&token=b6813eb3-d716-44e7-b73f-00057090841a', 'Image of watch for men 1',0),

( 31, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/31.1.jpg?alt=media&token=17bd01df-2723-48a1-ba6b-48a47d48fccd', 'Image of watch for men 1',1),
( 31, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/31.2.jpg?alt=media&token=ef1bf626-5b5b-4ea4-ba69-58a63e7e2f51', 'Image of watch for men 1',0),
( 31, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/31.3.jpg?alt=media&token=fc35c4e8-e220-44ff-8a85-edae9c48cd2b', 'Image of watch for men 1',0),

( 32, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/32.1.jpg?alt=media&token=26986f1d-0772-4bf2-a5a8-5283b415d6f9', 'Image of watch for men 1',1),
( 32, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/32.2.jpg?alt=media&token=bd5217cb-2b8d-4d56-9a5e-f09bdbd469f8', 'Image of watch for men 1',0),
( 32, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/32.3.jpg?alt=media&token=212f6c05-8b4a-43d3-8814-5b236765c306', 'Image of watch for men 1',0),

( 33, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/33.1.jpg?alt=media&token=dde4b65a-5415-45fc-8bbc-95a240032be5', 'Image of watch for men 1',1),
( 33, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/33.2.jpg?alt=media&token=a6db4013-34d5-490e-8c59-0d49e83903a5', 'Image of watch for men 1',0),
( 33, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/33.3.jpg?alt=media&token=d5616bec-7c7b-4a8f-b926-ae5564d1c7ce', 'Image of watch for men 1',0),

( 34, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/34.1.jpg?alt=media&token=4b03d9b9-c1fb-4abe-aa7b-9ee4298924d5', 'Image of watch for men 1',1),
( 34, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/34.2.jpg?alt=media&token=aa05773e-1f10-4807-8fbc-9c9e09bf6d5e', 'Image of watch for men 1',0),
( 34, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/34.3.jpg?alt=media&token=26708dd6-bc9d-4df7-885a-2393cc22f605', 'Image of watch for men 1',0),

( 35, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/35.1.jpg?alt=media&token=dc1b5e49-2575-454c-8a64-9510a5dc6539', 'Image of watch for men 1',1),
( 35, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/35.2.jpg?alt=media&token=6f3e25d4-eff2-45e2-ac6b-ec61d1e825dc', 'Image of watch for men 1',0),
( 35, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/35.3.jpg?alt=media&token=82a860d1-c90c-4e54-b1bf-06b207e3e3f6', 'Image of watch for men 1',0),

( 36, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/10.1.jpg?alt=media&token=6d0b3ce9-bbea-4a41-9af2-14559e1b0f9c', 'Image of watch for men 1',1),
( 36, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/10.2.jpg?alt=media&token=919d2a90-3743-4362-9c21-51d4c6e80340', 'Image of watch for men 1',0),
( 36, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/10.3.jpg?alt=media&token=4ae4eb13-894e-4dd2-be2b-a9025a736229', 'Image of watch for men 1',0),

( 37, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/13.1.jpg?alt=media&token=0e0ad1e2-ca9c-4e90-b73e-894593a96ac8', 'Image of Couple Watch 2', 1),
( 37, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/13.2.jpg?alt=media&token=773a9c03-01c7-437c-809f-ad6038db1bb5', 'Image of Couple Watch 2', 0),
( 37, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/13.3.jpg?alt=media&token=9cfa4e9d-391f-4aa8-9531-c78576b3464e', 'Image of Couple Watch 2', 0),

( 38, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/9.1.jpg?alt=media&token=c1ab3f93-b882-42d1-a9f0-414871ed259b', 'Image of watch for men 3', 1),
( 38, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/9.2.jpg?alt=media&token=eabd91be-16e3-444a-9e2b-5a637d62120c', 'Image of watch for men 3', 0),
( 38, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/9.3.jpg?alt=media&token=e6da827a-9cd6-4de1-8c54-3be992b561bf', 'Image of watch for men 3', 0),

( 39, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/26.1.jpg?alt=media&token=a761bc48-8249-4110-9d3f-067237e6573e', 'Image of watch for men 1',1),
( 39, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/26.2.jpg?alt=media&token=a4da5c6e-20dd-466b-80e4-1a9dbc16c5f6', 'Image of watch for men 1',0),
( 39, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/26.3.jpg?alt=media&token=bee561bc-5555-4452-9a65-38f33af618b3', 'Image of watch for men 1',0),

( 40, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/29.1.jpg?alt=media&token=33af0177-4148-47eb-a4cb-d3151b0cd8a6', 'Image of watch for men 1',1),
( 40, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/29.2.jpg?alt=media&token=fe84a41e-e806-466c-a12d-47aac90c52e0', 'Image of watch for men 1',0),
( 40, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/29.3.jpg?alt=media&token=d8a6f852-0fb6-4c4a-b6b7-738995f212e0', 'Image of watch for men 1',0),

( 41, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/31.1.jpg?alt=media&token=17bd01df-2723-48a1-ba6b-48a47d48fccd', 'Image of watch for men 1',1),
( 41, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/31.2.jpg?alt=media&token=ef1bf626-5b5b-4ea4-ba69-58a63e7e2f51', 'Image of watch for men 1',0),
( 41, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/31.3.jpg?alt=media&token=fc35c4e8-e220-44ff-8a85-edae9c48cd2b', 'Image of watch for men 1',0),

( 42, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/24.1.jpg?alt=media&token=224c39b1-35a9-4d4e-90aa-54f58d0dcafa', 'Image of watch for men 1',1),
( 42, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/24.2.jpg?alt=media&token=762dd4cd-b7fa-4c33-b40f-f3d6df962a04', 'Image of watch for men 1',0),
( 42, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/24.3.jpg?alt=media&token=d1a36247-9b31-4664-ad02-110b1d44ae3c', 'Image of watch for men 1',0),

( 43, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/15.1.jpg?alt=media&token=d4606aa6-dc7a-4a96-8b65-db408d9d3d6e', 'Image of watch for men 1',1),
( 43, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/15.2.jpg?alt=media&token=2a915b58-f6be-4471-acf2-30d472c8ad1e', 'Image of watch for men 1',0),
( 43, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/15.3.jpg?alt=media&token=b1362eb1-a468-4109-bbb7-fce249a5d3fc', 'Image of watch for men 1',0),

( 44, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/6.1.jpg?alt=media&token=90a97372-8df1-4ae5-bd18-a81912e14dc2', 'Image of watch for men 1',1),
( 44, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/6.2.jpg?alt=media&token=ea956094-bc83-4bc0-ba0e-def64c0381fd', 'Image of watch for women 1', 0),
( 44, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/6.4.jpg?alt=media&token=cb5eb693-7e90-4910-af88-7927ab5c0a60', 'Image of Couple Watch 1', 0),

( 45, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/34.1.jpg?alt=media&token=4b03d9b9-c1fb-4abe-aa7b-9ee4298924d5', 'Image of watch for men 1',1),
( 45, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/34.2.jpg?alt=media&token=aa05773e-1f10-4807-8fbc-9c9e09bf6d5e', 'Image of watch for men 1',0),
( 45, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/34.3.jpg?alt=media&token=26708dd6-bc9d-4df7-885a-2393cc22f605', 'Image of watch for men 1',0),

( 46, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/36.1.jpg?alt=media&token=170551d3-6368-488b-a4a4-9c41160c09f5', 'Image of watch for men 1',1),
( 46, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/36.2.jpg?alt=media&token=423fb462-5121-4b68-9093-a3c74b65cb81', 'Image of watch for men 1',0),
( 46, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/36.3.jpg?alt=media&token=6c977bff-4358-4a1a-a0e9-29f2bad482ee', 'Image of watch for men 1',0),
( 46, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/36.4.jpg?alt=media&token=7996ef6e-caa8-4f41-9066-e3ddaf72b0b7', 'Image of watch for men 1',0),

( 47, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/37.jpg?alt=media&token=b19319f4-6ae0-4748-990b-605948fa4041', 'Image of watch for men 1',1),

( 48, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/38.1.jpg?alt=media&token=743568c7-eefb-4520-81ea-bd7bac0eb21b', 'Image of watch for men 1',1),
( 48, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/38.2.jpg?alt=media&token=a97dad0a-7191-4842-83df-d506d0aa505c', 'Image of watch for men 1',0),
( 48, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/38.3.jpg?alt=media&token=35f43d64-a2ee-449d-a6fa-2956de0015f9', 'Image of watch for men 1',0),
( 48, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/38.4.jpg?alt=media&token=dc26d248-4583-49e5-a7eb-d6d13dfe63d6', 'Image of watch for men 1',0),

( 49, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/39.1.jpg?alt=media&token=757fdf0d-72dc-4b87-ab2c-d81c26ae8215', 'Image of watch for men 1',1),
( 49, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/39.2.jpg?alt=media&token=f07121e4-3819-4c47-8469-82b094e7db36', 'Image of watch for men 1',0),
( 49, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/39.3.jpg?alt=media&token=b442d746-0ffd-4534-85cb-51bdf2662499', 'Image of watch for men 1',0),

( 50, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/40.1.jpg?alt=media&token=649647ff-f1ff-4175-b61c-937cac1cdb60', 'Image of watch for men 1',1),
( 50, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/40.2.jpg?alt=media&token=8d9eb3b2-125c-4911-ac46-e7905ff38a3a', 'Image of watch for men 1',0),
( 50, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/40.3.jpg?alt=media&token=9b490c9e-dbf1-49d0-b43f-4d92e8e8db34', 'Image of watch for men 1',0),
( 50, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/40.4.jpg?alt=media&token=a5a47d39-9ab7-4234-9131-d6f1693cb005', 'Image of watch for men 1',0),

( 51, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/31.1.jpg?alt=media&token=17bd01df-2723-48a1-ba6b-48a47d48fccd', 'Image of watch for men 1',1),
( 51, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/31.2.jpg?alt=media&token=ef1bf626-5b5b-4ea4-ba69-58a63e7e2f51', 'Image of watch for men 1',0),
( 51, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/31.3.jpg?alt=media&token=fc35c4e8-e220-44ff-8a85-edae9c48cd2b', 'Image of watch for men 1',0),

( 52, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/24.1.jpg?alt=media&token=224c39b1-35a9-4d4e-90aa-54f58d0dcafa', 'Image of watch for men 1',1),
( 52, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/24.2.jpg?alt=media&token=762dd4cd-b7fa-4c33-b40f-f3d6df962a04', 'Image of watch for men 1',0),
( 52, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/24.3.jpg?alt=media&token=d1a36247-9b31-4664-ad02-110b1d44ae3c', 'Image of watch for men 1',0),

( 53, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/15.1.jpg?alt=media&token=d4606aa6-dc7a-4a96-8b65-db408d9d3d6e', 'Image of watch for men 1',1),
( 53, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/15.2.jpg?alt=media&token=2a915b58-f6be-4471-acf2-30d472c8ad1e', 'Image of watch for men 1',0),
( 53, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/15.3.jpg?alt=media&token=b1362eb1-a468-4109-bbb7-fce249a5d3fc', 'Image of watch for men 1',0),

( 54, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/6.1.jpg?alt=media&token=90a97372-8df1-4ae5-bd18-a81912e14dc2', 'Image of watch for men 1',1),
( 54, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/6.2.jpg?alt=media&token=ea956094-bc83-4bc0-ba0e-def64c0381fd', 'Image of watch for women 1', 0),
( 54, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/6.4.jpg?alt=media&token=cb5eb693-7e90-4910-af88-7927ab5c0a60', 'Image of Couple Watch 1', 0),

( 55, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/34.1.jpg?alt=media&token=4b03d9b9-c1fb-4abe-aa7b-9ee4298924d5', 'Image of watch for men 1',1),
( 55, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/34.2.jpg?alt=media&token=aa05773e-1f10-4807-8fbc-9c9e09bf6d5e', 'Image of watch for men 1',0),
( 55, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/34.3.jpg?alt=media&token=26708dd6-bc9d-4df7-885a-2393cc22f605', 'Image of watch for men 1',0),

( 56, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/36.1.jpg?alt=media&token=170551d3-6368-488b-a4a4-9c41160c09f5', 'Image of watch for men 1',1),
( 56, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/36.2.jpg?alt=media&token=423fb462-5121-4b68-9093-a3c74b65cb81', 'Image of watch for men 1',0),
( 56, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/36.3.jpg?alt=media&token=6c977bff-4358-4a1a-a0e9-29f2bad482ee', 'Image of watch for men 1',0),
( 56, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/36.4.jpg?alt=media&token=7996ef6e-caa8-4f41-9066-e3ddaf72b0b7', 'Image of watch for men 1',0),

( 57, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/37.jpg?alt=media&token=b19319f4-6ae0-4748-990b-605948fa4041', 'Image of watch for men 1',1),

( 58, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/38.1.jpg?alt=media&token=743568c7-eefb-4520-81ea-bd7bac0eb21b', 'Image of watch for men 1',1),
( 58, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/38.2.jpg?alt=media&token=a97dad0a-7191-4842-83df-d506d0aa505c', 'Image of watch for men 1',0),
( 58, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/38.3.jpg?alt=media&token=35f43d64-a2ee-449d-a6fa-2956de0015f9', 'Image of watch for men 1',0),
( 58, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/38.4.jpg?alt=media&token=dc26d248-4583-49e5-a7eb-d6d13dfe63d6', 'Image of watch for men 1',0),

( 59, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/39.1.jpg?alt=media&token=757fdf0d-72dc-4b87-ab2c-d81c26ae8215', 'Image of watch for men 1',1),
( 59, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/39.2.jpg?alt=media&token=f07121e4-3819-4c47-8469-82b094e7db36', 'Image of watch for men 1',0),
( 59, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/39.3.jpg?alt=media&token=b442d746-0ffd-4534-85cb-51bdf2662499', 'Image of watch for men 1',0),

( 60, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/40.1.jpg?alt=media&token=649647ff-f1ff-4175-b61c-937cac1cdb60', 'Image of watch for men 1',1),
( 60, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/40.2.jpg?alt=media&token=8d9eb3b2-125c-4911-ac46-e7905ff38a3a', 'Image of watch for men 1',0),
( 60, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/40.3.jpg?alt=media&token=9b490c9e-dbf1-49d0-b43f-4d92e8e8db34', 'Image of watch for men 1',0),
( 60, 'https://firebasestorage.googleapis.com/v0/b/nguyen-dang.appspot.com/o/40.4.jpg?alt=media&token=a5a47d39-9ab7-4234-9131-d6f1693cb005', 'Image of watch for men 1',0);


INSERT INTO ProductReviews (proID, accID, revText, revRating) VALUES
(1, 2, 'Great watch!', 5),
(2, 2, 'Love this watch!', 5),
(3, 3, 'Beautiful couple watch!', 3),
(4, 3, 'Fun kids watch!', 4),
(5, 3, 'Useful accessory!', 4),
(6, 4, 'Good quality men watch!', 4),
(7, 4, 'Stylish women watch!', 5),
(8, 5, 'Romantic couple watch!', 5),
(9, 5, 'Educational kids watch!', 4),
(10, 5, 'Practical accessory!', 4),
(1, 2, 'Great watch!', 5),
(2, 2, 'Love this watch!', 5),
(3, 3, 'Beautiful couple watch!', 3),
(4, 3, 'Fun kids watch!', 2),
(5, 3, 'Useful accessory!', 3),
(6, 4, 'Good quality men watch!', 4),
(7, 4, 'Stylish women watch!', 4),
(8, 5, 'Romantic couple watch!', 2),
(9, 5, 'Educational kids watch!', 1),
(10, 5, 'Practical accessory!', 3),
(1, 2, 'Great watch!', 3),
(2, 2, 'Love this watch!', 2),
(3, 3, 'Beautiful couple watch!', 5),
(4, 3, 'Fun kids watch!', 5),
(5, 3, 'Useful accessory!', 5),
(6, 4, 'Good quality men watch!', 5),
(7, 4, 'Stylish women watch!', 4),
(8, 5, 'Romantic couple watch!', 5),
(9, 5, 'Educational kids watch!', 5),
(10, 5, 'Practical accessory!', 5),
(1, 2, 'Great watch!', 5),
(2, 2, 'Love this watch!', 5),
(3, 3, 'Beautiful couple watch!', 5),
(4, 3, 'Fun kids watch!', 3),
(5, 3, 'Useful accessory!', 5),
(6, 4, 'Good quality men watch!', 4),
(7, 4, 'Stylish women watch!', 4),
(8, 5, 'Romantic couple watch!', 4),
(9, 5, 'Educational kids watch!', 5),
(10, 5, 'Practical accessory!', 5),
(1, 2, 'Great watch!', 5),
(2, 2, 'Love this watch!', 5),
(3, 3, 'Beautiful couple watch!', 3),
(4, 3, 'Fun kids watch!', 4),
(5, 3, 'Useful accessory!', 4),
(6, 4, 'Good quality men watch!', 4),
(7, 4, 'Stylish women watch!', 5),
(8, 5, 'Romantic couple watch!', 5),
(9, 5, 'Educational kids watch!', 4),
(10, 5, 'Practical accessory!', 4),
(1, 2, 'Great watch!', 5),
(2, 2, 'Love this watch!', 5),
(3, 3, 'Beautiful couple watch!', 3),
(4, 3, 'Fun kids watch!', 4),
(5, 3, 'Useful accessory!', 4),
(6, 4, 'Good quality men watch!', 4),
(7, 4, 'Stylish women watch!', 5),
(8, 5, 'Romantic couple watch!', 5),
(9, 5, 'Educational kids watch!', 4),
(10, 5, 'Practical accessory!', 4),
(1, 2, 'Great watch!', 5),
(2, 2, 'Love this watch!', 5),
(3, 3, 'Beautiful couple watch!', 3),
(4, 3, 'Fun kids watch!', 4),
(5, 3, 'Useful accessory!', 3),
(6, 4, 'Good quality men watch!', 4),
(7, 4, 'Stylish women watch!', 4),
(8, 5, 'Romantic couple watch!', 4),
(9, 5, 'Educational kids watch!', 3),
(10, 5, 'Practical accessory!', 3),
(1, 2, 'Great watch!', 5),
(2, 2, 'Love this watch!', 5),
(3, 3, 'Beautiful couple watch!', 3),
(4, 3, 'Fun kids watch!', 4),
(5, 3, 'Useful accessory!', 4),
(6, 4, 'Good quality men watch!', 4),
(7, 4, 'Stylish women watch!', 4),
(8, 5, 'Romantic couple watch!', 4),
(9, 5, 'Educational kids watch!', 4),
(10, 5, 'Practical accessory!', 4),
(1, 2, 'Great watch!', 5),
(2, 2, 'Love this watch!', 5),
(3, 3, 'Beautiful couple watch!', 3),
(4, 3, 'Fun kids watch!', 4),
(5, 3, 'Useful accessory!', 4),
(6, 4, 'Good quality men watch!', 4),
(7, 4, 'Stylish women watch!', 5),
(8, 5, 'Romantic couple watch!', 5),
(9, 5, 'Educational kids watch!', 5),
(10, 5, 'Practical accessory!', 4),
(1, 2, 'Great watch!', 5),
(2, 2, 'Love this watch!', 5),
(3, 3, 'Beautiful couple watch!', 3),
(4, 3, 'Fun kids watch!', 4),
(5, 3, 'Useful accessory!', 5),
(6, 4, 'Good quality men watch!', 4),
(7, 4, 'Stylish women watch!', 5),
(8, 5, 'Romantic couple watch!', 5),
(9, 5, 'Educational kids watch!', 4),
(10, 5, 'Practical accessory!', 4),
(1, 2, 'Great watch!', 5),
(2, 2, 'Love this watch!', 5),
(3, 3, 'Beautiful couple watch!', 3),
(4, 3, 'Fun kids watch!', 4),
(5, 3, 'Useful accessory!', 4),
(6, 4, 'Good quality men watch!', 4),
(7, 4, 'Stylish women watch!', 5),
(8, 5, 'Romantic couple watch!', 5),
(9, 5, 'Educational kids watch!', 4),
(10, 5, 'Practical accessory!', 4),
(1, 2, 'Great watch!', 5),
(2, 2, 'Love this watch!', 5),
(3, 3, 'Beautiful couple watch!', 3),
(4, 3, 'Fun kids watch!', 4),
(5, 3, 'Useful accessory!', 4),
(6, 4, 'Good quality men watch!', 4),
(7, 4, 'Stylish women watch!', 5),
(8, 5, 'Romantic couple watch!', 5),
(9, 5, 'Educational kids watch!', 4),
(10, 5, 'Practical accessory!', 4),
(1, 2, 'Great watch!', 5),
(2, 2, 'Love this watch!', 5),
(3, 3, 'Beautiful couple watch!', 3),
(4, 3, 'Fun kids watch!', 4),
(5, 3, 'Useful accessory!', 4),
(6, 4, 'Good quality men watch!', 4),
(7, 4, 'Stylish women watch!', 5),
(8, 5, 'Romantic couple watch!', 3),
(9, 5, 'Educational kids watch!', 4),
(10, 5, 'Practical accessory!', 4),
(1, 2, 'Great watch!', 5),
(2, 2, 'Love this watch!', 5),
(3, 3, 'Beautiful couple watch!', 3),
(4, 3, 'Fun kids watch!', 4),
(5, 3, 'Useful accessory!', 4),
(6, 4, 'Good quality men watch!', 4),
(7, 4, 'Stylish women watch!', 5),
(8, 5, 'Romantic couple watch!', 5),
(9, 5, 'Educational kids watch!', 4),
(10, 5, 'Practical accessory!', 4);

INSERT INTO OrderStatus (sttName, sttDescription) VALUES
('Pending', 'Order is pending'),
('Shipped', 'Order has been shipped'),
('Delivered', 'Order has been delivered'),
('Cancelled', 'Order has been cancelled');

INSERT INTO Shipping (shipMethod, shipCost, shipDate)
VALUES
('Express', 10, 'Delivery from 1 to 2 days'),
('Standard', 5, 'Delivery from 2 to 4 days'),
('Economy delivery', 3, 'Delivery from 5 to 7 days');

INSERT INTO Orders (accID, orderDate, totalCost, sttID, shipID) VALUES
(2, '2024-01-11', 1000, 3, 1),
(2, '2024-01-11', 1000, 3, 1),
(2, '2024-01-11', 1000, 3, 1),
(2, '2024-02-11', 1000, 3, 1),
(2, '2024-02-11', 1000, 3, 1),
(3, '2024-02-11', 1000, 3, 1),
(3, '2024-03-11', 1000, 3, 1),
(3, '2024-03-11', 1000, 3, 1),
(3, '2024-04-11', 1000, 3, 1),
(3, '2024-04-11', 1000, 3, 1),
(4, '2024-04-11', 1222, 3, 1),
(4, '2024-05-11', 1000, 3, 1),
(4, '2024-06-11', 1111, 3, 1),
(4, '2024-06-11', 1000, 3, 1),
(4, '2024-07-11', 1000, 3, 1),
(4, '2024-07-11', 1000, 3, 1),
(4, '2024-08-11', 1000, 3, 1),
(4, '2024-08-11', 1000, 3, 1),
(5, '2024-09-11', 1000, 3, 1),
(5, '2024-09-11', 1000, 3, 1),
(6, '2024-10-11', 1000, 3, 1),
(7, '2024-10-11', 1000, 3, 1),
(8, '2024-11-11', 1000, 3, 1),
(9, '2024-11-11', 1000, 3, 1),
(9, '2024-12-11', 1000, 3, 1),
(10, '2024-12-11', 1000, 3, 1),
(2, '2020-05-01', 1000, 3, 1),
(2, '2020-06-01', 100, 3, 1),
(2, '2020-07-01', 2000, 3, 1),
(2, '2020-08-01', 300, 3, 1),
(3, '2020-09-01', 400, 3, 1),
(4, '2021-04-01', 500, 3, 1),
(4, '2021-06-01', 600, 3, 1),
(2, '2021-07-01', 700, 3, 1),
(4, '2021-05-01', 800, 3, 1),
(2, '2021-01-01', 900, 3, 1),
(4, '2022-02-01', 1080, 3, 1),
(5, '2023-03-01', 1100, 3, 1),
(5, '2023-08-01', 1200, 3, 1),
(2, '2023-01-01', 1000, 3, 1),
(2, '2023-07-01', 1000, 3, 1),
(2, '2023-12-01', 200, 3, 1),
(2, '2023-02-01', 300, 3, 1),
(3, '2023-02-01', 400, 3, 1),
(3, '2020-12-01', 500, 3, 1),
(3, '2020-10-01', 600, 3, 1),
(3, '2021-04-01', 700, 3, 1),
(4, '2021-04-01', 800, 3, 1),
(5, '2021-06-01', 565, 3, 1),
(2, '2024-06-01', 1000, 3, 1),
(3, '2024-01-01', 1100, 3, 1),
(4, '2024-02-01', 300, 3, 1),
(3, '2024-03-01', 400, 3, 1),
(2, '2024-04-01', 1000, 3, 1),
(3, '2024-05-01', 1200, 3, 1),
(3, '2024-06-01', 200, 3, 1),
(2, '2024-07-01', 1500, 3, 1),
(5, '2024-08-01', 2000, 3, 1),
(5, '2024-09-01', 2854, 3, 1),
(4, '2024-10-01', 1936, 3, 1),
(4, '2024-11-01', 1746, 3, 1),
(5, '2024-12-01', 1367, 3, 1),
(2, '2022-01-01', 1000, 1, 1),
(2, '2022-01-01', 100, 2, 1),
(2, '2024-01-01', 200, 1, 1),
(2, '2024-02-01', 300, 3, 1),
(3, '2024-02-01', 400, 1, 1),
(3, '2024-02-01', 500, 2, 1),
(3, '2024-02-01', 600, 3, 1),
(3, '2024-04-01', 700, 1, 1),
(4, '2024-04-01', 800, 1, 1),
(5, '2024-06-01', 900, 3, 1),
(5, '2024-06-01', 1000, 1, 1),
(5, '2024-08-01', 1100, 1, 1),
(5, '2024-08-01', 1200, 1, 1),
(3, '2022-01-05', 8200, 2, 2),
(3, '2022-01-10', 1200, 3, 3),
(4, '2022-01-15', 5000, 1, 2),
(5, '2022-01-20', 250, 2, 3);

INSERT INTO OrderDetails (orderID, proID, unitPrice, quantity) VALUES
(1, 5, 550.00, 2),
(2, 6, 600.00, 3),
(3, 7, 700.00, 1),
(4, 8, 800.00, 4),
(5, 9, 900.00, 2),
(6, 10, 1200.00, 5),
(7, 11, 1300.00, 3),
(8, 12, 1400.00, 1),
(9, 13, 1500.00, 2),
(10, 14, 1600.00, 4),
(11, 15, 1700.00, 1),
(12, 16, 1800.00, 5),
(13, 17, 1900.00, 3),
(14, 18, 1550.00, 2),
(15, 19, 1650.00, 4),
(16, 20, 1750.00, 1),
(17, 21, 1850.00, 3),
(18, 22, 1950.00, 2),
(19, 23, 500.00, 5),
(20, 24, 600.00, 3),
(21, 25, 700.00, 4),
(22, 26, 800.00, 3),
(23, 27, 900.00, 5),
(24, 28, 1000.00, 2),
(25, 29, 1100.00, 1),
(26, 30, 1200.00, 3),
(27, 1, 1300.00, 2),
(28, 2, 1400.00, 4),
(29, 3, 1500.00, 2),
(30, 4, 1600.00, 5),
(31, 5, 1700.00, 1),
(32, 6, 1800.00, 4),
(33, 7, 1900.00, 3),
(34, 8, 2000.00, 2),
(35, 9, 550.00, 1),
(36, 10, 650.00, 4),
(37, 11, 750.00, 3),
(38, 12, 850.00, 2),
(39, 13, 950.00, 1),
(40, 14, 1050.00, 5),
(41, 15, 1150.00, 2),
(42, 16, 1250.00, 3),
(43, 17, 1350.00, 4),
(44, 18, 1450.00, 1),
(45, 19, 1550.00, 5),
(46, 20, 1650.00, 2),
(47, 21, 1750.00, 3),
(48, 5, 250.00, 2),
(9, 6, 175.50, 3),
(3, 7, 180.00, 1),
(4, 8, 220.00, 4),
(5, 9, 300.00, 2),
(6, 10, 130.00, 5),
(7, 11, 140.00, 3),
(8, 12, 160.00, 1),
(9, 13, 190.00, 2),
(10, 14, 210.00, 4),
(11, 15, 180.00, 1),
(12, 16, 200.00, 5),
(13, 17, 150.00, 3),
(14, 18, 175.00, 2),
(15, 19, 250.00, 4),
(16, 20, 300.00, 1),
(17, 21, 280.00, 3),
(18, 22, 150.00, 2),
(19, 23, 110.00, 5),
(20, 24, 190.00, 3),
(21, 25, 120.00, 4),
(22, 26, 180.00, 3),
(23, 27, 240.00, 5),
(24, 28, 170.00, 2),
(25, 29, 130.00, 1),
(26, 30, 200.00, 3),
(27, 1, 250.00, 2),
(28, 2, 175.50, 4),
(29, 3, 180.00, 2),
(30, 4, 220.00, 3),
(33, 5, 300.00, 1),
(32, 6, 130.00, 5),
(33, 7, 140.00, 3),
(34, 8, 160.00, 1),
(35, 9, 190.00, 4),
(36, 10, 180.00, 3),
(57, 11, 200.00, 2),
(58, 12, 250.00, 1),
(10, 14, 175.00, 5),
(11, 15, 120.00, 2),
(12, 16, 220.00, 3),
(13, 17, 210.00, 1),
(14, 18, 200.00, 4),
(15, 19, 130.00, 3),
(16, 20, 240.00, 1),
(1, 1, 1000, 1),
(1, 2, 800, 1),
(1, 4, 100, 1),
(2, 2, 800, 1),
(2, 3, 500, 1),
(2, 5, 300, 1),
(2, 7, 100, 1),
(3, 3, 1200, 1),
(4, 4, 500, 1),
(5, 5, 2000, 1);

INSERT INTO PaymentInformation (orderID, payMethod, payDate, payAmount) VALUES
(1, 'Credit Card', '2022-01-01', 1000),
(2, 'Cash', '2022-01-05', 800),
(3, 'Bank Transfer', '2022-01-10', 1200),
(4, 'Credit Card', '2022-01-15', 500),
(5, 'Cash', '2022-01-20', 2000),
(1, 'Bank Transfer', '2022-01-25', 1000),
(2, 'Credit Card', '2022-02-01', 800),
(3, 'Cash', '2022-02-05', 1200),
(4, 'Credit Card', '2022-02-10', 500),
(5, 'Bank Transfer', '2022-02-15', 200);


INSERT INTO WarrantyInformation ( proID, warPeriod, warDescription)
VALUES
( 1, 12, '1-year warranty for Men Watch 1'),
( 2, 12, '1-year warranty for Women Watch 1'),
( 3, 12, '1-year warranty for Couple Watch 1'),
( 4, 12, '1-year warranty for Kids Watch 1'),
( 5, 12, '1-year warranty for Accessory 1');

--DELETE FROM WarrantyInformation;
--DELETE FROM PaymentInformation;
--DELETE FROM OrderDetails;
--DELETE FROM Orders;
--DELETE FROM Shipping;
--DELETE FROM OrderStatus;
--DELETE FROM ProductReviews;
--DELETE FROM ProductImages;
--DELETE FROM UserDiscounts;
--DELETE FROM DiscountCodes;
--DELETE FROM Cart;
--DELETE FROM Products;
--DELETE FROM Categories;
--DELETE FROM Accounts;
--DELETE FROM Suppliers;