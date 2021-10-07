/*	������� ���� ���������� � � � � ���������� �������� ����� ���� 
(�� � � � � �� � � �) �� ���������� ������ �� 2018 ���. 
������ ����������� �� ���������� ����������� ������ �� ��������.	*/

use Everything�arries

CREATE TABLE #TestTable (IdSendingTerminal INT, IdReceivingTerminal INT, SumWeightCargo INT)
-- ��������� ������� �������
INSERT INTO #TestTable
SELECT IdSendingTerminal, IdReceivingTerminal, SUM(Weight)  
FROM CargoList
WHERE YEAR(DepartureDate) = 2018 
GROUP BY IdSendingTerminal, IdReceivingTerminal
WITH ROLLUP 
-- ������� ������� ��������, ��������������� ROLLUP
DELETE FROM #TestTable WHERE (IdSendingTerminal IS NULL) OR (IdReceivingTerminal IS NULL)
-- ������� ������������� ���������
SELECT * FROM #TestTable
--���������� ��� �������� ������� ���������� � ������������ ����� ���� ������
DECLARE @IdSendTerm INT, @IdRecTerm INT, @MaxSumWeightCargo INT
SET @MaxSumWeightCargo = (SELECT MAX(SumWeightCargo) FROM #TestTable)
SET @IdSendTerm = (SELECT IdSendingTerminal FROM #TestTable WHERE SumWeightCargo = @MaxSumWeightCargo)
SET @IdRecTerm = (SELECT IdReceivingTerminal FROM #TestTable WHERE SumWeightCargo = @MaxSumWeightCargo)
--��������� ������� ��� ������������� ���������� � ���������� � �������
SELECT * INTO #TestTable1 FROM Terminals

SELECT Terminals.TerminalTitle AS [������������ ��������], #TestTable1.TerminalTitle AS [����������� ��������], 
SumWeightCargo AS [��������� ��� �����] FROM #TestTable 
JOIN Terminals ON Terminals.IdTerminal = #TestTable.IdSendingTerminal
JOIN #TestTable1 ON #TestTable1.IdTerminal = #TestTable.IdReceivingTerminal
--����� �� ��������� �������� � ������������ ������
WHERE (SumWeightCargo = @MaxSumWeightCargo)  
--����� �� "��������� ���������"
	OR (IdReceivingTerminal = @IdSendTerm AND IdSendingTerminal = @IdRecTerm) 
ORDER BY SumWeightCargo DESC

drop table #TestTable
drop table #TestTable1