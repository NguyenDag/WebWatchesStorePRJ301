--DROP DATABASE Watches_Store
--Create DATABASE Watches_Store

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


--drop table WarrantyInformation;
--drop table PaymentInformation;
--drop table OrderDetails;
--drop table Orders;
--drop table Shipping;
--drop table OrderStatus;
--drop table ProductReviews;
--drop table ProductImages;
--drop table UserDiscounts;
--drop table DiscountCodes;
--drop table Cart
--drop table Products;
--drop table Categories;
--drop table Suppliers;
--drop table Accounts;
