<?php
// Module
$_['text_gdpr']             = 'RODO';
$_['text_gdpr_settings']             = 'Ustawienia Modułu RODO';
$_['text_gdpr_report']             = 'Historia Wniosków RODO';

// Heading
$_['heading_title']    = 'RODO';
$_['module_name'] = 'RODO';

// Buttons etc.
$_['button_save'] = 'Zapisz';
$_['button_cancel'] = 'Anuluj';

// Entry
$_['entry_admin']      = 'Tylko administratorzy';
$_['entry_status']     = 'Status';
$_['entry_name'] = 'Nazwa';
$_['entry_message_text'] = 'Wiadomość do wyświetlenia';
$_['entry_date_start'] = 'Od (YYYY-MM-DD)';
$_['entry_date_end'] = 'Do (YYYY-MM-DD)';
$_['entry_status'] = 'Status';

$_['entry_email_footer'] = 'Tekst w stopce raportu RODO';
$_['entry_email_header'] = 'Tekst w nagłówku raportu RODO';
$_['entry_locations_of_other_data'] = 'Inne serwisy gdzie przechowywane są dane klientów (np. Mailchimp)';
$_['entry_locations_of_servers'] = 'Lokalizacje serwerowni gdzie przechowywane są dane klientów';
$_['entry_max_requests_day'] = 'Liczba dozwolonych wniosków w jednym dniu';
$_['entry_pending_status'] = 'Nazwa statusu oczekujący';
$_['entry_confirmed_status'] = 'Nazwa statusu potwierdzony';
$_['entry_emailed_status'] = 'Nazwa statusu wysłany';
$_['entry_account_deleted_status'] = 'Nazwa statusu konto usunięte';
$_['entry_data_sent'] = 'Dane wysłane';
$_['entry_rejected'] = 'Nazwa odrzucone';
$_['entry_right_to_be_forgotten'] = 'Enable Right to Be Forgotten Form';

// Help
$_['help_pending_status'] = 'Nazwa statusu wniosku RODO który nie został jeszcze potwierdzony przez użytkownika. Nazwa ta bedzie wyświetlona w raporcie dla admnistratora oraz w raporcie RODO dla użytkownika.';
$_['help_confirmed_status'] = 'Nazwa statusu wniosku RODO który został potwierdzony przez użytkownika ale nie został jeszcze wysłany. Nazwa ta bedzie wyświetlona w raporcie dla admnistratora oraz w raporcie RODO dla użytkownika.';
$_['help_emailed_status'] = 'Nazwa statusu wniosku RODO który został zakończony i wysłany do użytkownika. Nazwa ta bedzie wyświetlona w raporcie dla admnistratora oraz w raporcie RODO dla użytkownika.';
$_['help_account_deleted_status'] = 'Nazwa statusu wniosku RODO o usunięcie konta który został zakonczony (konto użytkonika zostało usunięte). Status ten będzie wyświetlany w raporcie dla admnistratora.';
$_['help_locations_of_other_data'] = 'Lista wszytkich dodatkowych miejsc i serwisów gdzie dane osobowe użytkowników są przechowywane. Przykłady: Mailchimp, Dokumenty Google, Facebook itd. Zawartość tego pola będzię dołączona do raportu RODO wysyłanego do użytkowników.';
$_['help_locations_of_servers'] = 'Lista wszystkich fizyczny lokajizacji gdzie przechowywane są dane osobowe użytkowników oraz powiązane informacje, np. czy serwerownia spełnia wymagania RODO. Zawartość tego pola będzię dołączona do raportu RODO wysyłanego do użytkowników.';
$_['help_max_requests_day'] = 'Liczba wniosków jaką użytkownik może złożyć w ciągu jednego dnia. Liczba ta nie powinna być zbyt wysoka aby uniknąć spamu i nadmiernego obciążenia serwera. Sugerowana maksymalna liczba to 3-5 wniosków na dzień.';
$_['help_right_to_be_forgotten'] = 'This will enable a \'Right to be Forgotten\' form where customers can automatically delete their account and anynymize their personal data where it cannot be deleted';

// Error
$_['error_permission'] = 'Uwaga: nie masz uprawnień aby modyfikować Moduł RODO!';
$_['error_name'] = 'Nazwa jest zbyt krótka, powinna zawierać co najmniej jeden znak!';
$_['error_text'] = 'Tekst wiadomości jest zbyt długi, nie powinien przekraczać 5000 znaków!';
$_['error_date_start'] = 'Data jest nieprawidłowa!';
$_['error_date_end'] = 'Data jest nieprawidłowa!';

// Text
$_['text_module']      = 'Moduły';
$_['text_success']     = 'Sukces: Zmodyfikowałeś Moduł RODO!';
$_['text_edit']        = 'Edytuj Moduł RODO';

// Added in v1.4
$_['entry_store_policy_acceptance'] = 'Rejestruj akceptację regulaminów';
$_['entry_forms_are_private'] = 'Formularze RODO wymagają zalogowania';

$_['help_store_policy_acceptance'] = 'Jeśli wybierzesz TAK, za każdym razem kiedy klient akceptuje regulamin rejestrując konto lub składając zamówienie, treść regulaminu i data jego zatwirdzenia będą zapisywane w bazie danych. !!!UWAGA!!! Jeśli wybierzesz TAK upewnij się że rejestracja nowego konta i proces składania zamówienia działają prawidłowo!';
$_['help_forms_are_private'] = 'Jeśli wybirzesz TAK, wnioski RODO będą mogły być składane tylko przez zalogowanych klientów.';
