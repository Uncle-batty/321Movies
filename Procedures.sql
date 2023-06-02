use Movies321;

--Procedures

--Updates veiws  
Create procedure UpdateViews
@Movie_title varchar(50)
As
Update Movies 
Set Views = Views + 1
where MovieTitle = @Movie_title;

--addmin sign in
create procedure adminSignIn_st
@email varchar(100),
@Password varchar(1000)
as
select * from Admin where email = @email and Password = @Password;
go

--Add admin
create procedure adminSignUp_st(
@AdminID Int,
@Fname varchar(100),
@Lname varchar(100),
@email varchar(100),
@Password varchar(100))
as 
insert into Admin values(@AdminID, @Fname, @Lname, @email, @Password);
go

--Addusers
create procedure userSignUp_st(
 @UserId varchar(100),
 @Password varchar(max),
 @Email varchar(100),
 @Fname varchar(100),
 @Lname varchar(100),
 @SubID int,
 @User_DOB Date,
 @Datelastpaid Date)
as
insert into Users values(@UserId,@Password, @Email, @Fname, @Lname, @SubID, @User_DOB, @Datelastpaid);
go

--Add Payment method
create procedure AddUserPayments_st(
@PaymentId varchar(100),
@cardNumber varchar(20),
@ExpDate varchar(10),
@CVV int,
@UserID varchar(100))
as 
insert into Payment_details values (@PaymentId, @cardNumber, @ExpDate, @CVV, @UserID);

--User watchlist
Create procedure seeWatchlist
@userid varchar(50)
AS
SELECT u.Fname, m.MovieTitle, m.ShortDiscription
FROM Watchlist w
inner join Movies m
on m.MovieID = w.MovieID
inner join users u
on u.UserId = w.Userid
where w.Userid = @userid

--Update user
Create procedure UpdateUser
@fname varchar(50),
@lname varchar(50),
@email varchar(50),
@password varchar(50)
AS
if @fname is not null
begin
 Update Users 
 set Fname = @fname
 end
 if @lname is not null
begin
 Update Users 
 set Lname = @lname
 end
 if @email is not null
begin
 Update Users 
 set Email = @email
 end
 if @password is not null
begin
 Update Users 
 set Password = @password
 end

 --Add to watch list
 Create procedure AddtoWatchList
 @userid varchar(50),
 @movieId varchar(50)
 AS
 Insert into Watchlist (Userid,MovieID) Values(@userid,@movieid)

 --Update raiting 
 CREATE PROCEDURE Updaterating
 @movieid varchar(50),
 @Rateing int
 AS
 Update Movies
 set Ratings = ((Ratings * Views) + @Rateing)/Views
 where MovieTitle = @movieid;


 --Get user subscription id
 Create procedure Getusersubid
 @username varchar(50)
 AS
 SELECT SubID from Users where Email = @username
