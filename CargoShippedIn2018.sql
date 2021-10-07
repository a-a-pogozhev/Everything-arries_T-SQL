/*	������� ������ ���������� � ��������� ����� ������, ������� ��������� �� 2018 ���.	*/

USE Everything�arries

SELECT Terminals.TerminalTitle as [�������� ���������], CargoList.[Weight] as [����� �����]
FROM CargoList
JOIN Terminals ON Terminals.IdTerminal = CargoList.IdSendingTerminal
WHERE YEAR(CargoList.DepartureDate) = 2018 AND (CargoList.CargoStatus = '���������' OR CargoList.CargoStatus = '� ��������');