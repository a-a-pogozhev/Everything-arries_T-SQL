/*	������� ������ ����������, ��� ������� ���� ������� ���������� �����. 
������ ����������� �� �������� ���������. 	*/

USE Everything�arries

SELECT TerminalTitle as [�������� ���������], TerminalAddress as [����� ���������] 
FROM Terminals WHERE IdTerminal IN 
	( 
	SELECT IdSendingTerminal FROM CargoList WHERE IdCargo IN (
	SELECT IdCargo FROM CargoList WHERE 
	(GETDATE() BETWEEN CargoList.DepartureDate AND CargoList.ArrivalDate) AND CargoStatus = '�������' )  
    UNION
    SELECT IdReceivingTerminal FROM CargoList WHERE IdCargo IN (
	SELECT IdCargo FROM CargoList WHERE 
	(GETDATE() BETWEEN CargoList.DepartureDate AND CargoList.ArrivalDate) AND CargoStatus = '�������' )
    )
    ORDER BY TerminalTitle
	