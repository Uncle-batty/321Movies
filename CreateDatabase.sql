CREATE DATABASE Movies321;

USE Movies321;

CREATE TABLE [Payment_details] (
  [PaymentID] Varchar(50),
  [CardNumber] varchar(50),
  [ExpDate] varchar(50),
  [CSV] int,
  [UserID] Varchar(50),
  PRIMARY KEY ([PaymentID])
);

CREATE TABLE [Catagories] (
  [CatergoryID] int,
  [Name] varchar(50),
  PRIMARY KEY ([CatergoryID])
);

CREATE TABLE [Subscription_level] (
  [Sub_ID] int,
  [Name] varchar(20),
  [Price] Float,
  PRIMARY KEY ([Sub_ID])
);

CREATE TABLE [Directors] (
  [DirectorID] int,
  [DirectorFName] varchar(50),
  [DirectorLName] varchar(50),
  PRIMARY KEY ([DirectorID])
);

CREATE TABLE [Movies] (
  [MovieID] varchar(10),
  [MovieTitle] varchar(50),
  [Runtime] time,
  [Release_Year] date,
  [TrailerLInk] varchar(50),
  [Ratings] varchar(10),
  [AgeRating] int,
  [ShortDiscription] varchar(300),
  [CatergoryID] int,
  [DirectorID] int,
  [SubID] int,
  [Views] int,
  [ImageName] varchar(100),
  PRIMARY KEY ([MovieID]),
  CONSTRAINT [FK_Movies.SubID]
    FOREIGN KEY ([SubID])
      REFERENCES [Subscription_level]([Sub_ID]),
  CONSTRAINT [FK_Movies.DirectorID]
    FOREIGN KEY ([DirectorID])
      REFERENCES [Directors]([DirectorID])
);

CREATE TABLE [Users] (
  [UserId] varchar(50),
  [Password] varchar(100),
  [Email] nvarchar(50),
  [Fname] varchar(50),
  [Lname] varchar(50),
  [SubID] int,
  [User_DOB] Date,
  [Datelastpaid] Date,
  PRIMARY KEY ([UserId]),
  CONSTRAINT [FK_Users.SubID]
    FOREIGN KEY ([SubID])
      REFERENCES [Subscription_level]([Sub_ID])
);

CREATE TABLE [Watchlist] (
  [ListtID] int,
  [Userid] varchar(50),
  [MovieID] varchar(10),
  PRIMARY KEY ([ListtID]),
  CONSTRAINT [FK_Watchlist.MovieID]
    FOREIGN KEY ([MovieID])
      REFERENCES [Movies]([MovieID]),
  CONSTRAINT [FK_Watchlist.Userid]
    FOREIGN KEY ([Userid])
      REFERENCES [Users]([UserId])
);

CREATE TABLE [Admin] (
  [AdminID] Int,
  [Fname] varchar(50),
  [Lname] varchar(50),
  [email] nvarchar(50),
  [Password] varchar(50),
  PRIMARY KEY ([AdminID])
);

CREATE TABLE [Invoices] (
  [InvoiceID] int,
  [Date] Date,
  [PayBy] Date,
  [UserID] Varchar(50),
  PRIMARY KEY ([InvoiceID]),
  CONSTRAINT [FK_Invoices.InvoiceID]
    FOREIGN KEY ([UserID])
      REFERENCES [Users]([UserId])
);




