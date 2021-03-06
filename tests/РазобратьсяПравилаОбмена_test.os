#использовать "../src/core"
#Использовать asserts
#Использовать logos

Перем юТест;
Перем Лог;
Перем КаталогРаспаковки;

Функция ПолучитьСписокТестов(Знач Тестирование) Экспорт

	юТест = Тестирование;
	
	ИменаТестов = Новый Массив;
	
	ИменаТестов.Добавить("ТестДолжен_ПроверитьРазборкуПравилОбмена");
	ИменаТестов.Добавить("ТестДолжен_ПроверитьРазборкуПравилОбменаССозданиеПараметровДляАлгоритмов");
	
	Возврат ИменаТестов;

КонецФункции

Процедура ПередОкончаниемСценария() Экспорт
	ВременныеФайлы.УдалитьФайл(КаталогРаспаковки);
КонецПроцедуры

Процедура ТестДолжен_ПроверитьРазборкуПравилОбмена() Экспорт
	
	КаталогРаспаковки = ВременныеФайлы.СоздатьКаталог();
	ПутьКФайлуПравила = ТестовыеПравила();

	ОбработчикПравил = Новый ОбработкаПравил();
	ОбработчикПравил.РазложитьПравилаКонвертации(ПутьКФайлуПравила, КаталогРаспаковки);

	МассивФайлов = НайтиФайлы(КаталогРаспаковки, "*.*", Истина);

	Ожидаем.Что(МассивФайлов.Количество(), "Количество файлов должно быть больше 0").Больше(0);

КонецПроцедуры

Процедура ТестДолжен_ПроверитьРазборкуПравилОбменаССозданиеПараметровДляАлгоритмов() Экспорт
	
	Результат = Ложь;

	МассивФайлов = НайтиФайлы(КаталогРаспаковки, "Параметры", Истина);

	Для каждого СтрокаМассива Из МассивФайлов Цикл
		Если СтрокаМассива.ЭтоФайл() Тогда
			Результат = Истина;
		КонецЕсли;	
	КонецЦикла;

	Ожидаем.Что(Результат, "Должен быть файл Параметры").Равно(Истина);

КонецПроцедуры

Функция ТестовыеПравила()
	Возврат ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures","fake-rules.xml");
КонецФункции