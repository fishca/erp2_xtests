﻿&НаКлиенте
Перем КонтекстЯдра;
&НаКлиенте
Перем Ожидаем;
&НаКлиенте
Перем Утверждения;
&НаКлиенте
Перем ГенераторТестовыхДанных;
&НаКлиенте
Перем ЗапросыИзБД;
&НаКлиенте
Перем УтвержденияПроверкаТаблиц;

&НаКлиенте
Перем Форма;

#Область ЮнитТестирование

&НаКлиенте
Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	
	КонтекстЯдра = КонтекстЯдраПараметр;
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
	Утверждения = КонтекстЯдра.Плагин("БазовыеУтверждения");
	ГенераторТестовыхДанных = КонтекстЯдра.Плагин("СериализаторMXL");
	ЗапросыИзБД = КонтекстЯдра.Плагин("ЗапросыИзБД");
	УтвержденияПроверкаТаблиц = КонтекстЯдра.Плагин("УтвержденияПроверкаТаблиц");
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьНаборТестов(НаборТестов) Экспорт
	НаборТестов.Добавить("ФормированиеСоставаБригад");
КонецПроцедуры

&НаКлиенте
Процедура ПередЗапускомТеста() Экспорт
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗапускаТеста() Экспорт
	
	Попытка
		Форма.Закрыть();
	Исключение
	КонецПопытки;	
	
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура ФормированиеСоставаБригад() Экспорт
	
	Макет = ПолучитьМакет();
	СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоТабличномуДокументу(Макет);
	ПровестиДокумент(СтруктураДанных.ФормированиеСоставаБригады1);
	
	Форма = ПолучитьФорму("Документ.ФормированиеСоставаБригады.ФормаОбъекта",);
	Форма.Открыть();
	
	Реквизиты = ЗначенияРеквизитовОбъекта(СтруктураДанных.ФормированиеСоставаБригады1, "Подразделение, Бригада");
	Форма.Объект.Подразделение = Реквизиты.Подразделение;
	Форма.Объект.Бригада       = Реквизиты.Бригада;
	Форма.Объект.НачалоПериода = ТекущаяДата();
	
	Утверждения.ПроверитьРавенство(Форма.Элементы.Сотрудники_РольИсполнителяРабот.Видимость, Истина, "Нет колонки РольИсполнителяРабот");
	Утверждения.ПроверитьРавенство(Форма.Элементы._ЗаполнитьСостав.Видимость, Истина, "Нет кнопки ЗаполнитьСостав");
	
	Форма._ЗаполнитьСостав(Форма.Элементы._ЗаполнитьСостав);
	Утверждения.ПроверитьРавенство(Форма.Объект.Сотрудники.Количество(), 1, "Не заполнилась ТЧ Сотрдуники");
	
КонецПроцедуры	

&НаСервереБезКонтекста
Процедура ПровестиДокумент(Ссылка)
	
	ДокументОбъект = Ссылка.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры	

&НаСервереБезКонтекста
Функция ЗначенияРеквизитовОбъекта(Ссылка, Реквизиты)
	
	Возврат ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка, Реквизиты);
	
КонецФункции	

&НаСервере
Функция ПолучитьМакет()
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	Возврат ОбработкаОбъект.ПолучитьМакет("Данные");
	
КонецФункции

