/*	Выбрать список терминалов, для которых есть сегодня отмененные грузы. 
Список упорядочить по названию терминала. 	*/

USE EverythingСarries

SELECT TerminalTitle as [Название терминала], TerminalAddress as [Адрес терминала] 
FROM Terminals WHERE IdTerminal IN 
	( 
	SELECT IdSendingTerminal FROM CargoList WHERE IdCargo IN (
	SELECT IdCargo FROM CargoList WHERE 
	(GETDATE() BETWEEN CargoList.DepartureDate AND CargoList.ArrivalDate) AND CargoStatus = 'отменен' )  
    UNION
    SELECT IdReceivingTerminal FROM CargoList WHERE IdCargo IN (
	SELECT IdCargo FROM CargoList WHERE 
	(GETDATE() BETWEEN CargoList.DepartureDate AND CargoList.ArrivalDate) AND CargoStatus = 'отменен' )
    )
    ORDER BY TerminalTitle
	