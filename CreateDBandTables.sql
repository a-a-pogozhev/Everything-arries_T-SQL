
create database Everything�arries
COLLATE Cyrillic_General_CI_AS
GO
-- �������� ������� ���������� � ����������
use Everything�arries
CREATE TABLE Terminals
(
    IdTerminal INT IDENTITY, 
    TerminalTitle VARCHAR(20) UNIQUE, 
    TerminalAddress VARCHAR(50) UNIQUE, 
	CONSTRAINT PK_IdTerminal PRIMARY KEY (IdTerminal)
)
-- �������� ������� ���������� � �������
CREATE TABLE CargoList
(
    IdCargo INT IDENTITY,    
    IdSendingTerminal INT,    
    IdReceivingTerminal INT,
-- ���� ����� ���� ��������� � �������� ��������� ����, ������� SeatNumber - ������ 
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
