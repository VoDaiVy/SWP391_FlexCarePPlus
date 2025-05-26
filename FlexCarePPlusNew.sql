create database FlexCarePPlus

use FlexCarePPlus

create table Policy(
PolicyID int identity(1,1) primary key,
Title nvarchar(100) null,
Description nvarchar(MAX) null,
DataCreated date default getdate(),
Status bit not null
)

create table CategoryService(
CategoryServiceID int identity(1,1) primary key,
Name nvarchar(100) null,
Status bit not null,
)

create table Service(
ServiceID int identity(1,1) primary key,
CategoryServiceID int not null,
Name nvarchar(100) null,
Description nvarchar(MAX) null,
Price money null,
Time int null,
Views int null,
ImgURL varchar(MAX) null,
Status bit null,
constraint FK_Service_CategoryService foreign key (CategoryServiceID) references CategoryService(CategoryServiceID)
)

create table ServiceImage(
ServiceImageID int identity(1,1) primary key,
ServiceID int not null,
ImgURL varchar(MAX),
constraint FK_ServiceImage_Service foreign key (ServiceID) references Service(ServiceID)
)

create table Room(
RoomID int identity(1,1) primary key,
ServiceID int not null,
Name nvarchar(100) null,
RoomNumber int null,
Status bit null,
constraint FK_Room_Service foreign key (ServiceID) references Service(ServiceID)
)

create table Users(
UserID int identity(1,1) primary key,
UserName varchar(100) unique null,
PassWord varchar(100) null,
Email varchar(100) unique null,
Status bit default 1,
Role varchar(50) null
)

create table Cart(
UserID int not null,
ServiceID int not null,
Stock tinyint default 1,
Display bit default 1,
StatusBooking bit null,
constraint PK_Cart primary key (UserID, ServiceID),
constraint FK_Cart_Service foreign key (ServiceID) references Service(ServiceID),
constraint FK_Cart_User foreign key (UserID) references Users(UserID)
)

create table Booking(
BookingID int identity(1,1) primary key,
UserID int not null,
RoomID int not null,
DataBooked datetime default getdate(),
TotalPrice money null,
Paid money null,
State nvarchar(100) null,
Note nvarchar(MAX) null,
Status bit null,
constraint FK_Booking_User foreign key (UserID) references Users(UserID),
constraint FK_Booking_Room foreign key (RoomID) references Room(RoomID)
)

create table BookingDetail(
BookingID int not null,
ServiceID int not null,
StockBooking int not null,
DataStartService datetime null,
DataEndService datetime null,
StartTime time null,
EndTime time null,
Price money not null,
constraint PK_BookingDetail primary key (BookingID, ServiceID),
constraint FK_BookingDetail_Booking foreign key (BookingID) references Booking(BookingID) ,
constraint FK_BookingDetail_Service foreign key (ServiceID) references Service(ServiceID) 
)

create table FeedbackService(
FeedbackServiceID int identity(1,1) primary key,
UserID int not null,
ServiceID int not null,
BookingID int not null,
DataCreated datetime default getdate(),
Rating int null,
Comment nvarchar(100) null,
Status bit null,
constraint FK_FeedbackService_User foreign key (UserID) references Users(UserID),
constraint FK_FeedbackService_Service foreign key (ServiceID) references Service(ServiceID)
)

create table UserDetail(
UserID int primary key,
FirstName nvarchar(50) null,
LastName nvarchar(50) null,
Tel varchar(10) null,
DOB date null,
Gender nvarchar(30) null,
Avatar nvarchar(MAX) null,
constraint FK_UserDetail_User foreign key (UserID) references Users(UserID),
constraint CK_UserDetail_Tel CHECK (Tel LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
constraint CK_UserDetail_Gender CHECK (Gender in (N'Male',N'Female',N'Other'))
)

create table Message(
MessageID int identity(1,1) primary key,
UserID int not null,
UserReceiveID int not null,
TimeChat datetime default getdate(),
Status bit default 1,
Content nvarchar(MAX) not null,
constraint FK_Message_Person foreign key (UserID) references Users(UserID) ,
constraint FK_Message_PersonReceive foreign key (UserReceiveID) references Users(UserID) 
)

create table Notifications(	
NotificationID int identity(1,1) primary key,
Content nvarchar(MAX) null,
DataCreated datetime default getdate()
)

create table NotificationUser(
NotificationID int not null,
UserID int not null,
Status bit default 1,
HasRead bit default 0,
constraint PK_NotificationUser primary key (UserID, NotificationID),
constraint FK_NotificationUser_User foreign key (UserID) references Users(UserID),
constraint FK_NotificationUser_Notifications foreign key (NotificationID) references Notifications(NotificationID)
)

create table Wallet(
UserID int primary key,
Amount money default 0,
Status bit not null,
constraint FK_Wallet_Person foreign key (UserID) references Users(UserID) 
)

create table WalletTransfer (
WalletTransferID int identity(1,1) primary key,
TransCode nvarchar(10),
TimeCode nvarchar(20),
UserID int,
Amount money,
IsRefunded bit
)

create table News(
NewsID int identity(1,1) primary key,
Title nvarchar(100) null,
Description nvarchar(MAX) null,
Views int null,
DataCreated date default getdate(),
ImgURL varchar(MAX),
Status bit not null
)

create table NewsImage(
NewsImageID int identity(1,1) primary key,
NewsID int not null,
ImgURL varchar(MAX),
constraint FK_NewsImage_News foreign key (NewsID) references News(NewsID)
)