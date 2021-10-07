
create database EverythingСarries
COLLATE Cyrillic_General_CI_AS
GO
-- Создание таблицы информации о терминалах
use EverythingСarries
CREATE TABLE Terminals
(
    IdTerminal INT IDENTITY, 
    TerminalTitle VARCHAR(20) UNIQUE, 
    TerminalAddress VARCHAR(50) UNIQUE, 
	CONSTRAINT PK_IdTerminal PRIMARY KEY (IdTerminal)
)
-- Создание таблицы информации о заказах
CREATE TABLE CargoList
(
    IdCargo INT IDENTITY,    
    IdSendingTerminal INT,    
    IdReceivingTerminal INT,
-- Груз может быть составным и занимать несколько мест, поэтому SeatNumber - строка 
    SeatNumber VARCHAR(20),    
    [Length] INT,
    Height INT,    
    Width INT,
    [Weight] INT,    
    CargoStatus VARCHAR(15),
    DepartureDate DATE,
    ArrivalDate DATE,
	CONSTRAINT PK_IdCargo PRIMARY KEY (IdCargo),	
    CONSTRAINT FK_IdSendingTerminal FOREIGN KEY (IdSendingTerminal) REFERENCES Terminals (IdTerminal),
    CONSTRAINT FK_IdReceivingTerminal FOREIGN KEY (IdReceivingTerminal) REFERENCES Terminals (IdTerminal)
)
