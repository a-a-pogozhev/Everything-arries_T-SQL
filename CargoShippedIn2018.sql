/*	Выбрать список терминалов с указанием массы грузов, которое отправили за 2018 год.	*/

USE EverythingСarries

SELECT Terminals.TerminalTitle as [Название терминала], CargoList.[Weight] as [Масса груза]
FROM CargoList
JOIN Terminals ON Terminals.IdTerminal = CargoList.IdSendingTerminal
WHERE YEAR(CargoList.DepartureDate) = 2018 AND (CargoList.CargoStatus = 'доставлен' OR CargoList.CargoStatus = 'в доставке');