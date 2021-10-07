/*	Выбрать пары терминалов А и Б с наибольшим оборотом между ними 
(из А в Б и из Б в А) по количеству грузов за 2018 год. 
Список упорядочить по количеству перевозимых грузов по убыванию.	*/

use EverythingСarries

CREATE TABLE #TestTable (IdSendingTerminal INT, IdReceivingTerminal INT, SumWeightCargo INT)
-- Заполняем сводную таблицу
INSERT INTO #TestTable
SELECT IdSendingTerminal, IdReceivingTerminal, SUM(Weight)  
FROM CargoList
WHERE YEAR(DepartureDate) = 2018 
GROUP BY IdSendingTerminal, IdReceivingTerminal
WITH ROLLUP 
-- Удаляем нулевые значения, сгенерированные ROLLUP
DELETE FROM #TestTable WHERE (IdSendingTerminal IS NULL) OR (IdReceivingTerminal IS NULL)
-- Выводим промежуточный результат
SELECT * FROM #TestTable
--Переменные для хранения номеров терминалов и максимальной суммы веса грузов
DECLARE @IdSendTerm INT, @IdRecTerm INT, @MaxSumWeightCargo INT
SET @MaxSumWeightCargo = (SELECT MAX(SumWeightCargo) FROM #TestTable)
SET @IdSendTerm = (SELECT IdSendingTerminal FROM #TestTable WHERE SumWeightCargo = @MaxSumWeightCargo)
SET @IdRecTerm = (SELECT IdReceivingTerminal FROM #TestTable WHERE SumWeightCargo = @MaxSumWeightCargo)
--Временная таблица для использования информации о терминалах в запросе
SELECT * INTO #TestTable1 FROM Terminals

SELECT Terminals.TerminalTitle AS [Отправляющий Терминал], #TestTable1.TerminalTitle AS [Принимающий терминал], 
SumWeightCargo AS [Суммарный вес груза] FROM #TestTable 
JOIN Terminals ON Terminals.IdTerminal = #TestTable.IdSendingTerminal
JOIN #TestTable1 ON #TestTable1.IdTerminal = #TestTable.IdReceivingTerminal
--Выбор по терминалу отправки с максимальной суммой
WHERE (SumWeightCargo = @MaxSumWeightCargo)  
--Выбор по "ответному терминалу"
	OR (IdReceivingTerminal = @IdSendTerm AND IdSendingTerminal = @IdRecTerm) 
ORDER BY SumWeightCargo DESC

drop table #TestTable
drop table #TestTable1