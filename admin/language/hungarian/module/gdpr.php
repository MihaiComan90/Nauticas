<?php
// Module
$_['text_gdpr']             = 'GDPR';
$_['text_gdpr_settings']             = 'GDPR beállítások';
$_['text_gdpr_report']             = 'GDPR igény történet';

// Heading
$_['heading_title']    = 'GDPR';
$_['module_name'] = 'GDPR';

// Buttons etc.
$_['button_save'] = 'Mentés';
$_['button_cancel'] = 'Mégse';

// Entry
$_['entry_admin']      = 'Csak Admin-ok';
$_['entry_status']     = 'Állapot';
$_['entry_name'] = 'Név';
$_['entry_message_text'] = 'Megjelenítendő üzenet';
$_['entry_date_start'] = 'Kezdő dátum (YYYY-MM-DD)';
$_['entry_date_end'] = 'Befejező dátum (YYYY-MM-DD)';
$_['entry_status'] = 'Állapot';

$_['entry_email_footer'] = 'GDPR Email lábléc szöveg';
$_['entry_email_header'] = 'GDPR Email fejléc szöveg';
$_['entry_locations_of_other_data'] = 'Egyéb hely/szolgáltatás ahol a személyes adatok tárolva vannak';
$_['entry_locations_of_servers'] = 'A weboldal szerverének és az adatok fizikai tárolási helye.';
$_['entry_max_requests_day'] = 'Max igénylés naponta';
$_['entry_pending_status'] = 'Folyamatban állapot szöveg';
$_['entry_confirmed_status'] = 'Visszaigazolt állapot szöveg';
$_['entry_emailed_status'] = 'Email-ben kiküldött állapot szöveg';
$_['entry_account_deleted_status'] = 'Fiók törölve állapot szöveg';
$_['entry_data_sent'] = 'Elküldött adat';
$_['entry_unpaid'] = 'Fizetetlen szöveg';
$_['entry_free'] = 'Ingyen szöveg';
$_['entry_rejected'] = 'Visszautasított szöveg';
$_['entry_fairuse'] = 'Fair felhasználás';
$_['entry_max_days_process'] = 'A válasz adás maximális ideje (nap)';
$_['entry_right_to_be_forgotten'] = 'Az elfeledtetéshez való jog engedélyezése';

// Help
$_['help_pending_status'] = 'A vásárló által még nem visszaigazolt GDPR igény állapot neve. Ez az állapot név fog megjelenni az admin GDPR igény riportban és időrendi sorrendben megmutatja a vásárlónak a GDPR kéréseket.';
$_['help_confirmed_status'] = 'A vásárló által, emailes jováhagyó link segítségével megerősített GDPR igény állapot neve, de a feldolgozás még nem történt meg (a riport email még nem került kiküldésre). Ez az állapot név fog megjelenni az admin GDPR igény riportban és időrendi sorrendben megmutatja a vásárlónak a GDPR kéréseket.';
$_['help_emailed_status'] = 'A befejezett/feldolgozott GDPR igény állapot neve. (A riport email elküldésre került a vásárlónak). Ez az állapot név fog megjelenni az admin GDPR igény riportban és időrendi sorrendben megmutatja a vásárlónak a GDPR kéréseket.';
$_['help_account_deleted_status'] = 'A befejezett/feldolgozott GDPR fiók törlés igény neve. Ez az állapot név fog megjelenni az admin GDPR igény riportban.';
$_['help_locations_of_other_data'] = 'Minden más hely és szolgáltatás felsorolása, ahol a vásárlók személyes adatai tárolva vannak. Pl.: Mailchimp, Google Docs, stb. Ez az információ elküldésre kerül a GDPR riport emailben a vásárlónak.';
$_['help_locations_of_servers'] = 'Minden kapcsolódó információ a tárhelyről és szerver helyéről (Pl.: szerver mely országban van, tárhely szolgáltató, a tárhely szolgáltató GDPR kész (compliant), stb.).';
$_['help_max_requests_day'] = 'A vásárló által kérhető napi igény szám. Ennek célszerű alacsonynak lenni a spam veszély, támadások és fölösleges szerver igénybevétel elkerülése érdekében. Az ajánlott érték 3-5.';
$_['help_right_to_be_forgotten'] = 'Engedélyezésre kerül az \'Elfeledtetéshez való jog\' űrlap ahol a vásárlók automatikusan törölhetik a fiókjukat és személyes adataikat, illetve ahol az nem lehetséges névtelenné tehetik azokat.';

// Error
$_['error_permission'] = 'Figyelem: Nincs jogosultságod a Seasonal Messages modul módosítására!';

// Text
$_['text_module']      = 'Modulok';
$_['text_success']     = 'Sikeresen módosítottad a GDPR modult!';
$_['text_edit']        = 'GDPR Modul szerkesztése';

// Added in v1.4
$_['entry_store_policy_acceptance'] = 'Store Policy Acceptance';
$_['entry_forms_are_private'] = 'GDPR Forms Require Login';

$_['help_store_policy_acceptance'] = 'If set to yes, every time customer accepts your terms on the registration page or in the checkout, this will be recorded in the database. IMPORTANT: if you set it to yes please make sure you checkout is working correctly!';
$_['help_forms_are_private'] = 'If set to yes, GDPR request can only be submitted by a logged in customer.';
